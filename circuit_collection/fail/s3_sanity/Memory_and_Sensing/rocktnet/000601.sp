* Latch Testbench
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

VVDD VDD 0 1.8
VSET LABEL_NET_0 0 PULSE(1.8 -1.8 1n 50p 50p 2n 10n)
VRESET LABEL_NET_2 0 PULSE(1.8 -1.8 5n 50p 50p 2n 10n)
VBIAS LABEL_NET_3 0 1.8
VDUMMY1 LABEL_NET_1 0 0
VDUMMY4 LABEL_NET_4 0 0

XM1 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 GND LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 GND GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 GND LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

.ic v(N0)=0 v(N1)=1.8
.nodeset v(N0)=0 v(N1)=1.8

.control
  * DC Operating Point for static power
  op
  let power_static = -i(VVDD) * 1.8
  print power_static

  * Transient Analysis
  tran 10p 8n
  
  * Measure delays
  meas tran delay_set trig v(LABEL_NET_0) val=0.9 fall=1 targ v(N0) val=0.9 rise=1
  print delay_set
  
  meas tran delay_reset trig v(LABEL_NET_2) val=0.9 fall=1 targ v(N1) val=0.9 rise=1
  print delay_reset
  
  * Measure dynamic current (multiply by 1.8V for power)
  meas tran i_avg avg i(VVDD) from=0 to=8n
  let power_dynamic = -i_avg
  print power_dynamic
  
  quit
.endc
.end