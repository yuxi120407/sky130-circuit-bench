* Equalizer Stage Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
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
.param W_xm11=5.0 L_xm11=0.5

XM1 N4 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N2 N5 N5 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N7 N1 N4 N4 sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N2 N3 N3 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 GND LABEL_NET_0 N5 N5 sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 N3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 LABEL_NET_1 N2 N5 sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

VVDD VDD 0 1.8
Vbias1 N6 0 1.2
Vbias2 N8 0 0.9
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9

R1 VDD N7 1k
R2 VDD N0 1k

V_N1 in1 0 DC 1.5 AC 0.5 PULSE(1.0 1.8 0 20p 20p 480p 1000p)
V_N2 in2 0 DC 1.5 AC -0.5 PULSE(1.8 1.0 0 20p 20p 480p 1000p)
Rin1 in1 N1 50
Rin2 in2 N2 50

E_diff out_diff 0 N0 N7 1.0

.control
  op
  let power = -i(VVDD) * 1.8
  print power
  print v(N7) v(N0) v(N4) v(N3)

  ac dec 100 1M 100G
  meas ac dc_gain find vdb(out_diff) at=1M
  meas ac bw_3db when vdb(out_diff)='dc_gain - 3' fall=1
  print dc_gain bw_3db

  tran 1p 3n
  meas tran delay trig v(in1) val=1.4 rise=2 targ v(out_diff) val=0 rise=2
  print delay
.endc
.end