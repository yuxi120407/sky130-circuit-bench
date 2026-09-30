* CAM Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=1.0 L_xm1=0.15
.param W_xm2=1.0 L_xm2=0.15
.param W_xm3=1.0 L_xm3=0.15
.param W_xm4=1.0 L_xm4=0.15
.param W_xm5=1.0 L_xm5=0.15
.param W_xm6=2.0 L_xm6=0.15
.param W_xm7=1.0 L_xm7=0.15
.param W_xm8=1.0 L_xm8=0.15
.param W_xm9=1.0 L_xm9=0.15
.param W_xm10=2.0 L_xm10=0.15
.param W_xm11=0.5 L_xm11=0.15
.param W_xm12=0.5 L_xm12=0.15

* DUT
XM1 N1 N8 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N5 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N8 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N7 N5 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N8 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N8 LABEL_NET_0 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 LABEL_NET_1 LABEL_NET_2 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 N8 LABEL_NET_3 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N8 N5 LABEL_NET_4 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

* Supplies
VVDD VDD 0 1.8
VLABEL_NET_3 LABEL_NET_3 0 1.8
VLABEL_NET_4 LABEL_NET_4 0 1.8

* Wordlines
VWL LABEL_NET_2 0 PULSE(0 1.8 1n 0.1n 0.1n 4n 40n)
VWL_dummy LABEL_NET_0 0 PULSE(0 1.8 1n 0.1n 0.1n 4n 40n)

* Bitline (Write '0' to Q)
VBL LABEL_NET_1 0 PWL(0 0 40n 0)

* Search Lines (Search for '1' -> Mismatch since Q='0')
VSL N1 0 PULSE(0 1.8 10n 0.1n 0.1n 10n 40n)
VSLB N6 0 0

* Matchline Precharge
Mpre N3 pre_b VDD VDD sky130_fd_pr__pfet_01v8 l=0.15 w=2.0
Vpre pre_b 0 PULSE(0 1.8 8n 0.1n 0.1n 1n 40n)

* Matchline Load Capacitance (from paper)
Cml N3 0 0.25p

* Initial condition to ensure deterministic write
.ic v(N5)=1.8 v(N8)=0

.tran 10p 30n

.control
run
meas tran write_delay trig v(LABEL_NET_2) val=0.9 rise=1 targ v(N5) val=0.9 fall=1
meas tran search_delay trig v(N1) val=0.9 rise=1 targ v(N3) val=0.9 fall=1
let pwr = -i(VVDD)*1.8 - i(VLABEL_NET_3)*1.8 - i(VLABEL_NET_4)*1.8
meas tran avg_power avg pwr from=10n to=20n
print write_delay search_delay avg_power
quit
.endc
.end
