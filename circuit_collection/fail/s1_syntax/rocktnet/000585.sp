* Injection-Locked Frequency Divider Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

VVDD VDD 0 1.8
VVSS VSS 0 0
VINX INX 0 DC 0.9 SIN(0.9 0.5 2.24G 0 0)

XM1 Q QX VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 Q INX QX GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 Q QX VSS GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 QX Q VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 QX Q VSS GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 QX QX Q GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 QX Q QX GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 QX Q QX GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* LC Tank to set free-running frequency ~1.12 GHz
L1 Q QX 10nH
C1 Q QX 2pF

.ic v(Q)=1.8 v(QX)=0

.control
  tran 10p 20n
  
  * Power consumption
  meas tran pwr_avg avg i(VVDD) from=10n to=20n
  let power = -pwr_avg * 1.8
  print power
  
  * Output frequency
  meas tran t1 trig v(Q) val=0.9 rise=12
  meas tran t2 trig v(Q) val=0.9 rise=13
  let period = t2 - t1
  let freq = 1 / period
  print freq
  
  * Output amplitude
  meas tran vmax max v(Q) from=10n to=20n
  meas tran vmin min v(Q) from=10n to=20n
  let vpp = vmax - vmin
  print vpp
  
  quit
.endc
.end