* CML 2:1 MUX Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0

* DUT
XM1 N1 AN N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 B N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 SELN N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 BN N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 A N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 SEL N4 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

* Load resistors (required for CML operation)
R1 VDD N1 1200
R2 VDD N2 1200

* DC Sources
VVDD VDD 0 1.8
VBIAS BIAS 0 1.2

* Input Stimuli (Common mode 1.55V, Swing 0.5V)
VA A 0 PWL(0 1.3 1n 1.3 1.05n 1.8 2n 1.8 2.05n 1.3 4n 1.3)
VAN AN 0 PWL(0 1.8 1n 1.8 1.05n 1.3 2n 1.3 2.05n 1.8 4n 1.8)
VB B 0 DC 1.8
VBN BN 0 DC 1.3
VSEL SEL 0 PWL(0 1.8 2.5n 1.8 2.55n 1.3 4n 1.3)
VSELN SELN 0 PWL(0 1.3 2.5n 1.3 2.55n 1.8 4n 1.8)

* Load capacitance
C1 N1 0 10f
C2 N2 0 10f

.control
tran 10p 4n

* Measure Output Swing
meas tran vhigh max v(n2)
meas tran vlow min v(n2)
let vswing = vhigh - vlow
print vswing

let vmid = (vhigh + vlow) / 2

* Measure Propagation Delays
meas tran delay_A trig v(A) val=1.55 rise=1 targ v(n2) val=$&vmid fall=1 td=0.9n
meas tran delay_SEL trig v(SEL) val=1.55 fall=1 targ v(n2) val=$&vmid fall=1 td=2.4n

* Measure Power Consumption
meas tran pwr_avg avg i(VVDD)
let power = -pwr_avg * 1.8
print power
print delay_A
print delay_SEL

quit
.endc
.end