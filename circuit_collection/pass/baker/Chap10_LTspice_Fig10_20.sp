* CMOS Transmission Gate Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param W_xm2=5.0

.param W_xm1=1 L_xm1=1 W_xm2=1 L_xm2=1

* DUT
xm1 Vin VDD Vout 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
C1 Vout 0 5e-14
VDD VDD 0 1.8
xm2 Vout 0 Vin VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}

* Stimulus
V1 Vin 0 PULSE(0 1.8 1n 10p 10p 5n 10n)

.control
tran 10p 15n

* Measure propagation delays (50% to 50%)
meas tran t_plh trig v(vin) val=0.9 rise=1 targ v(vout) val=0.9 rise=1
meas tran t_phl trig v(vin) val=0.9 fall=1 targ v(vout) val=0.9 fall=1

* Measure rise and fall times (10% to 90%)
meas tran t_lh trig v(vout) val=0.18 rise=1 targ v(vout) val=1.62 rise=1
meas tran t_hl trig v(vout) val=1.62 fall=1 targ v(vout) val=0.18 fall=1

* Measure voltage extremes to verify full swing (CMOS TG passes full 0 and 1)
meas tran v_max max v(vout)
meas tran v_min min v(vout)

quit
.endc
.end