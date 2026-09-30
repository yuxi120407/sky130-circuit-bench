* Frequency Doubler Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_q1=0.5
.param L_q2=0.5
.param L_q3=0.5
.param L_q4=0.5
.param L_q5=0.5
.param L_q6=0.5

.param W_q1=10.0 L_q1=0.15
.param W_q2=5.0 L_q2=0.15
.param W_q3=10.0 L_q3=0.15
.param W_q4=10.0 L_q4=0.15
.param W_q5=10.0 L_q5=0.15
.param W_q6=10.0 L_q6=0.15

XQ1 n3 n5 n6 n0 sky130_fd_pr__nfet_01v8 w={W_q1} l={L_q1}
XQ2 n1 n1 n0 n0 sky130_fd_pr__nfet_01v8 w={W_q2} l={L_q2}
XQ3 n8 n4 n2 n0 sky130_fd_pr__nfet_01v8 w={W_q3} l={L_q3}
XQ4 n2 n1 n0 n0 sky130_fd_pr__nfet_01v8 w={W_q4} l={L_q4}
XQ5 n3 n5 n8 n0 sky130_fd_pr__nfet_01v8 w={W_q5} l={L_q5}
XQ6 n6 n7 n2 n0 sky130_fd_pr__nfet_01v8 w={W_q6} l={L_q6}

* Commented out shorted components causing singular matrix
* L1 n3 n3 1n
C1 n4 n0 1p
R1 n1 n3 1k
* R2 n2 n2 1k
C2 n3 label_net_0 1p
* L2 n3 n3 1n
R3 n4 label_net_1 1k
C3 n0 n5 1p
* C4 n3 n3 1p
C5 n0 n2 1p

* Connect floating n0 to ground
V_n0 n0 0 0

* Testbench additions
VDD vdd_node 0 1.8
Rload n3 vdd_node 100

VLABEL_NET_0 label_net_0 0 0.9
VLABEL_NET_1 label_net_1 0 0.9

Vbias5 n5 0 1.8
Vbias7 n7_dc 0 0.9
C_in7 n7_ac n7 1u
R_in7 n7 n7_dc 1k

C_in4 n4_ac n4 1u
Vin4 n4_ac 0 dc 0 ac 1 sin(0 0.2 3G 0 0 0)
Vin7 n7_ac 0 dc 0 ac 1 sin(0 0.2 3G 0 0 180)

* Mixers for exact Fourier extraction
B_sin3G mix3_sin 0 V=v(n3)*sin(2*3.14159265359*3e9*time)
B_cos3G mix3_cos 0 V=v(n3)*cos(2*3.14159265359*3e9*time)
B_sin6G mix6_sin 0 V=v(n3)*sin(2*3.14159265359*6e9*time)
B_cos6G mix6_cos 0 V=v(n3)*cos(2*3.14159265359*6e9*time)
B_sin9G mix9_sin 0 V=v(n3)*sin(2*3.14159265359*9e9*time)
B_cos9G mix9_cos 0 V=v(n3)*cos(2*3.14159265359*9e9*time)

.control
op
let power_consumption = -i(VDD) * 1.8
print power_consumption

tran 2p 5n
* Integrate over exactly 2ns (6 cycles of 3GHz, 12 of 6GHz, 18 of 9GHz)
meas tran int3_sin integ v(mix3_sin) from=3n to=5n
meas tran int3_cos integ v(mix3_cos) from=3n to=5n
meas tran int6_sin integ v(mix6_sin) from=3n to=5n
meas tran int6_cos integ v(mix6_cos) from=3n to=5n
meas tran int9_sin integ v(mix9_sin) from=3n to=5n
meas tran int9_cos integ v(mix9_cos) from=3n to=5n

* Calculate amplitudes
let amp_3G = 2 * sqrt( (int3_sin / 2e-9)*(int3_sin / 2e-9) + (int3_cos / 2e-9)*(int3_cos / 2e-9) )
let amp_6G = 2 * sqrt( (int6_sin / 2e-9)*(int6_sin / 2e-9) + (int6_cos / 2e-9)*(int6_cos / 2e-9) )
let amp_9G = 2 * sqrt( (int9_sin / 2e-9)*(int9_sin / 2e-9) + (int9_cos / 2e-9)*(int9_cos / 2e-9) )

* Differential input amplitude is 0.4V (0.2V per side)
let conv_gain_v = amp_6G / 0.4
let conversion_gain = 20 * log10(conv_gain_v + 1e-20)
print conversion_gain

let fundamental_rejection = 20 * log10((amp_3G + 1e-20) / (amp_6G + 1e-20))
print fundamental_rejection

let harmonic_rejection = 20 * log10((amp_9G + 1e-20) / (amp_6G + 1e-20))
print harmonic_rejection

quit
.endc
.end