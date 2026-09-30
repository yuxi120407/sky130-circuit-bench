* Fully Differential OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1a=0.5
.param L_xm1b=0.5
.param L_xm2a=0.5
.param L_xm2b=0.5
.param L_xm3a=0.5
.param L_xm3b=0.5
.param L_xm4a=0.5
.param L_xm4b=0.5
.param L_xm5=0.5

* Parameterized W/L
.param W_xm3a=5.0 L_xm3a=0.5
.param W_xm4a=5.0 L_xm4a=0.5
.param W_xm2a=5.0 L_xm2a=0.5
.param W_xm2b=5.0 L_xm2b=0.5
.param W_xm3b=5.0 L_xm3b=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm1b=5.0 L_xm1b=0.5
.param W_xm1a=5.0 L_xm1a=0.5
.param W_xm4b=5.0 L_xm4b=0.5

* DUT
XM3A VOUTP N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3a} w={W_xm3a}
XM4A VOUTP VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4a} w={W_xm4a}
XM2A N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2a} w={W_xm2a}
XM2B N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2b} w={W_xm2b}
XM3B VOUTN N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3b} w={W_xm3b}
XM5 N1 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM1B N0 VINN N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1b} w={W_xm1b}
XM1A N2 VINP N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1a} w={W_xm1a}
XM4B VOUTN VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4b} w={W_xm4b}

* Power and Bias
VVDD VDD 0 1.8
VVBIAS VBIAS 0 0.54

* Input Signals (Common-mode and Differential)
V_IN_CM IN_CM 0 DC 0.9 AC 0
V_IN_DIFF IN_DIFF 0 DC 0 AC 1 PULSE(-0.5 0.5 10n 1n 1n 1u 2u)

E_VINP VINP 0 vol='v(IN_CM) + 0.5*v(IN_DIFF)'
E_VINN VINN 0 vol='v(IN_CM) - 0.5*v(IN_DIFF)'

* Ideal CMFB / DC Biasing using Inductors
L1 VOUTP VCM 1000H
L2 VOUTN VCM 1000H
VCM VCM 0 0.9

* Load Capacitors
C1 VOUTP 0 1p
C2 VOUTN 0 1p

* Dummy node for differential output measurement
E_DIFF VOUT_DIFF 0 vol='v(VOUTP) - v(VOUTN)'

.control
  * 1. DC Operating Point for Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis - Differential
  ac dec 100 1 1G
  let gain_db = vdb(VOUT_DIFF)
  let phase = 180/PI * cph(v(VOUT_DIFF))
  meas ac dc_gain find gain_db at=10
  meas ac ugbw when gain_db=0 fall=1
  meas ac pm_phase find phase when gain_db=0 fall=1
  let phase_margin = pm_phase + 180
  print dc_gain ugbw phase_margin

  * 3. AC Analysis - Common Mode (for CMRR)
  alter V_IN_DIFF ac=0
  alter V_IN_CM ac=1
  ac dec 100 1 1G
  let gain_cm_db = vdb(VOUT_DIFF)
  meas ac cm_gain find gain_cm_db at=10
  let cmrr_db = dc_gain - cm_gain
  print cmrr_db

  * 4. Transient Analysis for Slew Rate
  alter V_IN_DIFF ac=1
  alter V_IN_CM ac=0
  tran 1n 2u
  * Measure time to slew 1V (from -0.5V to +0.5V)
  meas tran t_rise trig v(VOUT_DIFF) val=-0.5 rise=1 targ v(VOUT_DIFF) val=0.5 rise=1
  let sr_rise_vus = 1e-6 / t_rise
  
  * Measure time to slew 1V (from +0.5V to -0.5V)
  meas tran t_fall trig v(VOUT_DIFF) val=0.5 fall=1 targ v(VOUT_DIFF) val=-0.5 fall=1
  let sr_fall_vus = 1e-6 / t_fall
  
  print sr_rise_vus sr_fall_vus
  quit
.endc
.end
