* 4-PAM Transmitter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=20.0 L_xm1=0.15
.param W_xm2=60.0 L_xm2=0.15
.param W_xm3=60.0 L_xm3=0.15
.param W_xm4=20.0 L_xm4=0.15
.param W_xm5=60.0 L_xm5=0.15
.param W_xm6=60.0 L_xm6=0.15
.param W_xm7=20.0 L_xm7=0.15
.param W_xm8=20.0 L_xm8=0.15

* DUT
XM1 N3 LABEL_NET_2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 LABEL_NET_3 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_4 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 LABEL_NET_5 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_6 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 LABEL_NET_7 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 LABEL_NET_8 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 LABEL_NET_9 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Power and Ground connections
VVDD VDD 0 1.8
VN1 N1 0 0
VN0 N0 0 0
VN2 N2 VDD 0
VN4 N4 VDD 0

* 50-ohm Termination Load
Rload N3 0 50

* Generate 4-PAM staircase (200ps per symbol, 40ps transition)
* Symbol 0 (0-200ps): 0 PMOS ON, 3 NMOS ON
* Symbol 1 (200-400ps): 1 PMOS ON, 2 NMOS ON
* Symbol 2 (400-600ps): 2 PMOS ON, 1 NMOS ON
* Symbol 3 (600-800ps): 3 PMOS ON, 0 NMOS ON

V_L3 LABEL_NET_3 0 PWL(0 1.8 180p 1.8 220p 0 800p 0)
V_L4 LABEL_NET_4 0 PWL(0 1.8 380p 1.8 420p 0 800p 0)
V_L6 LABEL_NET_6 0 PWL(0 1.8 580p 1.8 620p 0 800p 0)
V_L7 LABEL_NET_7 0 DC 1.8

V_L2 LABEL_NET_2 0 PWL(0 1.8 180p 1.8 220p 0 800p 0)
V_L8 LABEL_NET_8 0 PWL(0 1.8 380p 1.8 420p 0 800p 0)
V_L9 LABEL_NET_9 0 PWL(0 1.8 580p 1.8 620p 0 800p 0)
V_L5 LABEL_NET_5 0 DC 0

.control
tran 1p 800p

* Measure the 4 voltage levels
meas tran v_level0 find v(N3) at=100p
meas tran v_level1 find v(N3) at=300p
meas tran v_level2 find v(N3) at=500p
meas tran v_level3 find v(N3) at=700p

* Measure average power
meas tran pwr_avg avg i(VVDD)
let power = -pwr_avg * 1.8
print power

* Measure rise time of the first step (Level 0 to Level 1)
meas tran t_rise trig v(N3) val=0.05 rise=1 targ v(N3) val=0.15 rise=1

quit
.endc
.end