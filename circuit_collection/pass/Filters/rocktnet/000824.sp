* Active Differential Loop Filter Testbench

* DUT (Modified A1 to X1 and added typical component values for simulation)
X1 Vfinen Vfinep CHPoutp CHPoutn amplifier
R1 CHPoutn N5 10k
C1 CHPoutn Vfinep 100p
C2 CHPoutp Vfinen 100p
C3 Vfinen N4 1n
C4 Vfinep N5 1n
R2 CHPoutp N4 10k

* Ideal Differential Amplifier Subcircuit
.subckt amplifier outn outp inp inn
E1 outp 0 inp inn 10000
E2 outn 0 inn inp 10000
.ends

* Stimulus (Differential Current from Charge Pump)
I1 0 CHPoutp AC 1
I2 0 CHPoutn AC -1

* DC bias paths for the ideal op-amp inputs to prevent floating nodes
Rcm1 CHPoutp 0 1G
Rcm2 CHPoutn 0 1G

.control
ac dec 20 100 100MEG

* Calculate differential transimpedance (Z = Vdiff / Idiff)
* Idiff = I1 - I2 = 2A
let vout_diff = v(Vfinep) - v(Vfinen)
let z_diff = mag(vout_diff) / 2
let z_db = 20*log10(z_diff)

* Measure transimpedance at different regions
meas ac z_1k find z_db at=1k
meas ac z_100k find z_db at=100k
meas ac z_10meg find z_db at=10meg

print z_1k z_100k z_10meg
quit
.endc
.end
