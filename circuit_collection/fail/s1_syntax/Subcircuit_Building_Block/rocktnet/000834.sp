* Active Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT (Adapted from generic NPN to SKY130 NMOS)
IB VDD N0 100u
MQ1 RFin RFin GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
RB N0 N3 1k
RA N2 RFin 500
MQB N0 N0 N1 GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
MQC N1 N1 GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
CB N0 GND 1p
MQA VDD N3 N2 GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15

* Sources
VVDD VDD 0 1.8
I_ac RFin 0 AC 1
I_step RFin 0 PULSE(0 1m 1n 100p 100p 5n 10n)

.control
* DC Sweep for Power and Bias Voltage
dc VVDD 0 1.8 0.05
let power = -i(VVDD) * v(VDD)
meas dc pwr_at_1v8 find power at=1.8
meas dc vbias_at_1v8 find v(RFin) at=1.8

* AC Analysis for Output Impedance
ac dec 20 1M 10G
let zout_db = vdb(RFin)
meas ac zout_dc_db find zout_db at=1M
meas ac zout_5g_db find zout_db at=5.2G

* Transient Analysis for Load Step Response
tran 10p 10n
meas tran v_max max v(RFin)
meas tran v_min min v(RFin)

quit
.endc
.end