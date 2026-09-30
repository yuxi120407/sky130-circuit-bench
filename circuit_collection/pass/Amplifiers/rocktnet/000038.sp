* Cascode Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 LABEL_NET_0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 VDD N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Power Supply
VVDD VDD 0 1.8

* Biasing and Inputs
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_0 LABEL_NET_0 0 dc 0.9 ac 1 sin(0.9 10m 1Meg)

* Robust DC Biasing for PMOS Load (Diode-connected at DC, Current Source at AC)
Lbias N3 N1 1000H
Cac N1 0 100m

* Load Capacitance
CL N3 0 10f

.control
* 1. DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power
print v(N3)

* 2. AC Analysis for Gain and Bandwidth
ac dec 100 1k 10G
let gain_db = vdb(N3)
meas ac max_gain max gain_db
meas ac bw_freq when gain_db=(max_gain-3) fall=1

* 3. Transient Analysis
tran 1n 2u
meas tran vout_pp pp v(N3)
meas tran vout_max max v(N3)
meas tran vout_min min v(N3)

quit
.endc
.end