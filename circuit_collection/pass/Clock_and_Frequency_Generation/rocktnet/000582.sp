* Injection-Locked Frequency Divider Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm3=5.0 L_xm3=0.15
.param W_xm2=5.0 L_xm2=0.15
.param W_xm1=5.0 L_xm1=0.15

* DUT
XM3 Q QX N_TAIL N_TAIL sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 QX Q N_TAIL N_TAIL sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 N_TAIL IN VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* LC Tank (added to make the oscillator functional)
L1 VDD Q 1n
L2 VDD QX 1n
C1 Q 0 1p
C2 QX 0 1p
R1 Q VDD 500
R2 QX VDD 500

* Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
* 10 GHz input signal for injection locking (divide-by-2 -> 5 GHz output)
VIN IN 0 DC 0.9 SIN(0.9 0.5 10G 0 0)

* Initial conditions to kickstart oscillation
.ic v(Q)=1.9 v(QX)=1.7

.control
* Run transient analysis
tran 2p 10n uic

* Measure operating frequency (should be 5 GHz)
meas tran t1 trig v(Q) val=1.8 rise=30 targ v(Q) val=1.8 rise=31
let freq = 1/t1
print freq

* Measure output voltage swing
meas tran vmax max v(Q) from=5n to=10n
meas tran vmin min v(Q) from=5n to=10n
let vpp = vmax - vmin
print vpp

* Measure power consumption
meas tran iavg avg i(VVDD) from=5n to=10n
let power = -iavg * 1.8
print power

quit
.endc
.end
