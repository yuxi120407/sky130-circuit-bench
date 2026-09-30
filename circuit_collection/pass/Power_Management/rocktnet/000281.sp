* SIMO Boost Converter Testbench
.param VDD=1.8

* Models
.model switch_ideal sw vt=0.5 vh=0.1 ron=0.05 roff=1meg
.model DMOD D(Is=1e-14 Rs=0.1 N=1)

* Corrected DUT (fixed switch syntax and added diode models)
Da N5 Voa DMOD
Vg Vg GND dc {VDD}
Db N4 Vob DMOD
S1 N1 GND ctrl1 GND switch_ideal
Sb N1 N4 ctrlb GND switch_ideal
C1 Voa GND 10u
Sa N1 N5 ctrla GND switch_ideal
C2 Vob Voa 10u
L N1 Vg 1u

* Loads
Rload_a Voa GND 120
Rload_b Vob GND 100

* Initial conditions to speed up steady state
.ic v(Voa)=2.95 v(Vob)=3.6

* Control Signals (1MHz base, 2us full cycle for 2 outputs)
Vctrl1a ctrl1a GND PULSE(0 1 0 1n 1n 0.3u 2u)
Vctrl1b ctrl1b GND PULSE(0 1 1.0u 1n 1n 0.4u 2u)
Bctrl1 ctrl1 GND V=V(ctrl1a)+V(ctrl1b)

Vctrla ctrla GND PULSE(0 1 0.3u 1n 1n 0.3u 2u)
Vctrlb ctrlb GND PULSE(0 1 1.4u 1n 1n 0.4u 2u)

* Analysis
.control
tran 10n 50u uic

* Measure steady state voltages
meas tran Voa_avg avg v(Voa) from=40u to=50u
meas tran Vob_avg avg v(Vob) from=40u to=50u

* Measure input power
meas tran Iin_avg avg i(Vg) from=40u to=50u
let Pin = -Iin_avg * 1.8

* Measure output power
let Pout_a = Voa_avg * Voa_avg / 120
let Pout_b = Vob_avg * Vob_avg / 100
let Pout_total = Pout_a + Pout_b

* Efficiency
let eff = Pout_total / Pin * 100

* Ripple
meas tran Voa_max max v(Voa) from=40u to=50u
meas tran Voa_min min v(Voa) from=40u to=50u
let Voa_ripple = Voa_max - Voa_min

meas tran Vob_max max v(Vob) from=40u to=50u
meas tran Vob_min min v(Vob) from=40u to=50u
let Vob_ripple = Vob_max - Vob_min

print Voa_avg Vob_avg Pin Pout_total eff Voa_ripple Vob_ripple
quit
.endc
.end
