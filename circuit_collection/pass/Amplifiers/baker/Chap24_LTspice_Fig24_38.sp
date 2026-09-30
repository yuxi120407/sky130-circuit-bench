* Testbench for Cascode OTA with Output Buffer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Power supply
VDD vdd 0 1.8

* Stimulus
Vinp vinp 0 dc 0.6 ac 1 PULSE(0.3 0.9 50n 1n 1n 2u 4u)

* Feedback network for AC and Tran
Rf vout vinn 1T
C_ac_gnd vinn 0 1T
Cload vout 0 1p

* Bias circuit
Iref vdd bias_n 10u
XM_b1 bias_n bias_n 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
XM_b2 bias_p bias_p vdd vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.5
XM_b3 bias_p bias_n 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.5

* Cascode biases
XM_cb_n cascb_n cascb_n bias_n 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
I_cb_n vdd cascb_n 10u

XM_cb_p cascb_p cascb_p bias_p vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.5
I_cb_p cascb_p 0 10u

* First stage: Folded cascode
XM_tail tail bias_p vdd vdd sky130_fd_pr__pfet_01v8 w=20.0 l=0.5
XM_dp1 d1 vinn tail vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.5
XM_dp2 d2 vinp tail vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.5

XM_n1 d1 bias_n 0 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.5
XM_n2 d2 bias_n 0 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.5

XM_nc1 out1 cascb_n d1 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.5
XM_nc2 out2 cascb_n d2 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.5

XM_p1 out1 out1 vdd vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.5
XM_p2 out2 out1 vdd vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.5

* Second stage: CS with cascoded load
XM_cs vout out2 0 0 sky130_fd_pr__nfet_01v8 w=2.0 l=0.5
XM_pl1 p_mid bias_p vdd vdd sky130_fd_pr__pfet_01v8 w=20.0 l=0.5
XM_pl2 vout cascb_p p_mid vdd sky130_fd_pr__pfet_01v8 w=20.0 l=0.5

* Indirect compensation
Cc vout d2 1p

.control
* AC Analysis Setup
alter Rf 1T
alter C_ac_gnd 1T

op
let power_consumption = -i(VDD) * 1.8
print power_consumption

ac dec 10 1 1G
let gain_db = db(v(vout))
let phase_deg = ph(v(vout))*180/pi
meas ac open_loop_gain max gain_db
meas ac unity_gain_frequency when gain_db=0 fall=1
let pm = phase_deg + 180
meas ac phase_margin find pm when gain_db=0 fall=1
print open_loop_gain unity_gain_frequency phase_margin

* Tran Analysis Setup
alter Rf 1
alter C_ac_gnd 1e-15

tran 1n 4u
meas tran t1 when v(vout)=0.4 rise=1
meas tran t2 when v(vout)=0.8 rise=1
let slew_rate = (0.8 - 0.4) / (t2 - t1) / 1e6
print slew_rate

.endc
.end