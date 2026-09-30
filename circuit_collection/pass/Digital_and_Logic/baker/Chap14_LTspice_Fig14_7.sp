* Dynamic Latch Storage Node Leakage Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

* Parameters for the DUT
.param W_xm1=1 L_xm1=0.15
.param W_xm2=2 L_xm2=0.15
.param W_xm3=1 L_xm3=0.15
.param W_xm4=2 L_xm4=0.15
.param W_xm5=1 L_xm5=0.15

* DUT Netlist
xm1 Q_bar stor 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 Q_bar stor VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Q Q_bar 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 Q Q_bar VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 0 0 stor 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}

* Initial condition: Storage node charged to VDD
.ic v(stor)=1.8

* AC stimulus for input capacitance measurement
I_ac 0 stor DC 0 AC 1

.control
* 1. AC Analysis for input capacitance
ac lin 1 1k 1k
let vstor_m = mag(v(stor))
let input_capacitance = 1 / (2 * 3.1415926535 * 1000 * vstor_m)
print input_capacitance

* 2. TRAN Analysis for leakage and delays (Default GMIN)
tran 100n 10m uic

meas tran discharge_time WHEN v(stor)=0.1 FALL=1

meas tran v_1us FIND v(stor) AT=1u
meas tran v_11us FIND v(stor) AT=11u
let discharge_rate_V_per_s = (v_1us - v_11us) / 10e-6
let discharge_rate = discharge_rate_V_per_s * 1e-6
print discharge_rate

meas tran max_off_time WHEN v(stor)=1.7 FALL=1

meas tran t_stor_900m WHEN v(stor)=0.9 FALL=1
meas tran t_qbar_900m WHEN v(Q_bar)=0.9 RISE=1
let propagation_delay = abs(t_qbar_900m - t_stor_900m)
print propagation_delay

* 3. TRAN Analysis with reduced GMIN to find GMIN leakage
set gmin=1e-15
tran 100n 20u uic

meas tran v_1us2 FIND v(stor) AT=1u
meas tran v_11us2 FIND v(stor) AT=11u
let discharge_rate2_V_per_s = (v_1us2 - v_11us2) / 10e-6

let gmin_discharge_rate_V_per_s = tran1.discharge_rate_V_per_s - discharge_rate2_V_per_s
let gmin_discharge_rate = gmin_discharge_rate_V_per_s * 1e-6
print gmin_discharge_rate

let gmin_leakage = ac1.input_capacitance * gmin_discharge_rate_V_per_s
print gmin_leakage

quit
.endc
.end