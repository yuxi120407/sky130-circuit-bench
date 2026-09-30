* Bias Decoupling Network Testbench

.param Rbias=1k
.param CRF_shunt2=1p

* DUT
Rbias Vg2 N1 Rbias
CRF_shunt2 N1 GND CRF_shunt2

* Stimulus (Applying AC signal at the RF side to measure isolation at the bias side)
Vin Vg2 GND dc 1.0 ac 1.0

.control
* AC Analysis to measure filter characteristics
ac dec 100 1Meg 100G
let gain_db = vdb(N1)

* Measure -3dB cutoff frequency
meas ac f_3db when gain_db=-3 fall=1

* Measure attenuation at 40 GHz
meas ac atten_40G find gain_db at=40G

* DC Operating Point
op
print v(N1)

quit
.endc
.end