* Symmetrical OTA / Receiver Testbench
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

XM1 N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 LABEL_NET_1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

VVDD VDD 0 1.8
I_tail N4 0 200u
C_load N0 0 50f

V_in_plus LABEL_NET_0 0 DC 0.9 AC 1 PULSE(0.85 0.95 0.5n 50p 50p 0.95n 2n)
V_in_minus LABEL_NET_1 0 DC 0.9 AC 0 PULSE(0.95 0.85 0.5n 50p 50p 0.95n 2n)

.control
  * AC Analysis
  ac dec 100 1Meg 10G
  let gain_db = vdb(N0)
  let phase = 180/PI * cph(v(N0))
  
  meas ac dc_gain find gain_db at=1Meg
  meas ac bw_3db when phase=-45 fall=1
  meas ac gbw when gain_db=0 fall=1

  * Transient Analysis
  tran 10p 5n
  meas tran tpd_rise trig v(LABEL_NET_0) val=0.9 rise=1 targ v(N0) val=0.9 rise=1
  meas tran tpd_fall trig v(LABEL_NET_0) val=0.9 fall=1 targ v(N0) val=0.9 fall=1
  meas tran trise trig v(N0) val=0.36 rise=1 targ v(N0) val=1.44 rise=1
  meas tran tfall trig v(N0) val=1.44 fall=1 targ v(N0) val=0.36 fall=1
  
  let power = -i(VVDD) * 1.8
  meas tran avg_power avg power
  
  print dc_gain bw_3db gbw tpd_rise tpd_fall trise tfall avg_power
  quit
.endc
.end
