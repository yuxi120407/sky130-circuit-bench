* CMOS Direct Injection-Locked Oscillator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

* Override default parameters for RF operation
.param W_xm1=20.0 L_xm1=0.15
.param W_xm2=20.0 L_xm2=0.15
.param W_xm3=40.0 L_xm3=0.15
.param W_xm4=10.0 L_xm4=0.15

VVDD VDD 0 1.8
VVSS VSS 0 0
VBIAS BIAS 0 0.7
VIN IN 0 DC 0

* LC Tank
L1 VDD Q 2n
L2 VDD QX 2n
C1 Q 0 1p
C2 QX 0 1p
R1 Q VDD 300
R2 QX VDD 300

* DUT
XM1 Q QX TAIL VSS sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 QX Q TAIL VSS sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 TAIL BIAS VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 Q IN QX VSS sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Initial condition to kickstart oscillation
.ic v(Q)=1.8 v(QX)=0

.control
tran 10p 20n

* 1. Power consumption
meas tran avg_I avg i(VVDD) from=10n to=20n
let power = -avg_I * 1.8
print power

* 2. Oscillation frequency
meas tran t1 trig v(Q) val=1.8 rise=20
meas tran t2 trig v(Q) val=1.8 rise=30
let osc_freq = 10 / (t2 - t1)
print osc_freq

* 3. Voltage swing
meas tran vmax max v(Q) from=10n to=20n
meas tran vmin min v(Q) from=10n to=20n
let v_swing = vmax - vmin
print v_swing

quit
.endc
.end
