* Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
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
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0

VVDD VDD 0 1.8
VVBIAS VBIAS 0 0.8

* For Tran analysis
VMINUS VMINUS 0 0.9
VPLUS VPLUS 0 dc 0.9 pulse(0.7 1.1 5n 0.5n 0.5n 20n 40n)

* DUT
XM1 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 VPLUS N3 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 VOUT N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 VOUT N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N4 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N0 VMINUS N3 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}

.control
  * 1. DC Operating Point (Power)
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * 2. Transient Analysis (Delay)
  tran 0.1n 40n
  meas tran t_pHL trig v(VPLUS) val=0.9 rise=1 targ v(VOUT) val=0.9 fall=1
  meas tran t_pLH trig v(VPLUS) val=0.9 fall=1 targ v(VOUT) val=0.9 rise=1
  let propagation_delay = (t_pHL + t_pLH) / 2
  print t_pHL t_pLH propagation_delay

  * 3. DC Sweep Forward (Trip point & Offset)
  dc VPLUS 0.7 1.1 0.001
  meas dc v_trip_fwd when v(VOUT)=0.9 cross=1
  set v_fwd = $&v_trip_fwd

  * 4. DC Sweep Reverse (Hysteresis)
  dc VPLUS 1.1 0.7 -0.001
  meas dc v_trip_rev when v(VOUT)=0.9 cross=1
  set v_rev = $&v_trip_rev

  let v_fwd_val = $v_fwd
  let v_rev_val = $v_rev
  let hysteresis = v_fwd_val - v_rev_val
  let offset_voltage = (v_fwd_val + v_rev_val)/2 - 0.9
  print v_fwd_val v_rev_val hysteresis offset_voltage

  quit
.endc
.end