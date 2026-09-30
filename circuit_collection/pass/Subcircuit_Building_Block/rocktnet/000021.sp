* QVCO Coupling Network Testbench
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
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5

VVDD VDD 0 1.8
VN6 N6 0 0.9
VN4 N4 0 0.9
VN11 N11 0 0.9
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9

* Force DC operating point for high-impedance nodes N0 and N1
VN0_bias N0_bias 0 0.9
VN1_bias N1_bias 0 0.9
LN0 N0_bias N0 1
LN1 N1_bias N1 1

* AC current source for impedance measurement
I_AC N1 0 dc 0 ac 1

* DUT
XM1 N1 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 LABEL_NET_1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 N1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N1 N1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N2 N11 GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N0 N1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N1 N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 N1 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm17} w={W_xm17}
XM18 N1 N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 100 1G 100G
let z11_db = vdb(N1)
let z21_db = vdb(N0)

meas ac z11_60G find z11_db at=60G
meas ac z21_60G find z21_db at=60G
quit
.endc
.end