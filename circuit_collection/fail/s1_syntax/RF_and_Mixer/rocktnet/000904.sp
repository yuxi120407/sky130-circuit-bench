* IF Balun Testbench

* DUT (Note: Resistor R was missing a value in the original netlist, assigned 100 ohms)
L1 1 NA 4.1nH
L2 1 NB 4.3nH
R1 NA NB 100
C1 1 GND 1.6pF
C2 NA GND 1.2pF
L3 NA 2 1.8nH
C5 2 GND 0.40pF
C4 NB 3 1.5pF
C3 NB GND 0.14pF
L4 3 GND 5.3nH

* Ground connection
Vgnd GND 0 0

* Sources and Terminations (50-ohm system)
Vin in GND dc 0 ac 2
Rin in 1 50
Rout2 2 GND 50
Rout3 3 GND 50

.control
ac lin 1000 1G 5G

* Insertion Loss
let s21_db = vdb(2)
let s31_db = vdb(3)
meas ac il_s21 find s21_db at=2.5G
meas ac il_s31 find s31_db at=2.5G

* Amplitude Imbalance
let amp_imb = s21_db - s31_db
meas ac amp_imbalance find amp_imb at=2.5G

* Phase Difference
let phase2 = 180/PI * cph(v(2))
let phase3 = 180/PI * cph(v(3))
let phase_diff = phase2 - phase3
meas ac phase_difference find phase_diff at=2.5G

* Return Loss (S11)
* With a 2V open-circuit source and 50 ohm series resistor, V_inc = 1V.
* Therefore, Gamma = V(1) - 1
let gamma = v(1) - 1
let s11_db = 20 * log10(mag(gamma))
meas ac return_loss find s11_db at=2.5G

print il_s21 il_s31 amp_imbalance phase_difference return_loss
quit
.endc
.end
