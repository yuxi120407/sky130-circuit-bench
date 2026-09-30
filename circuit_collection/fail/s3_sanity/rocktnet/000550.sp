* ILFD Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 N_S1 N_G1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_S2 N_G2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT_L VIN_P N_S1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT_L VOUT_R N_S1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VOUT_R VOUT_L N_S2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VOUT_R VIN_N N_S2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* LC Tank Loads (Resonant at ~5 GHz)
L1 VDD VOUT_L 1n
C1 VOUT_L 0 1p
R1 VDD VOUT_L 1k

L2 VDD VOUT_R 1n
C2 VOUT_R 0 1p
R2 VDD VOUT_R 1k

* DC Sources
VVDD VDD 0 1.8
VBIAS1 N_G1 0 3.3
VBIAS2 N_G2 0 3.3

* 10 GHz Differential Input Signal
VVIN_P VIN_P 0 DC 0.5 SIN(0.5 0.5 10G 0 0 0)
VVIN_N VIN_N 0 DC 0.5 SIN(0.5 0.5 10G 0 0 180)

.control
tran 10p 100n

* Measure input frequency
meas tran t_in_period trig v(VIN_P) val=0.5 rise=10 targ v(VIN_P) val=0.5 rise=11 from=80n
let input_frequency = 1 / t_in_period
print input_frequency

* Measure output frequency
meas tran t_out_period trig v(VOUT_L) val=1.8 rise=10 targ v(VOUT_L) val=1.8 rise=11 from=80n
let output_frequency = 1 / t_out_period
print output_frequency

* Calculate division ratio
let division_ratio = input_frequency / output_frequency
print division_ratio

* Measure output voltage swing
meas tran vout_max max v(VOUT_L) from=80n to=100n
meas tran vout_min min v(VOUT_L) from=80n to=100n
let output_voltage_swing = vout_max - vout_min
print output_voltage_swing

* Measure power consumption
meas tran pwr avg i(VVDD) from=80n to=100n
let power_consumption = -pwr * 1.8
print power_consumption

quit
.endc
.end