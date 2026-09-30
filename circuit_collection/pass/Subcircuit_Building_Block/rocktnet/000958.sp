* PMOS Common-Source Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5
XM1 N2 N0 N1 N1 sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}

* Supply and Bias
Vdd N1 0 DC 1.8
Iload N2 0 DC 16.7u

* DC Feedback for Biasing (Acts as open circuit for AC)
Lbias N2 N0 1G

* AC Input Coupling (Acts as short circuit for AC)
Cin in_ac N0 1G
Vac in_ac 0 DC 0 AC 1

* Load Capacitance to set bandwidth to ~500Hz
Cload N2 0 500p

.control
op
let power = -i(Vdd) * 1.8
print power
print v(N2) v(N0)

ac dec 10 1 100k
let gain_db = vdb(N2)
meas ac gain_10Hz find gain_db at=10
meas ac gain_100Hz find gain_db at=100
meas ac gain_500Hz find gain_db at=500
meas ac gain_1kHz find gain_db at=1k
quit
.endc
.end