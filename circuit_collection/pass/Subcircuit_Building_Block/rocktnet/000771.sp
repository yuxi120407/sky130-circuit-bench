* Charge Pump Bias Network Testbench
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

VVDD VDD 0 1.8
V0 LABEL_NET_0 0 1.8
V1 LABEL_NET_1 0 1.8
V2 LABEL_NET_2 0 1.8
V3 LABEL_NET_3 0 1.8
V6 LABEL_NET_6 0 1.8

XM1 N3 N3 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N1 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N8 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N2 LABEL_NET_2 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N9 N1 LABEL_NET_3 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N9 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N8 N7 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N7 N7 LABEL_NET_6 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Bias sources
I1 N1 0 DC 50u AC 1
I3 N3 0 DC 50u
I8 VDD N8 DC 50u
I7 N7 0 DC 10u
I2 N2 0 DC 10u

* Output voltage source to measure current
VOUT N9 0 DC 0.9

.control
* 1. Operating Point for Power
op
let total_current = -i(VVDD) - i(V0) - i(V1) - i(V2) - i(V3) - i(V6)
let power = total_current * 1.8
print power

* 2. AC Analysis for Bandwidth
ac dec 20 1k 100G
let gain_mag = 20*log10(mag(i(VOUT)))
meas ac bw_3db when gain_mag=-3 fall=1
print bw_3db

* 3. DC Sweep for Output Impedance
dc VOUT 0 1.8 0.01
meas dc i1 find i(VOUT) at=0.89
meas dc i2 find i(VOUT) at=0.91
let rout = -0.02 / (i2 - i1)
print rout

quit
.endc
.end
