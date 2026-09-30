* Testbench for Differential Reset Switch
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

XM1 VRES PHI2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 PHI2 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 PHI2 VRES GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 VDD N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 PHI2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 PHI2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 VDD N2 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

VVDD VDD 0 1.8
VVRES VRES 0 0.9
* Slower clock to allow settling
VPHI2 PHI2 0 PULSE(0 1.8 10n 0.1n 0.1n 400n 1000n)

C1 N1 0 1p
C2 N2 0 1p

* Initial conditions to simulate the nodes needing a reset
.ic v(N1)=1.4 v(N2)=0.4

.control
tran 0.1n 600n uic

* Measure reset time (settling to within ~10mV of VRES)
meas tran t_reset trig v(PHI2) val=0.9 rise=1 targ v(N1) val=0.91 fall=1

* Measure voltages after switches turn off (at 500ns, after falling edge at 410ns)
meas tran v_n1_final find v(N1) at=500n
meas tran v_n2_final find v(N2) at=500n

* Calculate charge injection errors
let v_inj_cm = ((v_n1_final + v_n2_final) / 2) - 0.9
let v_inj_diff = v_n1_final - v_n2_final

print t_reset v_inj_cm v_inj_diff
quit
.endc
.end