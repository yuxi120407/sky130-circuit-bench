* Cross-coupled pair testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 N0 N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

VVDD VDD 0 1.8
I_tail N2 0 500u

* LC Tank for oscillation and DC bias
L1 VDD N0 5n
L2 VDD N1 5n
Ctank N0 N1 2p

* AC source for impedance measurement
I_ac N0 N1 DC 0 AC 1

.ic v(N0)=1.8 v(N1)=1.7

.control
* 1. DC Operating Point
op
let dc_power = -i(VVDD) * 1.8
print dc_power

* 2. AC Analysis for Negative Resistance
ac dec 100 100Meg 10Gig
let vdiff = v(N0) - v(N1)
let Y = 1 / vdiff
let Gin = real(Y)
let Rin = 1 / Gin
meas ac Rin_1G find Rin at=1G
meas ac Gin_1G find Gin at=1G
let gm_eff = -Gin_1G * 2
print gm_eff

* 3. Transient Analysis for Oscillation
tran 10p 50n
meas tran v_max max v(N0)
meas tran v_min min v(N0)
let v_swing = v_max - v_min
print v_swing

meas tran t1 trig v(N0) val=1.8 rise=15 targ v(N0) val=1.8 rise=16
let osc_freq = 1 / t1
print osc_freq

quit
.endc
.end
