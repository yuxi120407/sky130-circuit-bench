* WCDMA Baseband Low-Pass Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Component parameters for 1.92 MHz cutoff
.param Rval=8.29k
.param Cval=10p
.param Rgain=10k
.param Csmall=100f

* Ideal Op-Amp Subcircuit
.subckt amplifier out in_m in_p
E1 out 0 in_p in_m 100k
.ends

* DUT (Modified A1/A2 to X1/X2 for standard SPICE subcircuit syntax)
X1 N4 N1 N13 amplifier
X2 N3 N0 N2 amplifier
R1 N7 N13 100k
R2 N11 GND 100k
R3 N9 GND 100k
R4 N0 N7 100k
C1 N11 N13 Csmall
R5 N2 N6 Rgain
R7 N1 N6 Rgain
R6 N1 N4 Rgain
C2 N4 N15 {Cval}
R8 N2 N3 Rgain
R9 In N15 {Rval}
R10 N4 N5 {Rval}
C3 N13 GND {Cval}
R11 N8 Inb {Rval}
C4 N5 GND {Cval}
C5 N14 GND {Cval}
R12 N0 N8 {Rval}
R13 N13 N15 {Rval}
R14 N3 N14 {Rval}
C6 N0 GND {Cval}
C8 N3 N8 {Cval}
C7 N0 N9 Csmall
C9 N11 In Csmall
C10 N9 Inb Csmall

* Bias and Common Mode Sources
Vcm N6 0 DC 0.9
Voff N7 0 DC 0.9

* Differential Input Stimulus
VIN In 0 DC 0.9 AC 1 SIN(0.9 0.1 100k 0 0)
VINB Inb 0 DC 0.9 AC -1 SIN(0.9 -0.1 100k 0 0)

.control
* AC Analysis for Frequency Response
ac dec 100 1k 100Meg

* Calculate differential gain in dB
let vout_diff = v(N5) - v(N14)
let vin_diff = v(In) - v(Inb)
let gain_db = 20 * log10(mag(vout_diff) / mag(vin_diff))

* Measure Passband Gain at 10 kHz
meas ac passband_gain find gain_db at=10k

* Measure -3dB Cutoff Frequency
let gain_3db = passband_gain - 3
meas ac cutoff_freq when gain_db=gain_3db fall=1

* Measure Stopband Attenuation at 10 MHz
meas ac gain_10M find gain_db at=10Meg
let stopband_attenuation = passband_gain - gain_10M
print stopband_attenuation

* Transient Analysis
tran 10n 20u
meas tran vout_diff_max max v(N5)-v(N14)
meas tran vout_diff_min min v(N5)-v(N14)

quit
.endc
.end