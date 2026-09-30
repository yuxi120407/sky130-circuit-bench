* Testbench for Switched Varactor Network
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0

* DUT
XM1 N3 LABEL_NET_0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 N2 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 N4 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 LABEL_NET_3 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N4 LABEL_NET_3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

* Biasing and Control
V_LABEL_NET_3 LABEL_NET_3 0 0
V_N0 N0 0 1.8
V_N4 N4 0 1.8
V_LABEL_NET_0 LABEL_NET_0 0 1.8
V_N2 N2 0 0

* Tank components to simulate resonance
L5 N5 0 1n
C5 N5 0 1p
R5 N5 0 10k
I_AC5 0 N5 DC 0 SIN(0 100u 5G) AC 1

L3 N3 0 1n
C3 N3 0 1p
R3 N3 0 10k
I_AC3 0 N3 DC 0 SIN(0 100u 5G) AC 1

.control
* AC Analysis 1 (Nominal Tuning Voltage)
ac lin 10000 4G 6G
let v5_db = db(v(N5))
meas ac gain MAX v5_db
meas ac operating_frequency MAX_AT v5_db
let op_freq_val = $&operating_frequency
let gain_val = $&gain

* AC Analysis 2 (Max Tuning Voltage)
alter V_N2 1.8
ac lin 10000 4G 6G
let v5_db_1 = db(v(N5))
meas ac f_res5_1 MAX_AT v5_db_1
let f_res_val = $&f_res5_1

* Transient Analysis
alter V_N2 0
tran 10p 100n
meas tran v_max_n5 max v(N5) from=90n to=100n
meas tran v_min_n5 min v(N5) from=90n to=100n
let vmax_val = $&v_max_n5
let vmin_val = $&v_min_n5

let tuning_range = abs(f_res_val - op_freq_val)
let output_power = vmax_val - vmin_val
let operating_frequency = op_freq_val
let gain = gain_val

print operating_frequency tuning_range gain output_power
quit
.endc
.end