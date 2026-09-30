* Testbench for Burst-Mode Receiver Differential Stage
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM4 VDD N2 OUT1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM3 VDD N1 OUT2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM1 N1 IN1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 IN2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Biasing components (added to complete the circuit)
R1 VDD N1 2k
R2 VDD N2 2k
I_tail N4 0 0.5m
I_out1 OUT1 0 0.5m
I_out2 OUT2 0 0.5m

* Power supply
VVDD VDD 0 1.8

* Inputs (DC common-mode = 1.2V, AC diff = 1V, Tran diff = 0.4Vpp)
VIN1 IN1 0 DC 1.2 AC 0.5 SIN(1.2 0.1 100MEG 0 0)
VIN2 IN2 0 DC 1.2 AC -0.5 SIN(1.2 -0.1 100MEG 0 0)

* Differential output voltage controlled voltage source
E_diff OUT_DIFF 0 OUT1 OUT2 1.0

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.control
* 1. DC Operating Point & Power
op
print v(OUT1) v(OUT2) v(N1) v(N2) v(N4)
let power = -i(VVDD) * 1.8
print power

* 2. AC Analysis (Gain and Bandwidth)
ac dec 20 1Meg 10G
meas ac max_gain max vdb(OUT_DIFF)
meas ac bw when vdb(OUT_DIFF)='max_gain - 3' fall=1

* 3. Transient Analysis (Output Swing)
tran 0.1n 20n
meas tran vout_diff_max max v(OUT_DIFF)
meas tran vout_diff_min min v(OUT_DIFF)
let vout_swing = vout_diff_max - vout_diff_min
print vout_swing

quit
.endc
.end
