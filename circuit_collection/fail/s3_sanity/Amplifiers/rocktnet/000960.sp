* Modulator Driver Testbench

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

* DUT
XM1 N33 LABEL_NET_0 N34 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N9 N17 N19 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N9 N23 N20 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N34 N21 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N22 N23 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N32 N18 N26 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N15 N32 N35 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N26 LABEL_NET_2 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N35 N12 N24 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N20 N30 N14 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N9 N31 N25 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N23 N16 N13 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N21 N29 N16 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N19 LABEL_NET_4 N27 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N34 LABEL_NET_5 N29 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}

* Power Supply
VDD VDD 0 1.8

* Pull-up resistors for floating drains
R_N33 N33 VDD 1k
R_N9 N9 VDD 1k
R_N0 N0 VDD 1k
R_N1 N1 VDD 1k
R_N15 N15 VDD 1k

* Additional bias resistors for floating nodes
R_N32 N32 VDD 1k
R_N12 N12 0 1k
R_N29 N29 0 1k
R_N16 N16 0 1k

* Ground connections for floating sources
V_N24 N24 0 0
V_N14 N14 0 0
V_N25 N25 0 0
V_N13 N13 0 0
V_N27 N27 0 0

* DC Bias Sources
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9
VLABEL_NET_4 LABEL_NET_4 0 0.9
VLABEL_NET_5 LABEL_NET_5 0 0.9

* Input Signals (AC and Transient)
V_N17 N17 0 dc 0.9 ac 0.5 pwl(0 0.9 0.5n 0.9 0.51n 1.1 1.5n 1.1 1.51n 0.7 2.5n 0.7 2.51n 0.9)
V_N22 N22 0 dc 0.9 ac -0.5 pwl(0 0.9 0.5n 0.9 0.51n 0.7 1.5n 0.7 1.51n 1.1 2.5n 1.1 2.51n 0.9)
V_N18 N18 0 dc 0.9
V_N30 N30 0 dc 0.9
V_N31 N31 0 dc 0.9

* Differential Output
E_diff N_diff 0 N9 N1 1.0

.control
* 1. DC Operating Point & Power
op
let power_dissipation = -i(VDD) * 1.8
print power_dissipation

* 2. AC Analysis for Gain and Bandwidth
ac dec 20 1M 100G
let vout_diff = v(N9) - v(N1)
let gain_db = db(vout_diff)
meas ac voltage_gain MAX gain_db
let gain_3db_val = voltage_gain - 3
meas ac bandwidth when gain_db=$&gain_3db_val FALL=LAST
print voltage_gain bandwidth

* 3. Transient Analysis for Swing and Delay
tran 1p 3n
meas tran v_max MAX v(N_diff) from=1n to=3n
meas tran v_min MIN v(N_diff) from=1n to=3n
let v_mid = (v_max + v_min) / 2
meas tran t_in WHEN v(N17)=0.9 FALL=1 TD=1.0n
meas tran t_out WHEN v(N_diff)=$&v_mid CROSS=1 TD=1.4n
let transient_delay = t_out - t_in
print transient_delay

quit
.endc
.end