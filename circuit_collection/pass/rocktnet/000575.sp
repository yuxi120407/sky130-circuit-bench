* DAC Cell Testbench
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

* Supplies and Biases
VVDD VDD 0 1.8
V_N12 VDD N12 0
V_L0 VDD LABEL_NET_0 0
V_N7 N7 0 0
VLABEL_NET_1 LABEL_NET_1 0 1.0
VLABEL_NET_2 LABEL_NET_2 0 0.8
VLABEL_NET_3 LABEL_NET_3 0 0
VLABEL_NET_4 LABEL_NET_4 0 0
VLABEL_NET_5 LABEL_NET_5 0 0
VLABEL_NET_6 LABEL_NET_6 0 0

* Differential Inputs
VINP N8 0 PULSE(0 1.8 1n 100p 100p 4n 8n)
VINN N9 0 PULSE(1.8 0 1n 100p 100p 4n 8n)

* Output Loads
R1 N5 0 10k
R2 N11 0 10k

* DUT
XM1 N6 N0 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N8 N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N8 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N9 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N10 N1 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N5 N0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N11 N1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N9 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 LABEL_NET_1 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 LABEL_NET_2 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 LABEL_NET_3 LABEL_NET_4 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N8 LABEL_NET_6 LABEL_NET_5 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

.control
tran 10p 20n

* Define differential signals
let vdiff_in = v(N8) - v(N9)
let vdiff_latch = v(N0) - v(N1)
let vdiff_out = v(N5) - v(N11)

* Measure Cell Current
meas tran vout_avg avg v(N5) from=11n to=12n
let i_cell = vout_avg / 10000
print i_cell

* Measure Delay and Crossing Voltage
meas tran t_in_cross when vdiff_in=0 cross=1 td=8n
meas tran t_latch_cross when vdiff_latch=0 cross=1 td=8n
meas tran v_cross_latch find v(N0) at=t_latch_cross
meas tran t_out_cross when vdiff_out=0 cross=1 td=8n
let t_delay = t_out_cross - t_in_cross
print t_delay
print v_cross_latch

* Measure Power
meas tran pwr_avg avg i(VVDD)
let power = -pwr_avg * 1.8
print power

quit
.endc
.end