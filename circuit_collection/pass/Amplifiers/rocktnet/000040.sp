* Two-Stage Op-Amp Unity-Gain Buffer Testbench
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

VVDD VDD 0 1.8
VBIAS1 LABEL_NET_1 0 0.6
VBIAS2 LABEL_NET_2 0 0.6
* Input biased at 1.1V to keep NMOS diff pair in saturation
VIN LABEL_NET_3 0 dc 1.1 ac 1 pulse(0.8 1.4 1n 1n 1n 4u 8u)

CL N1 0 1p

XM1 N2 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 LABEL_NET_3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}

.control
  * 1. DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  let dc_offset = v(N1) - v(LABEL_NET_3)
  print power dc_offset

  * 2. AC Analysis
  ac dec 20 1k 1G
  let gain_db = vdb(N1)
  * Unity gain buffer has ~0dB DC gain, measure bandwidth at -3dB
  meas ac bw_3db when gain_db=-3 fall=1

  * 3. Transient Analysis
  tran 10n 10u
  * Measure rise and fall times for a 0.4V step (0.9V to 1.3V)
  meas tran t_rise trig v(N1) val=0.9 rise=1 targ v(N1) val=1.3 rise=1
  meas tran t_fall trig v(N1) val=1.3 fall=1 targ v(N1) val=0.9 fall=1
  print t_rise t_fall
  * Slew rate can be calculated as 0.4V / t_rise and 0.4V / t_fall

  * 4. DC Sweep (Linearity Range)
  dc VIN 0 1.8 0.01
  meas dc vout_min min v(N1)
  meas dc vout_max max v(N1)
  
  quit
.endc
.end