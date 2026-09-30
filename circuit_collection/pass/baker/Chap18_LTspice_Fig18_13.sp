* Testbench for Fig 18.13 Skew Circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

* Define parameters for W/L=10
.param W_xm1=1.5 L_xm1=0.15
.param W_xm2=1.5 L_xm2=0.15
.param W_xm3=1.5 L_xm3=0.15
.param W_xm4=1.5 L_xm4=0.15

* DUT
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
C1 Vout 0 1e-13
xm3 Vout2 Vout 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 Vout2 Vout VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}

* Stimulus
Vin Vin 0 PULSE(0 1.8 1n 50p 50p 2n 5n)

.control
tran 10p 5n

* Measure t_PHL_inv1 (Vin rising, Vout falling)
meas tran t_PHL_inv1 trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 fall=1

* Measure t_PLH_inv1 (Vin falling, Vout rising)
meas tran t_PLH_inv1 trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 rise=1

* Measure t_delay_rise (Vin rising, Vout2 rising)
meas tran t_delay_rise trig v(Vin) val=0.9 rise=1 targ v(Vout2) val=0.9 rise=1

* Measure t_delay_fall (Vin falling, Vout2 falling)
meas tran t_delay_fall trig v(Vin) val=0.9 fall=1 targ v(Vout2) val=0.9 fall=1

* Calculate skew
let skew = abs(t_delay_rise - t_delay_fall)
print skew

quit
.endc
.end