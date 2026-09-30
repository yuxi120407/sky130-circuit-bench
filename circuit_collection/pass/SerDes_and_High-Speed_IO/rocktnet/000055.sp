* LVDS Receiver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=10.0 L_xm1=0.15
.param W_xm2=10.0 L_xm2=0.15
.param W_xm3=40.0 L_xm3=0.15
.param W_xm4=40.0 L_xm4=0.15
.param W_xm5=40.0 L_xm5=0.15
.param W_xm6=2.0 L_xm6=0.15
.param W_xm7=10.0 L_xm7=0.15
.param W_xm8=2.0 L_xm8=0.15
.param W_xm9=12.0 L_xm9=0.15
.param W_xm10=48.0 L_xm10=0.15

XM1 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N4 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Power supply and tail current source
VVDD VDD 0 1.8
I_tail VDD N2 200u

* Input signals (Common mode = 1.25V, AC diff = 1V, Transient diff = 350mVpp)
VCM VCM 0 1.25
VDIFF VDIFF 0 dc 0 ac 1 pulse(-0.175 0.175 0 100p 100p 400p 1n)
B_IN_P LABEL_NET_0 0 V=v(VCM) + v(VDIFF)/2
B_IN_N LABEL_NET_1 0 V=v(VCM) - v(VDIFF)/2

* Load capacitance
C_load N4 0 50f

.control
  * DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * AC Analysis
  ac dec 50 1Meg 10G
  meas ac voltage_gain find vdb(N4) at=1Meg
  meas ac bandwidth when vdb(N4)='voltage_gain - 3' fall=1
  print voltage_gain bandwidth

  * Transient Analysis
  tran 10p 5n
  meas tran v_out_max max v(N4)
  meas tran v_out_min min v(N4)
  meas tran propagation_delay_rise trig v(VDIFF) val=0 rise=2 targ v(N4) val=0.9 rise=2
  meas tran propagation_delay_fall trig v(VDIFF) val=0 fall=2 targ v(N4) val=0.9 fall=2
  print v_out_max v_out_min propagation_delay_rise propagation_delay_fall

  * DC Sweep for Transfer Characteristic
  dc VDIFF -0.5 0.5 0.01
  meas dc input_sensitivity when v(N4)=0.9 rise=1
  print input_sensitivity
  
  quit
.endc
.end