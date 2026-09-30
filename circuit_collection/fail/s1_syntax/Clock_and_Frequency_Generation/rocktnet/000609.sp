* Testbench for XOR/XNOR Lock Detector
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_m=0.5
.param L_tail=0.5

.param W_m=2.0 L_m=0.15
.param W_tail=4.0 L_tail=0.15
.param R_load=1k
.param R_tail=200
.param R_ef=2k

V1 VDD 0 1.8
V2 VCS 0 0.8

* Inputs (1GHz and 2GHz effective data rates for testing)
V3 DELAYED_DATA_P 0 dc 0.9 pulse(0.6 1.2 0 20p 20p 480p 1n)
V4 DELAYED_DATA_N 0 dc 0.9 pulse(1.2 0.6 0 20p 20p 480p 1n)
V5 RETIMED_DATA_P 0 dc 0.9 pulse(0.6 1.2 250p 20p 20p 480p 1n)
V6 RETIMED_DATA_N 0 dc 0.9 pulse(1.2 0.6 250p 20p 20p 480p 1n)

* DUT
R1 VDD N_C2 {R_load}
R2 VDD N_C1 {R_load}
R3 OUTPUT_P 0 {R_ef}
R4 N_E6 0 {R_tail}
R5 OUTPUT_N 0 {R_ef}

M1 N_C1 RETIMED_DATA_N N_E34 0 sky130_fd_pr__nfet_01v8 w={W_m} l={L_m}
M2 N_E12 DELAYED_DATA_P N_E5 0 sky130_fd_pr__nfet_01v8 w={W_m} l={L_m}
M3 N_C1 RETIMED_DATA_P N_E12 0 sky130_fd_pr__nfet_01v8 w={W_m} l={L_m}
M4 VDD N_C2 OUTPUT_N 0 sky130_fd_pr__nfet_01v8 w={W_m} l={L_m}
M5 N_E5 VCS N_E6 0 sky130_fd_pr__nfet_01v8 w={W_tail} l={L_tail}
M6 N_C2 RETIMED_DATA_N N_E12 0 sky130_fd_pr__nfet_01v8 w={W_m} l={L_m}
M7 VDD N_C1 OUTPUT_P 0 sky130_fd_pr__nfet_01v8 w={W_m} l={L_m}
M8 N_E34 DELAYED_DATA_N N_E5 0 sky130_fd_pr__nfet_01v8 w={W_m} l={L_m}
M9 N_C2 RETIMED_DATA_P N_E34 0 sky130_fd_pr__nfet_01v8 w={W_m} l={L_m}

.control
tran 10p 4n
let out_diff = v(OUTPUT_P) - v(OUTPUT_N)

* Swing measurement
meas tran v_max max out_diff
meas tran v_min min out_diff

* Power measurement
let pwr = -i(V1)*1.8
meas tran avg_pwr avg pwr

* Delay measurement
meas tran t_in trig v(DELAYED_DATA_P) val=0.9 rise=2
meas tran t_out trig out_diff val=0 rise=3
let delay = t_out - t_in
print delay

quit
.endc
.end
