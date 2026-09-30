.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

* Include SKY130 models
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

* VDD and signals
Vdd VDD GND 1.8
Vphi PHI_SAE GND PULSE(0 1.8 1.2n 50p 50p 1.3n 5n)
Vpre PRE_B GND PULSE(1.8 0 1n 50p 50p 2n 5n)

* Bitline precharge voltages (50mV differential)
V3 N3_pre GND 1.8
V4 N4_pre GND 1.75

* Precharge switches
S3 N3_pre N3 PRE_B GND sw_ideal
S4 N4_pre N4 PRE_B GND sw_ideal
S1 VDD N1 PRE_B GND sw_ideal
S2 VDD N2 PRE_B GND sw_ideal
.model sw_ideal sw vt=0.9 vh=0.1 ron=100 roff=1G

* Capacitances (Bitlines and Outputs)
C1 N1 GND 10f
C2 N2 GND 10f
C3 N3 GND 100f
C4 N4 GND 100f
C5 N5 GND 5f

* Initial conditions to prevent massive startup current
.ic v(N1)=1.8 v(N2)=1.8 v(N3)=1.8 v(N4)=1.75 v(N5)=0

* DUT
XM1 N1 N2 N4 N4 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N1 N3 N3 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N3 N5 N5 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N4 N5 N5 sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 PHI_SAE GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

.control
tran 10p 5n uic

* Measure sensing delay
meas tran t_sense trig v(PHI_SAE) val=0.9 rise=1 targ v(N1) val=0.9 fall=1

* Measure output voltage swing
meas tran v_out_high max v(N2)
meas tran v_out_low min v(N1)
let v_swing = v_out_high - v_out_low
print v_swing

* Measure energy per operation (integrating current from precharge sources)
meas tran q_v3 integ i(V3)
meas tran q_v4 integ i(V4)
meas tran q_vdd integ i(Vdd)
* Energy = V * I * t = V * Q. Current flows out of positive terminal, so i(V) is negative.
let energy_op = -1.8 * (q_v3 + q_v4 + q_vdd)
print energy_op

quit
.endc
.end
