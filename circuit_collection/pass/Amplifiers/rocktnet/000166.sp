* Differential Capacitive Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param CiA=2p CiB=1p

* DUT (Note: Changed A1 to X1 for standard SPICE subcircuit instantiation)
X1 IN- IN+ OP OM amplifier
C2 IN- OP CiB
C1 IN+ OM CiB
C4 IN- IN1 CiA
C3 IN+ IN2 CiA

* DC bias resistors to prevent floating nodes (virtual grounds)
Rbias1 IN- OP 1G
Rbias2 IN+ OM 1G

* Behavioral Amplifier Model
.subckt amplifier inn inp outp outn
B1 outp_ideal 0 V=0.9 + 1000*(V(inp)-V(inn))
B2 outn_ideal 0 V=0.9 - 1000*(V(inp)-V(inn))
R1 outp_ideal outp 1k
C1 outp 0 1n
R2 outn_ideal outn 1k
C2 outn 0 1n
.ends

* Stimulus
Vcm cm 0 DC 0.9
V1 IN1 cm DC 0 AC 1 SIN(0 0.1 1MEG)
V2 IN2 cm DC 0 AC -1 SIN(0 -0.1 1MEG)

.control
op
print v(OP) v(OM) v(IN-) v(IN+)

ac dec 20 1k 1G
let out_diff = v(OP) - v(OM)
let in_diff = v(IN1) - v(IN2)
let gain_mag = mag(out_diff) / mag(in_diff)
let gain_db = 20 * log10(gain_mag)
meas ac midband_gain find gain_db at=10k
meas ac bw when gain_db=3.02 fall=1

tran 1n 5u
meas tran op_max max v(OP)
meas tran op_min min v(OP)
let swing = op_max - op_min
print swing
quit
.endc
.end