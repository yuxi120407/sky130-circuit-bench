* QVCO Active Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
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
.param L_xm20=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm19=5.0
.param W_xm20=5.0

XM1 GND LABEL_NET_0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 LABEL_NET_1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 GND LABEL_NET_4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 LABEL_NET_5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N4 LABEL_NET_6 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N3 LABEL_NET_7 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N3 N3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N4 N4 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N5 N4 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N1 LABEL_NET_8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 N1 N3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N2 LABEL_NET_9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XM19 N0 LABEL_NET_10 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 N5 LABEL_NET_11 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}

* DC Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9 ac 1 sin(0.9 0.1 1G)
VLABEL_NET_4 LABEL_NET_4 0 0.9
VLABEL_NET_5 LABEL_NET_5 0 0.9
VLABEL_NET_6 LABEL_NET_6 0 0.9
VLABEL_NET_7 LABEL_NET_7 0 0.9
VLABEL_NET_8 LABEL_NET_8 0 0.9
VLABEL_NET_9 LABEL_NET_9 0 0.9
VLABEL_NET_10 LABEL_NET_10 0 0.9
VLABEL_NET_11 LABEL_NET_11 0 0.9

* Bias for floating gates
VN6 N6 0 0.9
VN7 N7 0 0.9

* High-value resistor to prevent floating node errors on N5 (only connected to MOS caps and source of XM14)
R_N5 N5 0 1G

.control
* 1. DC Operating Point & Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* 2. AC Analysis for Gain
ac dec 10 1M 100G
let gain_db = db(v(N3))
meas ac ac_gain MAX gain_db
print ac_gain

* 3. Transient Analysis for Voltage Swing
tran 1p 5n
meas tran v_max max v(N3)
meas tran v_min min v(N3)
let voltage_swing = v_max - v_min
print voltage_swing

quit
.endc
.end