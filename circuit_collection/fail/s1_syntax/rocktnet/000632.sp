* Testbench for Crosstalk Cancellation / Equalizer Circuit

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm20=0.5
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
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm20=5.0 L_xm20=0.5

XM1 N12 LABEL_NET_1 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N11 N10 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N11 LABEL_NET_3 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N14 N6 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N8 N4 N13 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N15 N5 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N8 N3 N15 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N8 N0 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N11 N11 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N8 N3 N14 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N1 N5 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N9 N6 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N13 N3 N14 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 N12 N3 N15 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N15 N0 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XM19 N14 N4 N13 GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 N13 LABEL_NET_6 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}

* Output Load
Rout N8 VDD 1k

* Power Supply
VVDD VDD 0 1.8

* Data Inputs (Differential)
V_LABEL_NET_6 LABEL_NET_6 0 dc 0.9 ac -0.5 pulse(0.8 1.0 0 10p 10p 100p 200p)
V_N6 N6 0 dc 0.9 ac 0.5 pulse(1.0 0.8 0 10p 10p 100p 200p)

* Tap Weight Controls
V_N0 N0 0 1.2
V_N3 N3 0 0.9
V_N4 N4 0 0.6

* Crosstalk / Secondary Inputs
V_LABEL_NET_1 LABEL_NET_1 0 0.9
V_N5 N5 0 0.9

* Bias Inputs
V_N7 N7 0 0.9
V_N10 N10 0 0.9
V_LABEL_NET_3 LABEL_NET_3 0 0.9

* Unused / Dummy sources from original testbench
V_LABEL_NET_0 LABEL_NET_0 0 0.9
V_LABEL_NET_2 LABEL_NET_2 0 0.9
V_LABEL_NET_4 LABEL_NET_4 0 0.9

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 50 10Meg 100Gig
  let gain_db = vdb(N8)
  meas ac dc_gain find gain_db at=10Meg
  meas ac bw_3db when gain_db=(dc_gain-3) fall=1

  * Transient Analysis
  tran 1p 500p
  meas tran vout_max max v(N8)
  meas tran vout_min min v(N8)
  meas tran vout_pp param vout_max-vout_min
  
  * Delay measurement
  meas tran t_in trig v(N6) val=0.9 fall=1
  meas tran t_out trig v(N8) val=1.4 fall=1
  let delay = t_out - t_in
  print delay
  
  quit
.endc
.end
