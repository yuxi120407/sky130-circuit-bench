* Class-AB Pre-driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VN0 N0 0 0
VN2 N2 0 dc 0.7 ac 1 sin(0.7 0.1 5Meg)

XM1 N1 N2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 LABEL_NET_1 N2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 LABEL_NET_2 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

.control
* DC Analysis for Power
op
let pwr = -i(VVDD)*1.8
print pwr

* AC Analysis for Gm and Bandwidth
ac dec 20 1k 10G
let gm1_mag = mag(i(VLABEL_NET_1))
let gm2_mag = mag(i(VLABEL_NET_2))
meas ac gm1_lowfreq find gm1_mag at=10k
meas ac gm2_lowfreq find gm2_mag at=10k

let gm1_3db = gm1_lowfreq * 0.7071
let gm2_3db = gm2_lowfreq * 0.7071
meas ac bw1 when gm1_mag=gm1_3db fall=1
meas ac bw2 when gm2_mag=gm2_3db fall=1

* Transient Analysis for Swing
tran 1n 1u
meas tran iout1_max max i(VLABEL_NET_1)
meas tran iout1_min min i(VLABEL_NET_1)
let iout1_pp = iout1_max - iout1_min
print iout1_pp

meas tran iout2_max max i(VLABEL_NET_2)
meas tran iout2_min min i(VLABEL_NET_2)
let iout2_pp = iout2_max - iout2_min
print iout2_pp

quit
.endc
.end
