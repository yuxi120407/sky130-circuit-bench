* ALU sub-circuit testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15
.param L_xm6=0.15

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0

XM1 N1 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_2 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 LABEL_NET_3 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 GND LABEL_NET_5 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_6 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 GND LABEL_NET_3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Supplies
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8
VLABEL_NET_5 LABEL_NET_5 0 1.8

* Inputs (Evaluate and Precharge)
* 4 GHz -> 250ps period
VLABEL_NET_6 LABEL_NET_6 0 PULSE(1.8 0 25p 10p 10p 75p 250p)
VLABEL_NET_0 LABEL_NET_0 0 PULSE(0 1.8 150p 10p 10p 75p 250p)
VLABEL_NET_2 LABEL_NET_2 0 1.8
VLABEL_NET_4 LABEL_NET_4 0 1.8

* Load capacitance
Cload N1 0 10f

.control
* Transient Analysis
tran 1p 1n

* Measure Delays
meas tran t_rise_delay trig v(LABEL_NET_6) val=0.9 td=200p fall=1 targ v(N1) val=0.9 td=200p rise=1
meas tran t_fall_delay trig v(LABEL_NET_0) val=0.9 td=200p rise=1 targ v(N1) val=0.9 td=200p fall=1

* Measure Average Power
let power = (-i(VVDD) - i(VLABEL_NET_1) - i(VLABEL_NET_5)) * 1.8
meas tran avg_power avg power from=0 to=1n

* DC Operating Point for Leakage
op
let leakage_power = (-i(VVDD) - i(VLABEL_NET_1) - i(VLABEL_NET_5)) * 1.8
print leakage_power

quit
.endc
.end