* Folded-Cascode LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmg=0.5
.param L_xms=0.5

.param W_xmg=5.0 L_xmg=0.5
.param W_xms=5.0 L_xms=0.5

VVDD VDD 0 1.8
* AC source for AC analysis, SIN for transient
VVIN VIN 0 DC 0.9 AC 1 SIN(0.9 0.01 1.9G 0 0)
VBIAS BIAS 0 DC 0.5

* RF Choke for folding node (DC short to VDD, AC open)
LZT ZT VDD 1m

* LC Tank Load tuned to ~1.9 GHz
Ltank VOUT 0 5n
Ctank VOUT 0 1.4p
Rtank VOUT 0 5k

* DUT
XMG VOUT BIAS ZT VDD sky130_fd_pr__pfet_01v8 l={L_xmg} w={W_xmg}
XMS ZT VIN GND GND sky130_fd_pr__nfet_01v8 l={L_xms} w={W_xms}

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 100 100MEG 10G
let gain_db = vdb(VOUT)
meas ac max_gain max gain_db
meas ac gain_19g find gain_db at=1.9G

tran 10p 20n
meas tran v_out_max max v(VOUT) from=10n to=20n
meas tran v_out_min min v(VOUT) from=10n to=20n
let v_out_pp = v_out_max - v_out_min
let tran_gain = v_out_pp / 0.02
print tran_gain
.endc
.end