* SER-Tolerant Latch Testbench
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
.param L_xm22=0.5
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
.param W_xm19=5.0 L_xm19=0.5
.param W_xm20=5.0 L_xm20=0.5
.param W_xm21=5.0 L_xm21=0.5
.param W_xm22=5.0 L_xm22=0.5

XM1 GND CK GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND N0B GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 GND GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VDD GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N0B GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 GND N0A GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VDD N0B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0B N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 GND N0A VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 Q GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 GND CK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 VDD N2 GND VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 GND GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 D GND N0A VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 GND GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 GND N1A GND GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 GND VDD GND VDD sky130_fd_pr__pfet_01v8 l={L_xm17} w={W_xm17}
XM18 GND N0B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM19 D GND N0B VDD sky130_fd_pr__pfet_01v8 l={L_xm19} w={W_xm19}
XM20 N0B GND N5 GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}
XM21 D GND N0B GND sky130_fd_pr__nfet_01v8 l={L_xm21} w={W_xm21}
XM22 D GND N0A GND sky130_fd_pr__nfet_01v8 l={L_xm22} w={W_xm22}

VVDD VDD 0 1.8
VCK CK 0 PWL(0 0 100p 1.8 2.1n 1.8 2.2n 0 4n 0 4.1n 1.8 6.1n 1.8 6.2n 0 8n 0 8.1n 1.8 10.1n 1.8 10.2n 0 14n 0 14.1n 1.8 20n 1.8)
VD D 0 PWL(0 0 1n 0 1.1n 1.8 5.1n 1.8 5.2n 0 9n 0 9.1n 1.8 13.1n 1.8 13.2n 0 14n 0 14.1n 1.8 20n 1.8)

* Prevent floating nodes to avoid ngspice matrix singularities
R_Q Q 0 1G
R_N1A N1A 0 1G
R_N5 N5 0 1G

.ic v(N0B)=0 v(N2)=1.8

.control
tran 10p 20n
meas tran avg_current avg i(VVDD) from=0 to=10n
let dynamic_power = -avg_current * 1.8
meas tran leak_current avg i(VVDD) from=15n to=20n
let leakage_power = -leak_current * 1.8
meas tran propagation_delay trig v(D) val=0.9 rise=1 targ v(N0B) val=0.9 rise=1
print dynamic_power leakage_power propagation_delay
quit
.endc
.end