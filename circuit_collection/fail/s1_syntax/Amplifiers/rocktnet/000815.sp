* 5T OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

* DUT
XM1 N1 LABEL_NET_0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_2 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}

* Connections to form 5T OTA
Vshort1 LABEL_NET_4 N1 0
Vshort2 LABEL_NET_3 N1 0

* Supplies and Bias
VVDD VDD 0 1.8
VBIAS LABEL_NET_1 0 0.7

* Load Capacitance
CL N0 0 100f

* Input Source
VIN IN_SRC 0 DC 0.9 AC 1 PULSE(0.6 1.2 1n 100p 100p 5n 10n)

* Input Connections
R_inp IN_SRC LABEL_NET_0 1m

* Feedback Network (Open loop for AC, Closed loop for DC)
R_fb N0 LABEL_NET_2 1G
C_in LABEL_NET_2 0 1G

.control
  * AC Analysis
  ac dec 100 1 10G
  let gain_db = vdb(N0)
  let phase_deg = 180/PI * cph(v(N0))
  meas ac dc_gain find gain_db at=10
  meas ac ugf when gain_db=0 fall=1
  meas ac phase_at_ugf find phase_deg when gain_db=0 fall=1
  let pm = 180 + phase_at_ugf
  print dc_gain ugf pm

  * OP Analysis
  op
  let power = -i(VVDD) * 1.8
  print power

  * TRAN Analysis (Unity Gain Configuration)
  alter r_fb 1m
  alter c_in 1f
  tran 10p 20n
  meas tran v_max max v(N0)
  meas tran v_min min v(N0)
  meas tran t_rise trig v(N0) val=0.7 rise=1 targ v(N0) val=1.1 rise=1
  meas tran t_fall trig v(N0) val=1.1 fall=1 targ v(N0) val=0.7 fall=1
  let sr_rise = (1.1 - 0.7) / t_rise
  let sr_fall = (1.1 - 0.7) / t_fall
  print sr_rise sr_fall
  quit
.endc
.end