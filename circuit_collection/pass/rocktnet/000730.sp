* Adaptive ENG Amplifier OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_bias1=0.5
.param L_bias2=0.5
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm3=5.0 L_xm3=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm10=5.0 L_xm10=0.5

* DUT
XM3 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM7 IO2 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM6 IO1 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM4 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM2 N5 GND IFI GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM9 IO1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM1 N1 VI IFI GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM10 IO2 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Power Supplies (Dual supply to handle GND at XM2 gate)
VVDD VDD 0 1.8
VVSS VSS 0 -1.8
I_tail IFI VSS 20u

* Input Signal (1mV peak sine at 1kHz + AC 1 for Bode plot)
V_VI VI 0 DC 0 AC 1 SIN(0 1m 1k)

* Output DC Bias and AC Load
* Biasing outputs at 0.9V to keep output transistors in saturation
V_out_bias OUT_BIAS 0 0.9
L_bias1 OUT_BIAS IO1 1G
C_load1 IO1 0 10p
L_bias2 OUT_BIAS IO2 1G
C_load2 IO2 0 10p

.control
* 1. DC Operating Point & Power
op
let power_dissipation = (-i(VVDD) * 1.8) + (i(VVSS) * 1.8)
print power_dissipation

* 2. AC Analysis
ac dec 100 1 100MEG
let gain_db = vdb(IO1)
let phase = 180/PI * cph(v(IO1))

meas ac voltage_gain find gain_db at=1k
meas ac unity_gain_frequency when gain_db=0 fall=1
meas ac phase_at_ugf find phase when gain_db=0 fall=1
let phase_margin = phase_at_ugf + 360
print phase_margin

* 3. Transient Analysis
tran 10u 5m
meas tran v_out_max max v(IO1)
meas tran v_out_min min v(IO1)
let v_out_ptp = v_out_max - v_out_min
print v_out_ptp

quit
.endc
.end