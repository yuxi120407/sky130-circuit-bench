* Q-Enhanced LC Filter Testbench

* Behavioral parameters to match paper specs (2.5GHz, 70MHz BW, 23dB Gain)
.param Rs_val=50
.param Rp_val=157
.param C_val=4.053p
.param L_val=0.001
.param gmi_val=25.17m
.param gmn_val=-4.59m

* Original pseudo-SPICE netlist from paper:
* V1 Vs GND AC
* Rs Vs Vi Rs
* gmi (Vi GND N1 GND) amplifier
* Rp N1 GND Rp
* C N1 GND
* L N1 GND
* gmn (N1 GND N1 GND) amplifier

* Adapted valid ngspice netlist:
V1 Vs GND dc 0 ac 1
Rs Vs Vi Rs_val
Gmi N1 GND Vi GND gmi_val
Rp N1 GND Rp_val
C N1 GND {C_val}
L N1 GND {L_val}
Gmn N1 GND N1 GND gmn_val

.control
* High resolution AC sweep around the 2.5 GHz center frequency
ac lin 2000 2G 3G

* Calculate voltage gain in dB (from filter input Vi to output N1)
let gain_db = vdb(N1) - vdb(Vi)

* Measure peak gain
meas ac max_gain max gain_db

* Calculate 3-dB drop level
let gain_3db = max_gain - 3

* Measure lower and upper 3-dB frequencies
meas ac f_low when gain_db=gain_3db rise=1
meas ac f_high when gain_db=gain_3db fall=1

* Calculate Bandwidth, Center Frequency, and Q-factor
let bw = f_high - f_low
let f_center = (f_low + f_high) / 2
let q_factor = f_center / bw

* Print results
print max_gain f_center bw q_factor
quit
.endc
.end
