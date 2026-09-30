* 20-GHz LNA with Active Balun Testbench

* Generic models for simulation
.model npn npn (is=1e-16 bf=100 cjc=10f cje=10f tf=5p)
.model Dmod D (is=1e-14 rs=10)

* DUT (with estimated passive values for 20 GHz operation)
Q1 N_Q1C N_Q1B N_Q1E npn
Q2 N_Q2C N_Q2B N_Q23E npn
Q3 N_Q3C N_Q3B N_Q23E npn
Q4 VDD N_Q2C N_Q4E npn
Q5 VDD N_Q3C N_Q5E npn
Q6 IBias1 IBias1 GND npn
Q7 IBias2 IBias2 GND npn

Lc1 VDD N_Q1C 1n
Lc2 VDD N_Q2C 1n
Lc3 VDD N_Q3C 1n
Lb1 N_Q1B IBias1 0.5n
Le1 N_Q1E GND 0.1n
Lb2 N_Q2B IBias2 0.5n
Le2 N_Q23E GND 0.5n
Lb3 N_Q3B IBias2 0.5n
Le4 N_Q4E N_D1 1n
Le5 N_Q5E N_D2 1n

Cb1 Vin N_Q1B 1p
Cb2 N_Q1C N_Q2B 1p
Ce2 N_Q23E GND 126f
Ce4 N_D1 Vout_plus 1p
Ce5 N_D2 Vout_minus 1p

D1 GND N_D1 Dmod
D2 GND N_D2 Dmod

* DC and AC Sources
VVDD VDD 0 1.8
VIBIAS1 IBIAS1 0 0.9
VIBIAS2 IBIAS2 0 0.9
VVIN Vin 0 DC 0 AC 1

* 50-Ohm Terminations
Rload1 Vout_plus 0 50
Rload2 Vout_minus 0 50

.control
* DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* AC Analysis for Gain and Balun Imbalance
ac dec 50 1G 50G

let vout_diff = v(Vout_plus) - v(Vout_minus)
let gain_db = 20*log10(mag(vout_diff))
let phase_diff = 180/PI * (cph(v(Vout_plus)) - cph(v(Vout_minus)))

meas ac gain_20G find gain_db at=20G
meas ac phase_diff_20G find phase_diff at=20G

meas ac vout_plus_mag find mag(v(Vout_plus)) at=20G
meas ac vout_minus_mag find mag(v(Vout_minus)) at=20G
let amp_imbalance = 20*log10(vout_plus_mag / vout_minus_mag)
print amp_imbalance

quit
.endc
.end
