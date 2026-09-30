* Ring Oscillator with Parasitic Model
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param VDD_VAL=1.8
Vdd VDD 0 {VDD_VAL}

* 3-stage ring oscillator
Xinv1 G D VDD 0 inv
Xinv2 D n3 VDD 0 inv
Xinv3 n3 G VDD 0 inv

.subckt inv in out vdd gnd
XMp out in vdd vdd sky130_fd_pr__pfet_01v8 w=2.0 l=0.15
XMn out in gnd gnd sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
.ends

* Connect S and B to ground for the DUT
V_S S 0 0
V_B B 0 0

* DUT (Parasitic Capacitances - 5fF values added to make valid SPICE)
Cgs G S 5f
Cgd G D 5f
Cdb D B 5f
Cgb G B 5f
Csb S B 5f

* Initial conditions to kickstart oscillation
.ic v(G)=0 v(D)=1.8 v(n3)=0

.control
tran 5p 10n

* Measure Oscillation Frequency (using 10th and 11th cycles for steady state)
meas tran t1 trig v(G) val=0.9 rise=10 targ v(G) val=0.9 rise=11
let freq = 1 / t1
print freq

* Measure Power Consumption
meas tran pwr_avg avg i(Vdd) from=5n to=10n
let power = -pwr_avg * 1.8
print power

* Measure Peak-to-Peak Voltage
meas tran vmax max v(G) from=5n to=10n
meas tran vmin min v(G) from=5n to=10n
let vpp = vmax - vmin
print vpp

quit
.endc
.end