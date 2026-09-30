* OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1p=0.5
.param L_xm2p=0.5
.param L_xm3n=0.5
.param L_xm4n=0.5
.param L_xm5p=0.5
.param L_xm6p=0.5

.param W_xm4n=5.0 L_xm4n=0.5
.param W_xm1p=5.0 L_xm1p=0.5
.param W_xm2p=5.0 L_xm2p=0.5
.param W_xm6p=5.0 L_xm6p=0.5
.param W_xm5p=5.0 L_xm5p=0.5
.param W_xm3n=5.0 L_xm3n=0.5

XM4N VOUT N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4n} w={W_xm4n}
XM1P N2 VIN_PLUS N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm1p} w={W_xm1p}
XM2P VOUT VIN_MINUS N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm2p} w={W_xm2p}
XM6P N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6p} w={W_xm6p}
XM5P N0 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5p} w={W_xm5p}
XM3N N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3n} w={W_xm3n}

VVDD VDD 0 1.8
IBIAS N3 0 10u

* Input source: DC 0.9V, AC 1V, Pulse for Slew Rate
VIN VIN_PLUS 0 DC 0.9 AC 1 PULSE(0.4 1.0 10n 1n 1n 1u 2u)

* Feedback network for DC biasing and AC open-loop
* L1 is a short at DC, open at AC. C1 is open at DC, short at AC.
L1 VOUT VIN_MINUS 1T
C1 VIN_MINUS 0 1T

* Load capacitor
CLOAD VOUT 0 1p

.control
  * 1. Operating Point for Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis for Gain, UGBW, Phase Margin
  ac dec 100 1 1G
  let gain_db = vdb(VOUT)
  let phase = 180/PI * cph(v(VOUT))
  let pm_deg = 180 + phase
  meas ac dc_gain find gain_db at=10
  meas ac ugbw when gain_db=0 fall=1
  meas ac pm find pm_deg when gain_db=0 fall=1
  print dc_gain ugbw pm

  * 3. Transient Analysis for Slew Rate
  * Alter L1 and C1 to create a unity-gain configuration for transient
  alter L1 1p
  alter C1 1f
  
  tran 1n 2u
  meas tran t_rise trig v(VOUT) val=0.5 rise=1 targ v(VOUT) val=0.9 rise=1
  meas tran t_fall trig v(VOUT) val=0.9 fall=1 targ v(VOUT) val=0.5 fall=1
  let sr_rise_vus = 0.4 / (t_rise * 1e6)
  let sr_fall_vus = 0.4 / (t_fall * 1e6)
  print sr_rise_vus sr_fall_vus

  quit
.endc
.end