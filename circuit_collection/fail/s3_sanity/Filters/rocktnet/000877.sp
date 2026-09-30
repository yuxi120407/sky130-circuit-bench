* Delta-Sigma Modulator Loop Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param VDD=1.8

* Behavioral Amplifier Subcircuit (Fully Differential)
.subckt amplifier outP outN inP inN
G1 outP 0 inP inN 10m
G2 outN 0 inN inP 10m
R1 outP 0 100k
R2 outN 0 100k
C1 outP 0 1p
C2 outN 0 1p
.ends

* DUT (Modified to include 'X' for subcircuits and typical component values)
XOP2 N2 N0 N6 N4 amplifier
XOP1 N6 N4 A N3 amplifier
R1 N6 N7 1k
R2 N3 GND 10k
R3 A N2 100k
R4 N4 N5 1k
R5 N0 N3 100k
R6 A LABEL_NET_0 10k
C1 N2 N7 10p
C2 A N2 1n
C3 N0 N5 10p
C4 N0 N3 1n

* Differential Output Converter for easy measurement
E_diff out_diff 0 N2 N0 1

* Sources
VLABEL_NET_0 LABEL_NET_0 0 DC 0 AC 1 SIN(0 0.1 1k)

* CMFB and Supply Limits Stimuli
B_CMFB_N6 N6 0 I=1m*(V(N6)+V(N4))+10u*V(N6)*V(N6)*V(N6)
B_CMFB_N4 N4 0 I=1m*(V(N6)+V(N4))+10u*V(N4)*V(N4)*V(N4)
B_CMFB_N2 N2 0 I=1m*(V(N2)+V(N0))+10u*V(N2)*V(N2)*V(N2)
B_CMFB_N0 N0 0 I=1m*(V(N2)+V(N0))+10u*V(N0)*V(N0)*V(N0)

.control
* AC Analysis
ac dec 100 1 10Meg
meas ac dc_gain find vdb(out_diff) at=10
meas ac bandwidth when vdb(out_diff)='dc_gain - 3' fall=1
print dc_gain
print bandwidth

* Transient Analysis
tran 10u 10m
meas tran vout_max max v(out_diff)
meas tran vout_min min v(out_diff)

linearize v(out_diff)
set specwindow=rectangular
fft v(out_diff)
meas sp fund find mag(v(out_diff)) at=1k
meas sp h2 find mag(v(out_diff)) at=2k
meas sp h3 find mag(v(out_diff)) at=3k
meas sp h4 find mag(v(out_diff)) at=4k
meas sp h5 find mag(v(out_diff)) at=5k
meas sp h6 find mag(v(out_diff)) at=6k
meas sp h7 find mag(v(out_diff)) at=7k
meas sp h8 find mag(v(out_diff)) at=8k
meas sp h9 find mag(v(out_diff)) at=9k
let thd = 100 * sqrt(h2*h2 + h3*h3 + h4*h4 + h5*h5 + h6*h6 + h7*h7 + h8*h8 + h9*h9) / (fund + 1e-12)
print thd

* Noise Analysis
noise v(out_diff) VLABEL_NET_0 dec 100 10 22k
setplot noise1
let noise_sq = onoise_spectrum * onoise_spectrum
meas noise total_noise_sq integ noise_sq
let snr = 20 * log10(0.5987 / sqrt(total_noise_sq))
print snr

quit
.endc
.end