* DC Generation Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

V1 VDD 0 1.8
V2 Vin 0 sin(0.9 0.9 1Meg)

* Peak detector
XM1 VDD Vin Max GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
C1 Max 0 1p

* Valley detector
XM2 GND Vin Min VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
C2 Min 0 1p

* Averager
R1 Max Avg 100k
R2 Min Avg 100k
C3 Avg 0 1p

* Buffer
S1 Vout VDD Vin Avg SW
S2 Vout 0 Avg Vin SW
.model SW sw vt=0 vh=0.01 ron=100 roff=1Meg
C4 Vout 0 10f

.control
tran 10n 5u
let vdiff = v(Vin) - v(Avg)
meas tran v_max_steady_state avg v(Max) from=4u to=5u
meas tran v_min_steady_state avg v(Min) from=4u to=5u
meas tran v_avg_steady_state avg v(Avg) from=4u to=5u
meas tran buffer_propagation_delay trig vdiff val=0 rise=3 targ v(Vout) val=0.9 rise=3
meas tran buffer_logical_high max v(Vout) from=4u to=5u
meas tran buffer_logical_low min v(Vout) from=4u to=5u
print v_max_steady_state v_min_steady_state v_avg_steady_state buffer_propagation_delay buffer_logical_high buffer_logical_low
.endc
.end