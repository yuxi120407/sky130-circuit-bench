* OTA Testbench
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

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5

XM1 N2 N1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 N3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 LABEL_NET_1 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 LABEL_NET_2 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N5 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

* Fix floating N4 (NMOS sources)
VN4 N4 0 0

* Power supply and Bias
VVDD VDD 0 1.8
IBIAS N0 0 10u

* Common mode and differential inputs
VCM_SRC VCM_NODE 0 0.9
* PWL source ensures AC/DC OP is at 0V, then steps for transient slew rate measurement
VDIFF_SRC VDIFF_NODE 0 dc 0 ac 1 PWL(0 0 10n 0 11n -0.5 5u -0.5 5.001u 0.5 10u 0.5 10.001u -0.5 15u -0.5)
E1 LABEL_NET_1 VCM_NODE VDIFF_NODE 0 0.5
E2 LABEL_NET_2 VCM_NODE VDIFF_NODE 0 -0.5

* Load capacitor
CL N5 0 1p

.control
  * 1. Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis
  ac dec 20 1 100Meg
  let gain_db = vdb(N5)
  let phase = 180/PI * cph(v(N5))
  
  meas ac dc_gain find gain_db at=10
  meas ac gbw when gain_db=0 fall=1
  meas ac phase_at_gbw find phase when gain_db=0 fall=1
  let pm = phase_at_gbw + 180
  print pm
  
  * Estimate Gm from GBW and CL (Gm = GBW * 2 * pi * C)
  let gm_est = gbw * 2 * 3.14159 * 1e-12
  print gm_est

  * 3. DC Sweep for Output Swing
  dc VDIFF_SRC -0.5 0.5 0.01
  meas dc vout_max max v(N5)
  meas dc vout_min min v(N5)

  * 4. Transient Analysis for Slew Rate
  tran 10n 15u
  * Measure rise time (starts at 5u)
  meas tran t_rise trig v(N5) val=0.5 td=4u rise=1 targ v(N5) val=1.3 td=4u rise=1
  let sr_rise = (1.3 - 0.5) / t_rise
  * Measure fall time (starts at 10u)
  meas tran t_fall trig v(N5) val=1.3 td=9u fall=1 targ v(N5) val=0.5 td=9u fall=1
  let sr_fall = (1.3 - 0.5) / t_fall
  print sr_rise sr_fall

  quit
.endc
.end
