* Reversed Nested Miller Compensation OpAmp Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_fb=0.5
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
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

XM1 N3 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 LABEL_NET_1 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 LABEL_NET_2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

* Biasing and Supplies
VVDD VDD 0 1.8
Vbias0 LABEL_NET_0 0 0.8
Vbias3 LABEL_NET_3 0 0.8
* Missing load for stage 2 (XM4) to prevent N5 from collapsing
I_N5 VDD N5 100u

* Compensation Capacitors (Reversed Nested Miller)
C_m1 N4 N5 10p
C_m2 N5 N3 10p

* Load Capacitor
C_load N4 0 15p

* Feedback for Open-Loop AC / Closed-Loop Tran
Lfb N4 LABEL_NET_2 1T
Cfb LABEL_NET_2 0 1T

* Input Signal
V_in_p LABEL_NET_1 0 dc 0.45 ac 1 pulse(0.3 0.6 10n 1n 1n 10u 20u)

.control
* 1. DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* 2. AC Analysis (Open Loop)
ac dec 50 0.01 1G
let gain_db = db(v(N4))
let phase_deg = ph(v(N4)) * 180 / 3.141592653589793
let pm = 180 + phase_deg
meas ac dc_gain find gain_db at=0.01
meas ac gbw when gain_db=0 fall=1
meas ac phase_margin find pm when gain_db=0 fall=1
print dc_gain gbw phase_margin

* 3. Transient Analysis (Closed Loop Step Response)
alter Lfb 1p
alter Cfb 1f
tran 10n 5u
meas tran t_rise trig v(N4) val=0.33 rise=1 targ v(N4) val=0.57 rise=1
let slew_rate = 0.24 / t_rise / 1e6
meas tran settling_time trig v(LABEL_NET_1) val=0.45 rise=1 targ v(N4) val=0.597 cross=last
print slew_rate settling_time
quit
.endc
.end