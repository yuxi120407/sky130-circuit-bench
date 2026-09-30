* Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15
.param L_xm6=0.15
.param L_xm7=0.15
.param L_xm8=0.15
.param L_xm9=0.15
.param L_xm10=0.15
.param L_xm11=0.15

.param W_xm1=4.0
.param W_xm2=4.0
.param W_xm3=4.0
.param W_xm4=4.0
.param W_xm5=1.0
.param W_xm6=4.0
.param W_xm7=1.0
.param W_xm8=2.0
.param W_xm9=4.0
.param W_xm10=2.0
.param W_xm11=1.0

* Supplies and Bias
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0
VLABEL_NET_1 LABEL_NET_1 0 0
VLABEL_NET_2 LABEL_NET_2 0 0

* Inputs (Small differential signal around 0.9V common mode)
VINP N0 0 PWL(0 0.89 200p 0.89 220p 0.95)
VINN N1 0 PWL(0 0.91 200p 0.91 220p 0.85)

* Clock Signal (1 GHz)
VCLK N3 0 PULSE(0 1.8 200p 20p 20p 400p 1000p)

* DUT
XM1 N5 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N5 N1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N6 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N5 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 N0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N6 LABEL_NET_2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

* Load Capacitances
C1 N2 0 10f
C2 N5 0 10f

.control
tran 1p 2000p

* Measure Delays
meas tran delay_clk_to_out trig v(N3) val=0.9 rise=1 targ v(N5) val=0.9 rise=1
print delay_clk_to_out

* Measure Voltage Swing
meas tran v_outn_min min v(N2)
meas tran v_outp_max max v(N5)
let voltage_swing = v_outp_max - v_outn_min
print voltage_swing

* Measure Power
meas tran current_avg avg i(VVDD)
let power_avg = -current_avg * 1.8
print power_avg

quit
.endc
.end