* VCO Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM1 Q QX VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 QX Q VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 Q QX VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 QX Q VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Power Supplies
VVDD VDD 0 1.8
VVSS VSS 0 0

* Ideal LC Tank to enable oscillation
L1 Q QX 2n
C1 Q QX 2p
R1 Q QX 10k

* Initial condition to kickstart oscillation
.ic v(Q)=1.8 v(QX)=0

.control
  * Transient Analysis
  tran 10p 20n uic
  
  * Measure Oscillation Frequency
  meas tran t1 trig v(Q) val=0.9 rise=10 targ v(Q) val=0.9 rise=11
  let osc_freq = 1 / t1
  print osc_freq
  
  * Measure Amplitude
  meas tran vq_max max v(Q) from=10n to=20n
  meas tran vq_min min v(Q) from=10n to=20n
  let v_pp = vq_max - vq_min
  print v_pp
  
  * Measure Power Consumption
  meas tran i_vdd_avg avg i(VVDD) from=10n to=20n
  let power = -i_vdd_avg * 1.8
  print power
  
  quit
.endc
.end