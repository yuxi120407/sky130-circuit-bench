* Cascaded Inverters Delay and Skew Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

* Parameters matching Baker's 10/1 sizing
.param W_xm1=10 L_xm1=1
.param W_xm2=10 L_xm2=1
.param W_xm3=10 L_xm3=1
.param W_xm4=10 L_xm4=1

* DUT
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
C1 Vout 0 5e-14
xm3 Vout2 Vout 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 Vout2 Vout VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
C2 Vout2 0 5e-14

* Stimulus
Vin Vin 0 PULSE(0 1.8 1n 50p 50p 2n 5n)

.control
* --- DC Analysis for Switching Point ---
dc Vin 0 1.8 0.01
let diff = v(Vout) - v(Vin)
meas dc switching_point_voltage find v(Vin) when diff=0

* --- Transient Analysis for Delays ---
tran 1p 5n

* Stage 1 Delays
meas tran t_PHL1 trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 fall=1
meas tran t_PLH1 trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 rise=1

* Stage 2 Delays
meas tran t_PLH2 trig v(Vout) val=0.9 fall=1 targ v(Vout2) val=0.9 rise=1
meas tran t_PHL2 trig v(Vout) val=0.9 rise=1 targ v(Vout2) val=0.9 fall=1

* Total Delays
meas tran total_delay_rise trig v(Vin) val=0.9 rise=1 targ v(Vout2) val=0.9 rise=1
meas tran total_delay_fall trig v(Vin) val=0.9 fall=1 targ v(Vout2) val=0.9 fall=1

* Skew Calculation
let skew = abs(total_delay_rise - total_delay_fall)
print skew

quit
.endc
.end