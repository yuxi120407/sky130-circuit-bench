* Folded Cascode LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmg=0.5
.param L_xms=0.5

.param W_xms=5.0 L_xms=0.5
.param W_xmg=5.0 L_xmg=0.5

XMS N0 VIN GND GND sky130_fd_pr__nfet_01v8 l={L_xms} w={W_xms}
XMG VOUT BIAS N0 VDD sky130_fd_pr__pfet_01v8 l={L_xmg} w={W_xmg}

VVDD VDD 0 1.8
VVIN VIN 0 DC 0.9 AC 1 SIN(0.9 0.1 1.9G)
VBIAS BIAS 0 DC 0.2

* Folding current source to supply both NMOS and PMOS
IFOLD VDD N0 DC 400u

* Output LC Tank tuned to 1.9 GHz
LLOAD VOUT 0 5n
CLOAD VOUT 0 1.4p
RTANK VOUT 0 10k

.control
op
let p_dc = -i(VVDD) * 1.8
print p_dc

ac dec 100 100MEG 10G
let gain_db = vdb(vout)
meas ac gain_at_1g9 find gain_db at=1.9G
meas ac max_gain max gain_db

tran 10p 20n
meas tran vout_max max v(vout) from=10n to=20n
meas tran vout_min min v(vout) from=10n to=20n
let vout_pp = vout_max - vout_min
let vout_amp = vout_pp / 2
* Calculate equivalent power in dBm referenced to 50 ohms
let p_out_dbm = 10 * log10( (vout_amp * vout_amp) / 100 * 1000 )
print p_out_dbm
quit
.endc
.end
