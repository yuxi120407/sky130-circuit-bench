* Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5

* DUT
XM1 VOUT_P VIN_P N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT_N VIN_N N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT_P N8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT_N N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM6 N5 VIN_P N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM5 N7 VIN_N N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM7 VOUT_P N7 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 VOUT_N N5 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N10 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N7 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

* Missing connections inferred from standard delay cell topologies
* 1. Tail current source for the feedforward pair (N3)
XM13 N3 VBIAS GND GND sky130_fd_pr__nfet_01v8 l=0.5 w=5.0
* 2. Diode-connecting the PMOS loads to ensure saturation and stable gain
R8 N8 VOUT_P 1m
R6 N6 VOUT_N 1m

* Sources
VVDD VDD 0 1.8
VVBIAS VBIAS 0 0.8

* Combined AC and Transient Input Sources
VVIN_P VIN_P 0 DC 0.9 AC 0.5 PULSE(0.8 1.0 100p 50p 50p 400p 1n)
VVIN_N VIN_N 0 DC 0.9 AC -0.5 PULSE(1.0 0.8 100p 50p 50p 400p 1n)

.control
* 1. DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* 2. AC Analysis for Gain and Bandwidth
ac dec 100 1Meg 100G
let vout_diff = v(VOUT_P) - v(VOUT_N)
let gain_db = vdb(vout_diff)
meas ac dc_gain find gain_db at=1Meg
meas ac bw_3db when gain_db=(dc_gain-3) fall=1

* 3. Transient Analysis for Propagation Delay
tran 1p 3n
let vout_diff_tran = v(VOUT_P) - v(VOUT_N)
let vin_diff_tran = v(VIN_P) - v(VIN_N)
* The main path is inverting, so a rising input causes a falling output
meas tran delay_rise trig vin_diff_tran val=0 rise=2 targ vout_diff_tran val=0 fall=2
meas tran delay_fall trig vin_diff_tran val=0 fall=2 targ vout_diff_tran val=0 rise=2
let avg_delay = (delay_rise + delay_fall) / 2
print avg_delay

quit
.endc
.end
