* Frequency Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm11=0.5
.param L_xml1=0.5
.param L_xml2=0.5
.param L_xml3=0.5
.param L_xml4=0.5
.param L_xml5=0.5
.param L_xml6=0.5
.param L_xml7=0.5
.param L_xml8=0.5
.param L_xml9=0.5
.param L_xmr2=0.5
.param L_xmr3=0.5
.param L_xmr4=0.5
.param L_xmr5=0.5
.param L_xmr6=0.5
.param L_xmr7=0.5
.param L_xmr8=0.5
.param L_xmr9=0.5

.param W_xml8=5.0 L_xml8=0.5
.param W_xmr5=5.0 L_xmr5=0.5
.param W_xmr6=5.0 L_xmr6=0.5
.param W_xml7=5.0 L_xml7=0.5
.param W_xmr3=5.0 L_xmr3=0.5
.param W_xml3=5.0 L_xml3=0.5
.param W_xml1=5.0 L_xml1=0.5
.param W_xmr8=5.0 L_xmr8=0.5
.param W_xmr2=5.0 L_xmr2=0.5
.param W_xml5=5.0 L_xml5=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xml2=5.0 L_xml2=0.5
.param W_xmr4=5.0 L_xmr4=0.5
.param W_xml4=5.0 L_xml4=0.5
.param W_xml6=5.0 L_xml6=0.5
.param W_xml9=5.0 L_xml9=0.5
.param W_xmr7=5.0 L_xmr7=0.5
.param W_xmr9=5.0 L_xmr9=0.5

VVDD VDD 0 1.8
VGND GND 0 0

* Clocks: CLKN is reset/reference (10MHz), CLKP is fast input (100MHz)
VCLKP CLKP 0 PULSE(0 1.8 0 100p 100p 4.9n 10n)
VCLKN CLKN 0 PULSE(0 1.8 0 100p 100p 49.9n 100n)

* DUT
XML8 N5 N11 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xml8} w={W_xml8}
XMR5 N8 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xmr5} w={W_xmr5}
XMR6 N11 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xmr6} w={W_xmr6}
XML7 N1 N11 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xml7} w={W_xml7}
XMR3 N12 CLKN GND GND sky130_fd_pr__nfet_01v8 l={L_xmr3} w={W_xmr3}
XML3 N14 CLKP GND GND sky130_fd_pr__nfet_01v8 l={L_xml3} w={W_xml3}
XML1 N14 CLKP GND GND sky130_fd_pr__nfet_01v8 l={L_xml1} w={W_xml1}
XMR8 N11 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmr8} w={W_xmr8}
XMR2 N12 CLKN N3 VDD sky130_fd_pr__pfet_01v8 l={L_xmr2} w={W_xmr2}
XML5 N13 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xml5} w={W_xml5}
XM11 N8 CLKN N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XML2 N14 CLKP N1 VDD sky130_fd_pr__pfet_01v8 l={L_xml2} w={W_xml2}
XMR4 N8 N3 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xmr4} w={W_xmr4}
XML4 N13 N1 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xml4} w={W_xml4}
XML6 N5 N13 GND GND sky130_fd_pr__nfet_01v8 l={L_xml6} w={W_xml6}
XML9 VOUT N11 N5 N5 sky130_fd_pr__pfet_01v8 l={L_xml9} w={W_xml9}
XMR7 N3 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmr7} w={W_xmr7}
XMR9 VOUT N5 N11 N11 sky130_fd_pr__pfet_01v8 l={L_xmr9} w={W_xmr9}

* Load for VOUT to prevent floating states
C_vout VOUT 0 10f
R_vout VOUT 0 100MEG

.control
tran 100p 200n

* Measure Power
meas tran pwr avg i(VVDD)
let power_uw = -pwr * 1.8 * 1e6
print power_uw

* Measure Integration Node Drops
meas tran v_n1_min min v(N1)
meas tran v_n3_min min v(N3)

* Measure Output Swing
meas tran v_out_max max v(VOUT)
meas tran v_out_min min v(VOUT)

* Measure Reset Delay
meas tran delay_reset trig v(CLKN) val=0.9 fall=1 targ v(N11) val=0.9 fall=1

quit
.endc
.end