* CML AND-Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm7=5.0
.param W_xm6=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xm10=5.0

XM1 QN A N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD VDD N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 VDD N5 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 BN N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 B N4 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM7 VDD QN CKN GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM6 CKN CKN N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM8 N4 CK N3 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 QN VDD CKN GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Power and Bias
VVDD VDD 0 1.8
VBIAS BIAS 0 1.5

* Inputs for Divide-by-2 configuration
VA A 0 1.8
VBN BN 0 1.4
* Short B to QN to create feedback for toggling
R_FB QN B 0.01

* Clock at 2.45 GHz (Period = 408.16ps)
VCK CK 0 PULSE(0.6 1.8 0 20p 20p 184.08p 408.16p)
VCKN CKN 0 PULSE(1.8 0.6 0 20p 20p 184.08p 408.16p)

* Load Resistors (Required for CML operation, missing in extracted netlist)
R_QN QN VDD 1k
R_N5 N5 VDD 1k

* Initial conditions to speed up steady state
.ic v(QN)=1.8 v(N5)=1.2 v(N3)=0.5 v(N4)=0.5 v(B)=1.8

.control
tran 2p 5n

* 1. Power Dissipation
let power = -i(VVDD) * 1.8
meas tran power_dissipation avg power from=1n to=5n

* 2. Output Voltage Swing
meas tran v_max max v(QN) from=1n to=5n
meas tran v_min min v(QN) from=1n to=5n
meas tran output_swing param='v_max - v_min'

* 3. Operating Frequency
meas tran t1 trig v(QN) val=1.65 rise=3
meas tran t2 trig v(QN) val=1.65 rise=4
meas tran operating_frequency param='1 / (t2 - t1)'

* 4. Propagation Delay (CK rise to QN fall)
meas tran t_ck trig v(CK) val=1.2 rise=9
meas tran t_qn trig v(QN) val=1.65 fall=9
meas tran propagation_delay param='t_qn - t_ck'

print power_dissipation output_swing operating_frequency propagation_delay

quit
.endc
.end