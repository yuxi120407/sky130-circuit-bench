* 77 GHz SiGe Sub-Harmonic Balanced Mixer (Scaled for SKY130)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Replace npn with NMOS for SKY130 compatibility
M1 n12 n8 n4 GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
M2 n1 n7 GND GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
M3 n2 n11 GND GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
M4 n9 n6 n4 GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15

* Passives (Values estimated for ~5GHz operation)
R1 n1 n10 1k
R2 n10 n12 1k
R3 n2 n10 1k
R4 n4 GND 500
R5 n9 n10 1k
C1 n3 n5 1p
C2 n0 n11 1p
C3 n5 GND 1p
C4 n7 GND 1p
C5 n11 n13 1p
C6 n1 n8 1p
C7 n2 n6 1p
C8 n5 label_net_0 1p
C9 n11 n13 1p
L1 n3 n5 1n
L2 n5 n7 1n
L3 n0 n11 1n
L4 n5 n11 1n

* Sources
VVDD n10 0 dc 1.8
VLABEL_NET_0 label_net_0 0 dc 0.9
VRF n3 0 dc 0 sin(0 10m 5G) ac 0
VLO n0 0 dc 0 sin(0 300m 2.4G) ac 1

* Differential Output and Low-Pass Filter (fc ~ 500 MHz)
Eout out_diff 0 vol='v(n12)-v(n9)'
R_lpf out_diff out_if 1k
C_lpf out_if 0 0.3p

.control
* 1. DC Analysis
op
let power_mw = -i(VVDD) * 1.8 * 1000
print power_mw

* 2. AC Analysis for Isolation
ac dec 50 1G 10G
let iso_db = vdb(n3)
meas ac lo_rf_iso find iso_db at=2.4G
meas ac 2lo_rf_iso find iso_db at=4.8G

* 3. Transient Analysis for Conversion Gain
* IF = |5G - 2*2.4G| = 200 MHz (Period = 5ns)
tran 10p 20n
* Measure over exactly two IF periods to find peak-to-peak
meas tran out_max max v(out_if) from=10n to=20n
meas tran out_min min v(out_if) from=10n to=20n
let out_pp = out_max - out_min
* Input RF is 10mV peak = 20mV peak-to-peak
let cg_linear = out_pp / 0.02
let cg_db = 20 * log10(cg_linear)
print cg_db

quit
.endc
.end
