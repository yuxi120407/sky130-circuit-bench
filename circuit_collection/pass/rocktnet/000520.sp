* Highly Linear CMOS Transconductor Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_LOAD=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmp=0.5

.param W_xm16=5.0 L_xm16=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xmp=5.0 L_xmp=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM16 VDD VREF A GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM9 A A X GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM15 X A X GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM5 X VGM GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM14 N_LS1 VP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM10 Y X N_LS1 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM12 VDD N_LS1 Y GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM11 Y VGM GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XMP AP Y VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp} w={W_xmp}
XM13 AP VREF N_MG1 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM17 N_MG1 AP N_MG1 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM2 N_MG1 VGM GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM8 GND AP GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM18 VP VP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM19 N_EA2 VP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm19} w={W_xm19}
XM7 VP AP N_EA3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM3 N_EA2 VREF N_EA3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N_EA3 VGM GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Sources
VVDD VDD 0 1.8
VVGM VGM 0 0.9
VVREF VREF 0 dc 0.9 ac 1

* Load and Bias Network
* Inductor shorts N_EA2 to 0.9V at DC (for Gm measurement) but acts as open for AC (for Gain measurement)
V_OUT_BIAS N_EA2_DC 0 0.9
L_LOAD N_EA2_DC N_EA2 1G
C_LOAD N_EA2 0 1p

.control
* 1. Operating Point & Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* 2. AC Analysis for Gain, UGF, and Phase Margin
ac dec 100 1 10G
let gain_db = vdb(N_EA2)
let phase = 180/PI * cph(v(N_EA2))
meas ac dc_gain find gain_db at=10
meas ac unity_gain_frequency when gain_db=0 fall=1
meas ac phase_at_ugf find phase when gain_db=0 fall=1
let phase_margin = phase_at_ugf + 360
print phase_margin

* 3. DC Sweep for Transconductance and Linearity
dc VVREF 0 1.8 0.01
* Current from V_OUT_BIAS into the OTA equals the small-signal output current
let iout = -i(V_OUT_BIAS)
let gm = deriv(iout)
meas dc transconductance_gm find gm at=0.9

* Calculate 10% linear range
let gm_90 = transconductance_gm * 0.9
meas dc vref_low when gm=gm_90 rise=1
meas dc vref_high when gm=gm_90 fall=1
let linear_range = vref_high - vref_low
print linear_range

quit
.endc
.end