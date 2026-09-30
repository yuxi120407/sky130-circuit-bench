* Testbench for Error Amplifier
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
.param L_xm21=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm6=5.0 L_xm6=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm21=5.0 L_xm21=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm20=5.0 L_xm20=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5

XM6 N5 LABEL_NET_0 VOUT VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM5 N6 LABEL_NET_1 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM4 N0 LABEL_NET_2 VOUT VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM12 N6 LABEL_NET_3 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM1 N7 VOUT VOUT VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM3 N0 LABEL_NET_4 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM2 N3 LABEL_NET_5 VOUT VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM7 N1 LABEL_NET_6 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM11 N7 LABEL_NET_7 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM21 N0 LABEL_NET_9 LABEL_NET_8 GND sky130_fd_pr__nfet_01v8 l={L_xm21} w={W_xm21}
XM10 N4 LABEL_NET_10 VOUT VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM16 N0 LABEL_NET_8 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM9 N6 LABEL_NET_11 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM18 N1 LABEL_NET_12 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XM15 N0 LABEL_NET_13 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM8 N1 LABEL_NET_14 VOUT VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM17 N1 LABEL_NET_15 LABEL_NET_11 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM20 N7 LABEL_NET_17 LABEL_NET_16 GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}
XM19 N1 LABEL_NET_18 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM13 N3 LABEL_NET_19 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N3 LABEL_NET_20 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

* Voltage Sources
VVDD VDD 0 1.8
VN6 N6 0 0
VVOUT VOUT 0 1.8

* Biasing and Inputs
VLABEL_NET_0 LABEL_NET_0 0 0.8
VLABEL_NET_1 LABEL_NET_1 0 1.8
VLABEL_NET_3 LABEL_NET_3 0 1.8
VLABEL_NET_4 LABEL_NET_4 0 1.8
VLABEL_NET_6 LABEL_NET_6 0 1.8
VLABEL_NET_7 LABEL_NET_7 0 1.8
VLABEL_NET_8 LABEL_NET_8 0 0.9
VLABEL_NET_9 LABEL_NET_9 0 1.5
VLABEL_NET_11 LABEL_NET_11 0 0.9
VLABEL_NET_12 LABEL_NET_12 0 1.6
VLABEL_NET_13 LABEL_NET_13 0 0
VLABEL_NET_14 LABEL_NET_14 0 1.2
VLABEL_NET_15 LABEL_NET_15 0 1.5
VLABEL_NET_16 LABEL_NET_16 0 0
VLABEL_NET_17 LABEL_NET_17 0 0
VLABEL_NET_18 LABEL_NET_18 0 1.6
VLABEL_NET_19 LABEL_NET_19 0 0
VLABEL_NET_20 LABEL_NET_20 0 1.6

* Current Mirror Connections
V_mirror1 LABEL_NET_10 N4 0
V_mirror2 LABEL_NET_5 N4 0

* DC Feedback and AC Stimulus
L_fb N3 LABEL_NET_2 1G
C_ac LABEL_NET_2_AC LABEL_NET_2 1G
VAC LABEL_NET_2_AC 0 dc 0 ac 1 sin(0 10m 1Meg)

* Load Capacitor
CLOAD N3 0 100f

.control
* DC Operating Point
op
let dc_power = (-i(VVDD) - i(VVOUT)) * 1.8
print dc_power

* AC Analysis
ac dec 100 10 1G
let gain_db = vdb(N3)
meas ac ac_gain find gain_db at=10
meas ac bandwidth when gain_db=0 fall=1
print ac_gain
print bandwidth

* Transient Analysis
tran 1n 2u
meas tran v_out_max max v(N3)
meas tran v_out_min min v(N3)
print v_out_max
print v_out_min

quit
.endc
.end