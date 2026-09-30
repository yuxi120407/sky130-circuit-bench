* Cascaded Inverters Delay Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0

* Define parameters for the DUT (example sizing)
.param W_xm1=1 W_xm2=2 W_xm3=4 W_xm4=8
.param L_xm1=0.15 L_xm2=0.15 L_xm3=0.15 L_xm4=0.15

* DUT
xm1 N001 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 N001 Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Vout N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 Vout N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
Cload Vout 0 5e-14

* Stimulus
Vin Vin 0 PULSE(0 1.8 1n 50p 50p 2n 4n)

.control
tran 1p 5n

* Measure delays from Vin to Vout (overall non-inverting)
meas tran t_plh trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 rise=1
meas tran t_phl trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 fall=1

let t_delay_avg = (t_plh + t_phl)/2
print t_plh t_phl t_delay_avg
quit
.endc
.end