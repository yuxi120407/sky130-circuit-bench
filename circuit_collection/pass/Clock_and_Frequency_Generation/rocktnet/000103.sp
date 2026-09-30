* VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

VVDD VDD 0 1.8

* DUT (with component values added for simulation)
Q1 n7 n6 n3 npn
L1 n4 n6 1n
L2 n0 n4 1n
L3 VDD n7 1n
R1 n2 0 50
Q2 n1 n0 n5 npn
L4 VDD n1 1n
L5 n3 0 1n
R2 VDD n4 5k
C1 n2 n5 1p
L6 n5 0 1n
C2 n2 n3 1p

* Generic NPN model since the netlist uses 'npn'
.model npn npn is=1e-16 bf=100 cjc=50f cje=50f tf=10p

* Initial conditions to kickstart oscillation
.ic v(n7)=1.8 v(n1)=1.8 v(n6)=0.8 v(n0)=0.9

.control
* Run transient analysis with UIC to use initial conditions
tran 0.5p 100n uic

* Measure oscillation frequency
meas tran t1 WHEN v(n7)=1.8 CROSS=10 FROM=50n TO=100n
meas tran t2 WHEN v(n7)=1.8 CROSS=30 FROM=50n TO=100n
let f_osc = 10 / (t2 - t1)

* Measure output amplitude
meas tran v_max MAX v(n7) FROM=50n TO=100n
meas tran v_min MIN v(n7) FROM=50n TO=100n
let v_amp = (v_max - v_min) / 2

* Measure DC power consumption
meas tran i_avg AVG i(VVDD) FROM=50n TO=100n
let p_dc = -i_avg * 1.8

print f_osc
print v_amp
print p_dc

quit
.endc
.end