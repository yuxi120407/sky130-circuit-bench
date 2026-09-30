* DFE Summer/Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
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

XM1 GND GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 GND CK2 GND VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 GND LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 GND CK2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 GND LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 GND LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 GND OFFSET N1 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 CK2 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 GND DATA GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 GND CK2 GND VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 GND CK1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 GND GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 GND H3_14 GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 GND GND CK2 VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}

* Voltage Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VOFFSET OFFSET 0 0.9
VH3_14 H3_14 0 0.9

* High-speed Clocks and Data (28Gbps -> ~35ps UI)
VDATA DATA 0 pulse(0 1.8 0 5p 5p 30p 70p)
VCK1 CK1 0 pulse(0 1.8 0 5p 5p 17.5p 35p)
VCK2 CK2 0 pulse(1.8 0 0 5p 5p 17.5p 35p)

.control
save all
* DC Operating Point for Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* Transient Analysis
tran 1p 200p
let vdd_current = -i(VVDD)
meas tran peak_transient_current MAX vdd_current
print peak_transient_current

.endc
.end