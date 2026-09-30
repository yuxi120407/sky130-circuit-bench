* Folded Downconversion Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

* DUT
XM1 F_MINUS RFIN_N GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 F_PLUS N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 F_MINUS N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 F_PLUS RFIN_P GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUT F_PLUS F_MINUS VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT LO_P F_PLUS VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 OUT LO_N F_PLUS VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 OUT LO_N F_MINUS VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Biasing and Sources
VVDD VDD 0 1.8
VN3 N3 0 0.6
VRF_bias RF_BIAS 0 0.6
VLO_bias LO_BIAS 0 0.6

* LO signals (5.24 GHz)
VLO_P LO_P LO_BIAS dc 0 sin(0 0.5 5.24G)
VLO_N LO_N LO_BIAS dc 0 sin(0 0.5 5.24G 0 0 180)

* RF signals (5.25 GHz)
VRF_P RFIN_P RF_BIAS dc 0 sin(0 0.01 5.25G)
VRF_N RFIN_N RF_BIAS dc 0 sin(0 0.01 5.25G 0 0 180)

* IF Load (Low pass filter for 10 MHz IF)
RL OUT GND 1k
CL OUT GND 1p

.control
* Transient analysis for 5 IF cycles (10 MHz -> 100ns period)
tran 10p 500n

* Measure power consumption
meas tran I_vdd avg i(VVDD) from=200n to=500n
let power = -I_vdd * 1.8
print power

* Measure Conversion Gain
meas tran vout_max max v(out) from=200n to=500n
meas tran vout_min min v(out) from=200n to=500n
let vout_amp = (vout_max - vout_min) / 2
let cg = vout_amp / 0.01
let cg_db = 20 * log10(cg + 1e-15)
print cg_db

quit
.endc
.end
