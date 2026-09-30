* Cascaded Inverters Delay and Capacitance Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

* Define parameters for the parameterized netlist
.param W_xm1=1 L_xm1=0.15
.param W_xm2=2 L_xm2=0.15
.param W_xm3=4 L_xm3=0.15
.param W_xm4=8 L_xm4=0.15

* DUT (Device Under Test)
xm1 N001 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 N001 Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Vout N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 Vout N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
Cload Vout 0 5e-14

* Stimulus: DC/AC for AC analysis, PULSE for Transient analysis
Vsource Vin 0 DC 0.9 AC 1 PULSE(0 1.8 0.5n 50p 50p 2n 4n)

.control
* 1. Transient Analysis for Delays
tran 1p 5n
* Measure t_PLH: Vin rises to 50% (0.9V), Vout rises to 50% (0.9V)
meas tran t_plh trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 rise=1
* Measure t_PHL: Vin falls to 50% (0.9V), Vout falls to 50% (0.9V)
meas tran t_phl trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 fall=1

* 2. AC Analysis for Input Capacitance
ac dec 10 1G 10G
* Calculate capacitance: C = I / (2 * pi * f * V). Since V=1 (AC magnitude), C = I / (2*pi*f)
let omega = 2 * 3.14159265359 * frequency
let cin_mag = mag(i(Vsource)) / omega
meas ac cin_at_1G find cin_mag at=1G

* Output results
print t_plh t_phl cin_at_1G
quit
.endc
.end