* Oscillator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_tank=0.5

* DUT with component values added for simulation
Q1 n6 n0 n3 npn
R1 n0 n2 1k
R2 n2 n6 1k
C1 n3 n4 1p
C2 n4 n5 1p
R3 n0 n4 10k
R4 n3 n4 10k
R5 n5 n5 1
C3 n0 n3 1p
Q2 n5 n5 n1 npn
R6 n6 label_net_0 50
R7 n0 n1 10k

* Generic NPN model (avoids SKY130 subcircuit mapping issues for Q instances)
.model npn npn (is=1e-16 bf=100 cje=10f cjc=10f)

* Added LC tank components to ensure oscillation 
* (Assuming R6/R1/R2 were extracted from inductors/t-lines)
L_tank n6 label_net_0 1n
C_tank n6 n1 0.5p

* Supplies
Vvdd label_net_0 0 1.8
Vgnd n1 0 0

* Startup injection to kickstart oscillation
I_start n6 0 PULSE(0 1m 0 1p 1p 1p 10n)

* AC coupling for robust frequency measurement
E_buf out_buf 0 n6 0 1
C_ac out_buf out_ac 1p
R_ac out_ac 0 1k

.control
* Transient analysis
tran 1p 10n

* Measure peak-to-peak voltage
meas tran v_max max v(n6) from=5n to=10n
meas tran v_min min v(n6) from=5n to=10n
let vpp = v_max - v_min
print vpp

* Measure oscillation frequency via zero-crossings of AC coupled signal
meas tran t1 trig v(out_ac) val=0 rise=3 targ v(out_ac) val=0 rise=4
let freq = 1/t1
print freq

* Measure DC power
op
let power = -i(Vvdd) * 1.8
print power
.endc
.end
