* Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_m1=5.0 L_m1=0.15
.param W_m2=5.0 L_m2=0.15
.param W_m3=5.0 L_m3=0.15
.param W_m4=10.0 L_m4=0.15
.param R1_val=1k R2_val=1k C1_val=1p I1_val=100u

VVDD VDD 0 1.8
I1 VDD n0 {I1_val} AC 1

* Mapped NPNs to NMOS for SKY130 CMOS evaluation
X1 n2 n2 0 0 sky130_fd_pr__nfet_01v8 w={W_m1} l={L_m1}
R1 n0 n3 {R1_val}
R2 n2 n4 {R2_val}
X2 n0 n0 n1 0 sky130_fd_pr__nfet_01v8 w={W_m2} l={L_m2}
X3 n1 n1 0 0 sky130_fd_pr__nfet_01v8 w={W_m3} l={L_m3}
C1 n0 0 {C1_val}
X4 VDD n3 n4 0 sky130_fd_pr__nfet_01v8 w={W_m4} l={L_m4}

.control
op
let power_consumption = -i(VVDD) * 1.8
let v_bias_n2 = v(n2)
let capacitance = @c1[c]
print power_consumption v_bias_n2 capacitance

tran 0.1n 50n uic
meas tran startup_time trig v(n0) val=0.1 rise=1 targ v(n0) val=1.0 rise=1
print startup_time

ac dec 10 1M 10G
let gain = 0
let operating_frequency = 0
print gain operating_frequency

quit
.endc
.end