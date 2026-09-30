* CML Latch / Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm11=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm18=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm22=0.5
.param L_xm3=0.5
.param L_xm9=0.5
.param L_xmb1=0.5
.param L_xmb2=0.5
.param L_xmb3=0.5
.param L_xmb4=0.5
.param L_xmb5=0.5
.param L_xmb7=0.5
.param L_xmb8=0.5
.param L_xmc1=0.5
.param L_xmc2=0.5
.param L_xmc3=0.5
.param L_xmc4=0.5
.param L_xmc6=0.5

* DUT
.param W_xmb3=5.0 L_xmb3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xmb4=5.0 L_xmb4=0.5
.param W_xmb5=5.0 L_xmb5=0.5
.param W_xmc1=5.0 L_xmc1=0.5
.param W_xmb2=5.0 L_xmb2=0.5
.param W_xmb1=5.0 L_xmb1=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xmc4=5.0 L_xmc4=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xmc2=5.0 L_xmc2=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xmb8=5.0 L_xmb8=0.5
.param W_xmb7=5.0 L_xmb7=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xmc3=5.0 L_xmc3=0.5
.param W_xm20=5.0 L_xm20=0.5
.param W_xmc6=5.0 L_xmc6=0.5
.param W_xm22=5.0 L_xm22=0.5

XMB3 N16 N23 VSS GND sky130_fd_pr__nfet_01v8 l={L_xmb3} w={W_xmb3}
XM2 OUTP N14 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N19 LABEL_NET_0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XMB4 N6 N25 VSS GND sky130_fd_pr__nfet_01v8 l={L_xmb4} w={W_xmb4}
XMB5 N8 N22 VSS GND sky130_fd_pr__nfet_01v8 l={L_xmb5} w={W_xmb5}
XMC1 N7 N9 N6 GND sky130_fd_pr__nfet_01v8 l={L_xmc1} w={W_xmc1}
XMB2 N4 N24 VSS GND sky130_fd_pr__nfet_01v8 l={L_xmb2} w={W_xmb2}
XMB1 N15 N24 VSS GND sky130_fd_pr__nfet_01v8 l={L_xmb1} w={W_xmb1}
XM9 OUTP OUTP N5 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XMC4 N5 N0 N8 GND sky130_fd_pr__nfet_01v8 l={L_xmc4} w={W_xmc4}
XM11 N19 LABEL_NET_1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XMC2 N2 N11 N6 GND sky130_fd_pr__nfet_01v8 l={L_xmc2} w={W_xmc2}
XM13 OUTP OUTP N5 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 OUTP N19 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N19 INP N7 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XMB8 N3 N21 N16 GND sky130_fd_pr__nfet_01v8 l={L_xmb8} w={W_xmb8}
XMB7 N17 N17 N4 GND sky130_fd_pr__nfet_01v8 l={L_xmb7} w={W_xmb7}
XM18 N9 CLKP N3 GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XMC3 N1 N18 N8 GND sky130_fd_pr__nfet_01v8 l={L_xmc3} w={W_xmc3}
XM20 N19 INM N7 GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}
XMC6 N24 N17 N15 GND sky130_fd_pr__nfet_01v8 l={L_xmc6} w={W_xmc6}
XM22 N11 N9 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm22} w={W_xm22}

* Missing Pull-up Resistors (Typical for CML)
R1 N19 VDD 1k
R2 OUTP VDD 1k
R3 N9 VDD 1k
R4 N11 VDD 1k

* Power Supplies
VVDD VDD 0 1.8
VVSS VSS 0 0

* Bias Voltages
VB23 N23 0 0.7
VB25 N25 0 0.7
VB22 N22 0 0.7
VB24 N24 0 0.7
VB21 N21 0 0.7
VB0 N0 0 1.2
VB18 N18 0 1.2
VB14 N14 0 1.2
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9

* High-Speed Inputs (1.25 GHz)
VINP INP 0 PULSE(0.6 1.2 0 50p 50p 350p 800p)
VINM INM 0 PULSE(1.2 0.6 0 50p 50p 350p 800p)
VCLKP CLKP 0 PULSE(0.6 1.2 200p 50p 50p 350p 800p)

* Analysis
.control
tran 5p 5n

* 1. Power Consumption
meas tran power_avg avg i(VVDD)
let power_mw = -power_avg * 1.8 * 1000
print power_mw

* 2. Voltage Swing
meas tran v_max max v(OUTP) from=2n to=5n
meas tran v_min min v(OUTP) from=2n to=5n
let v_swing = v_max - v_min
print v_swing

* 3. Propagation Delay
meas tran t_in_cross trig v(INP) val=0.9 rise=3
meas tran t_out_cross targ v(OUTP) val=0.9 fall=3
let delay_ps = (t_out_cross - t_in_cross) * 1e12
print delay_ps

quit
.endc
.end