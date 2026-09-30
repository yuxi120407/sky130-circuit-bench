* Colpitts Oscillator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5
XM1 VTANK VB N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

VVDD VDD 0 1.8
VVB VB 0 0.54
I_tail N1 0 10u

* LC Tank
L1 VDD VTANK 1u
R1 VDD VTANK 20k

* Capacitive Feedback Divider
C1 VTANK N1 1p
C2 N1 0 1p

* AC injection for Gain measurement
I_ac 0 VTANK dc 0 ac 1

* Initial condition to kickstart oscillation
.ic v(VTANK)=0 v(N1)=0

.control
* 1. AC Analysis for Gain
ac dec 100 100Meg 1G
let gain_db = vdb(VTANK)
meas ac max_gain max gain_db

* 2. Noise Analysis for Phase Noise proxy
noise v(VTANK) VVDD dec 10 100Meg 1G
meas noise max_noise max onoise_spectrum

* 3. Transient Analysis for Oscillation and Efficiency
tran 0.1n 200n
* Measure frequency using zero-crossings around VDD (1.8V)
meas tran t1 trig v(VTANK) val=1.8 rise=10 targ v(VTANK) val=1.8 rise=11
let osc_freq = 1/t1
print osc_freq

* Measure amplitude
meas tran vmax max v(VTANK) from=100n to=200n
meas tran vmin min v(VTANK) from=100n to=200n
let amp = vmax - vmin
print amp

* Measure DC power
meas tran id_avg avg i(VVDD) from=100n to=200n
let dc_power = -id_avg * 1.8
print dc_power

* Calculate Efficiency
let p_rf = (amp/2)*(amp/2) / (2 * 20000)
let efficiency = (p_rf / dc_power) * 100
print efficiency

* Supply voltage
let supply_v = 1.8
print supply_v

quit
.endc
.end
