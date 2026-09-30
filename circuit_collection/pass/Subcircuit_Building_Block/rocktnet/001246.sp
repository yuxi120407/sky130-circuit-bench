* Pre-amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

XM1 N0 N3 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N3 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N2 LABEL_NET_2 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 LABEL_NET_5 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N0 LABEL_NET_6 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}

VVDD VDD 0 1.8
V_LABEL_NET_0 LABEL_NET_0 0 1.8
V_LABEL_NET_1 LABEL_NET_1 0 1.8
V_LABEL_NET_2 LABEL_NET_2 0 1.8
V_LABEL_NET_6 LABEL_NET_6 0 1.8

V_N3 N3 0 1.1
V_LABEL_NET_4 LABEL_NET_4 0 0.7

V_INP LABEL_NET_3 0 dc 0.9 ac 0.5 pulse(0.8 1.0 1n 50p 50p 2n 4n)
V_INN LABEL_NET_5 0 dc 0.9 ac -0.5 pulse(1.0 0.8 1n 50p 50p 2n 4n)

B1 OUT_DIFF 0 V=v(N2)-v(N0)
C1 N0 0 10f
C2 N2 0 10f

.control
  op
  let power = -i(VVDD)*1.8 - i(V_LABEL_NET_0)*1.8 - i(V_LABEL_NET_1)*1.8 - i(V_LABEL_NET_2)*1.8 - i(V_LABEL_NET_6)*1.8
  print power

  ac dec 100 1Meg 100Gig
  let gain_db = vdb(OUT_DIFF)
  meas ac dc_gain MAX gain_db
  meas ac f3db when gain_db='dc_gain - 3' fall=1

  tran 10p 5n
  meas tran t_delay trig v(LABEL_NET_3) val=0.9 rise=1 targ v(OUT_DIFF) val=0 rise=1
  
  quit
.endc
.end