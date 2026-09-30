* CML DFF Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_ef=0.5
.param L_sw=0.5
.param L_tail=0.5

.param R_load=200 R_cm=5k R_tail=100
.param W_sw=10.0 L_sw=0.15
.param W_ef=10.0 L_ef=0.15
.param W_tail=20.0 L_tail=0.5

VCC VCC 0 1.8
VEE VEE 0 0

* 2 GHz Clock
VCLK CLK 0 PULSE(0.7 1.3 0 20p 20p 230p 500p)
VCLKN CLKN 0 PULSE(1.3 0.7 0 20p 20p 230p 500p)

* 1 GHz Data
VD D 0 PULSE(0.7 1.3 0p 20p 20p 480p 1000p)
VDN DN 0 PULSE(1.3 0.7 0p 20p 20p 480p 1000p)

* Modified netlist: NPNs replaced with SKY130 NMOS (bulk tied to VEE)
R10 VCC N_C1 {R_load}
R9 VCC N_C2 {R_load}
R14 VCC N_C3 {R_load}
R11 VCC N_C4 {R_load}
R8 QxN N_BIAS_M {R_cm}
R1 Qx N_BIAS_M {R_cm}
R12 Q N_BIAS_S {R_cm}
R2 QN N_BIAS_S {R_cm}
R6 N_E_TAIL1 VEE {R_tail}
R3 N_E_TAIL2 VEE {R_tail}
R4 N_E_TAIL3 VEE {R_tail}
R13 N_E_TAIL4 VEE {R_tail}
M20 VCC N_C1 QxN VEE sky130_fd_pr__nfet_01v8 w={W_ef} l={L_ef}
M11 VCC N_C2 Qx VEE sky130_fd_pr__nfet_01v8 w={W_ef} l={L_ef}
M15 N_C1 D N_E1 VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M12 N_C2 DN N_E1 VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M13 N_C2 QxN N_E2 VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M3 N_C1 Qx N_E2 VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M10 N_E1 CLK N_TAIL_M VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M16 N_E2 CLKN N_TAIL_M VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M1 N_TAIL_M N_BIAS_M N_E_TAIL1 VEE sky130_fd_pr__nfet_01v8 w={W_tail} l={L_tail}
M4 N_BIAS_M N_BIAS_M N_E_TAIL2 VEE sky130_fd_pr__nfet_01v8 w={W_tail} l={L_tail}
M19 VCC N_C3 Q VEE sky130_fd_pr__nfet_01v8 w={W_ef} l={L_ef}
M7 VCC N_C4 QN VEE sky130_fd_pr__nfet_01v8 w={W_ef} l={L_ef}
M14 N_C3 Qx N_E3 VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M9 N_C4 QxN N_E3 VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M17 N_C4 Q N_E4 VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M6 N_C3 QN N_E4 VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M18 N_E3 CLKN N_TAIL_S VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M8 N_E4 CLK N_TAIL_S VEE sky130_fd_pr__nfet_01v8 w={W_sw} l={L_sw}
M2 N_TAIL_S N_BIAS_S N_E_TAIL3 VEE sky130_fd_pr__nfet_01v8 w={W_tail} l={L_tail}
M5 N_BIAS_S N_BIAS_S N_E_TAIL4 VEE sky130_fd_pr__nfet_01v8 w={W_tail} l={L_tail}

.control
tran 5p 4n

* 1. Power Consumption
meas tran I_vdd avg i(VCC) from=2n to=4n
let power = -I_vdd * 1.8
print power

* 2. Single-ended Voltage Swing
meas tran v_max max v(Q) from=2n to=4n
meas tran v_min min v(Q) from=2n to=4n
let swing = v_max - v_min
print swing

* 3. Clock-to-Q Delay (measured differentially at the 5th clock falling edge)
meas tran t_clk_fall trig v(CLK, CLKN) val=0 fall=5
meas tran t_q_rise trig v(Q, QN) val=0 rise=3
let delay = t_q_rise - t_clk_fall
print delay

* 4. Rise Time (20% to 80% of a ~1.2V differential swing)
meas tran t_rise trig v(Q, QN) val=-0.3 rise=3 targ v(Q, QN) val=0.3 rise=3
print t_rise

quit
.endc
.end
