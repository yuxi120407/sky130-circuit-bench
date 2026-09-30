.param C_val=1p
.param L_val=0.5
* Coupled LC Tank Resonator Testbench

* DUT with parameterized values for 2GHz resonance
.param R_val=500 L_val=0.0053 C_val=1.0p Cc_val=0.2p

Iin GND IN AC 1
R1 Vout GND {R_val}
R2 IN GND {R_val}
L1 Vout GND {L_val}
L2 IN GND {L_val}
C1 IN GND {C_val}
C2 Vout GND {C_val}
Cc IN Vout Cc_val

* Define GND
Vgnd GND 0 DC 0

.control
ac dec 500 100MEG 10G
let z21_mag = mag(v(Vout))
let phase = 180/PI * cph(v(Vout))

* Measure maximum transimpedance gain and resonance frequency
meas ac max_gain MAX z21_mag
meas ac f_max WHEN z21_mag=max_gain

* Measure phase shift at the peak frequency
meas ac phase_at_fmax FIND phase WHEN z21_mag=max_gain

print max_gain f_max phase_at_fmax
quit
.endc
.end