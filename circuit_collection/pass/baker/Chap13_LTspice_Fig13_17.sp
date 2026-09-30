* Cross-Coupled Inverter Latch Metastability Simulation (Fig 13.17)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=1.5 L_xm1=0.15
.param W_xm2=3.0 L_xm2=0.15
.param W_xm3=1.5 L_xm3=0.15
.param W_xm4=3.0 L_xm4=0.15

* DUT - Cross-coupled inverters with 50fF capacitors
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Vin Vout 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 Vin Vout VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
C1 Vout 0 5e-14
C2 Vin 0 5e-14

* AC stimulus for loop gain measurement
Iac Vin 0 DC 0 AC 1

* Nodeset for exact metastable point in OP/AC
.nodeset v(Vin)=0.9 v(Vout)=0.9

* Initial condition placed near metastable switching point (VDD/2 = 0.9V)
* with a tiny 0.5mV perturbation to trigger resolution
.ic v(Vin)=0.9005 v(Vout)=0.8995

.control
* 1. DC Operating Point for switching point voltage
op
let switching_point_voltage = v(Vin)
print switching_point_voltage

* 2. AC Analysis for small-signal loop gain
ac lin 1 1 1
let gain_mag = abs(v(Vout)/v(Vin))
let small_signal_loop_gain = 40 * log10(gain_mag)
print small_signal_loop_gain

* 3. Transient Analysis for resolution time and levels
tran 10p 4n
let idd = -i(VDD)
meas tran metastable_current find idd at=0

* Measure final resolved logic levels
meas tran output_high_voltage max v(Vin)
meas tran output_low_voltage min v(Vout)

* Measure resolution time to reach valid logic levels (10% to 90% of VDD)
meas tran metastability_resolution_time trig v(Vin) val=0.95 rise=1 targ v(Vin) val=1.62 rise=1

.endc
.end