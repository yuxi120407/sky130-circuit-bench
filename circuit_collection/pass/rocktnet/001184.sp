* 1.75-GHz Passive Mixer Testbench
.param f_LO=1.75G
.param f_BB=8Meg
.param T_LO={1/f_LO}
.param T_LO_half={T_LO/2}

* Baseband input with 0.9V DC bias
VREF VREF 0 DC 0.9 SIN(0.9 0.5 8Meg)

* LO signals (1.75 GHz)
VLO_P LO_P 0 PULSE(0 1.8 0 10p 10p {T_LO_half - 10p} T_LO)
VLO_N LO_N 0 PULSE(0 1.8 T_LO_half 10p 10p {T_LO_half - 10p} T_LO)

* DUT: Mixer core (with corrected switch syntax and added component values)
R1 VREF node_A 100
R2 node_A OUT 100
R3 node_A OUTB 100
R4 OUT GND 1k
C1 OUT GND 100f
C2 OUTB GND 100f

S3 OUTB node_A LO_N 0 switch_ideal
S1 node_A OUT LO_P 0 switch_ideal
S5 OUTB GND LO_P 0 switch_ideal
S2 OUT GND LO_N 0 switch_ideal

.model switch_ideal SW(vt=0.9 vh=0.1 ron=10 roff=1G)

* Demodulation for measurement
B1 out_diff 0 V=V(OUT)-V(OUTB)

* Fundamental Demod
VLO_ideal LO_ideal 0 SIN(0 1 1.75G)
B2 bb_demod 0 V=V(out_diff)*V(LO_ideal)
R_lpf bb_demod bb_filt 1k
C_lpf bb_filt 0 5p

* 3rd Harmonic Demod
VLO_3rd LO_3rd 0 SIN(0 1 5.25G)
B3 bb_demod_3rd 0 V=V(out_diff)*V(LO_3rd)
R_lpf3 bb_demod_3rd bb_filt_3rd 1k
C_lpf3 bb_filt_3rd 0 5p

* 5th Harmonic Demod
VLO_5th LO_5th 0 SIN(0 1 8.75G)
B4 bb_demod_5th 0 V=V(out_diff)*V(LO_5th)
R_lpf5 bb_demod_5th bb_filt_5th 1k
C_lpf5 bb_filt_5th 0 5p

.control
tran 2p 250n

* Measure Conversion Gain
meas tran bb_max max v(bb_filt) from=125n to=250n
meas tran bb_min min v(bb_filt) from=125n to=250n
let bb_amp = (bb_max - bb_min)/2
let conv_gain_linear = bb_amp / 0.5
let conv_gain_db = 20 * log10(conv_gain_linear)
print conv_gain_db

* Measure LO Leakage
meas tran bb_avg avg v(bb_filt) from=125n to=250n
let lo_leakage_amp = bb_avg * 2
let lo_leakage_dbm = 10 * log10((lo_leakage_amp * lo_leakage_amp / 2 / 50) * 1000)
print lo_leakage_dbm

* Measure 3rd Harmonic Rejection
meas tran bb_max_3rd max v(bb_filt_3rd) from=125n to=250n
meas tran bb_min_3rd min v(bb_filt_3rd) from=125n to=250n
let bb_amp_3rd = (bb_max_3rd - bb_min_3rd)/2
let hrr_3rd = 20 * log10(bb_amp / bb_amp_3rd)
print hrr_3rd

* Measure 5th Harmonic Rejection
meas tran bb_max_5th max v(bb_filt_5th) from=125n to=250n
meas tran bb_min_5th min v(bb_filt_5th) from=125n to=250n
let bb_amp_5th = (bb_max_5th - bb_min_5th)/2
let hrr_5th = 20 * log10(bb_amp / bb_amp_5th)
print hrr_5th

quit
.endc
.end
