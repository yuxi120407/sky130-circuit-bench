* Clocked Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm11=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

* Define parameters for the parameterized netlist
.param W_xm1=2 L_xm1=0.15
.param W_xm11=2 L_xm11=0.15
.param W_xm2=2 L_xm2=0.15
.param W_xm3=2 L_xm3=0.15
.param W_xm4=2 L_xm4=0.15
.param W_xm5=2 L_xm5=0.15
.param W_xm6=2 L_xm6=0.15

* DUT (Directly pasted from prompt)
xm1 N001 clock 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm11 Outm clock Inm VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm2 Outp Outm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Outm Outp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 Inp clock Outp VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 Outm Outp N001 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 Outp Outm N001 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
Vinm Inm 0 500m

* Stimulus
* Clock pulse: 0 to 1.8V, 10ns period, 5ns width
Vclock clock 0 PULSE(0 1.8 5n 0.1n 0.1n 4.8n 10n)
* Inp pulse: 0.4V to 0.6V to create an imbalance against Inm (0.5V)
Vinp Inp 0 PULSE(0.4 0.6 0 0.1n 0.1n 15n 30n)

* Load capacitance to simulate realistic sensing conditions
Cload_p Outp 0 10f
Cload_m Outm 0 10f

.control
* Run transient analysis for 3 clock cycles
tran 10p 30n

* 1. Measure Latching Delay (Time from clock high to Outp reaching 90% of VDD)
meas tran delay_rise trig v(clock) val=0.9 rise=1 targ v(Outp) val=1.62 rise=1

* 2. Measure Average Current (from VDD source)
* Note: ngspice current through voltage source is negative when supplying power
meas tran avg_current_raw avg i(VDD)
let avg_current = -avg_current_raw
let avg_power = avg_current * 1.8
print avg_current
print avg_power

* 3. Measure Peak Contention Current
* Minimum value of i(VDD) corresponds to maximum current supplied
meas tran peak_current_raw min i(VDD)
let peak_contention_current = -peak_current_raw
print peak_contention_current

quit
.endc
.end
