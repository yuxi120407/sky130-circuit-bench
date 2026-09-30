* LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=50.0 L_xm1=0.15
.param W_xm2=5.0 L_xm2=0.15

* DUT
XM1 N1 N2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 GND N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Supplies and Bias
Vdd VDD 0 1.8
Vbias Vbias_node 0 0.8

* Input Network (50 Ohm source)
Vac in_ac 0 dc 0 ac 1
Rs in_ac net_in 50
C2 net_in N2 10p
Rbias Vbias_node N2 10k

* Source Degeneration Inductor
L2 N0 0 1n

* Output Matching Network (Tuned for ~800 MHz)
L1 VDD N1 10n
C1 VDD N1 3.9p
R1 VDD N1 10k

.control
* 1. DC Power
op
let power_consumption = -i(Vdd) * 1.8
print power_consumption

* 2. AC Gain
ac dec 50 100Meg 10Gig
let gain_db = db(v(N1))
meas ac voltage_gain find gain_db at=800Meg
meas ac max_gain max gain_db
meas ac operating_frequency MAX_AT gain_db
print voltage_gain
print operating_frequency

* 3. Noise Figure
* 4*k*T*Rs = 4 * 1.38e-23 * 300 * 50 = 8.28e-19
noise v(N1) Vac dec 50 100Meg 10Gig
setplot noise1
let nf_db = 10 * log10((inoise_spectrum * inoise_spectrum) / 8.28e-19)
setplot ac1
let nf_db = noise1.nf_db
meas ac noise_figure find nf_db at=800Meg
print noise_figure

quit
.endc
.end