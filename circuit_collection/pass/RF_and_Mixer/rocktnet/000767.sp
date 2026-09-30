* Passive Balun Testbench

* DUT (Capacitor values added for simulation validity)
C1 N1 N2 100f
C3 N1 N3 100f
C4 N2 N4 100f
C2 N3 N4 100f
C6 N3 GND 100f
C5 N4 GND 100f

* Sources and Terminations (50 ohm system)
V1 N_in GND dc 0 ac 2
R1 N_in N1 50
R2 N2 GND 50
R3 N3 GND 50
R4 N4 GND 50

.control
ac dec 50 1G 100G

* S-parameters (V_source = 2V -> V_incident = 1V)
let v_ref = v(N1) - 1
let s11_db = 20 * log10(mag(v_ref))
let s31_db = 20 * log10(mag(v(N3)))
let s41_db = 20 * log10(mag(v(N4)))

* Imbalance calculations
let amp_imb = s31_db - s41_db
let phase3 = 180/PI * cph(v(N3))
let phase4 = 180/PI * cph(v(N4))
let phase_diff = phase3 - phase4
let phase_imb = phase_diff - 180

* Measure metrics at 30 GHz (center of 20-40 GHz band)
meas ac il_31_30G find s31_db at=30G
meas ac il_41_30G find s41_db at=30G
meas ac rl_30G find s11_db at=30G
meas ac amp_imb_30G find amp_imb at=30G
meas ac phase_imb_30G find phase_imb at=30G

print il_31_30G il_41_30G rl_30G amp_imb_30G phase_imb_30G
quit
.endc
.end
