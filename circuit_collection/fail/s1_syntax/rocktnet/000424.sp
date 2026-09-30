* VCO Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

* Power and Bias Sources
VVDD VDD 0 1.8
VBIAS BIAS 0 0.8

* DUT: VCO Core
XM1 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

* Ideal LC Tank (Tuned to ~2.8 GHz)
L1 N0 N1 6.4nH
C1 N0 N1 0.5pF
R1 N0 N1 5k

* Dependent source to easily measure differential voltage
B1 diff 0 V=v(N0)-v(N1)

* Initial condition to kickstart oscillation
.ic v(N0)=1.0 v(N1)=0.8

.control
* Run transient analysis
tran 10p 50n

* Measure Oscillation Frequency
meas tran t_period trig v(diff) val=0 rise=2 targ v(diff) val=0 rise=12 from=20n to=50n
let oscillation_frequency = 10 / t_period
print oscillation_frequency

* Measure Peak-to-Peak Voltage Swing
meas tran vmax max v(diff) from=20n to=50n
meas tran vmin min v(diff) from=20n to=50n
let voltage_swing = vmax - vmin
print voltage_swing

* Measure Power Consumption
meas tran id_avg avg i(VVDD) from=20n to=50n
let power_consumption = -id_avg * 1.8
print power_consumption

* Measure DC Bias Voltage at Tank
meas tran dc_bias_meas avg v(N0) from=20n to=50n
let dc_bias = dc_bias_meas
print dc_bias

quit
.endc
.end