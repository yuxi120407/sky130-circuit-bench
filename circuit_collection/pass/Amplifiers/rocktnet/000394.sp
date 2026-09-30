* Pseudo-differential cascode amplifier testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

* DUT
XM1 N3 N5 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N4 LABEL_NET_4 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N4 LABEL_NET_5 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N5 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Power and Biases
VVDD VDD 0 1.8
V_L4 LABEL_NET_4 0 1.8
V_L5 LABEL_NET_5 0 1.8
V_N5 N5 0 1.0

* CMFB for PMOS bias (N4) to set output common-mode to 0.9V
B_cmfb N4_ideal 0 V={1.0 + 0.8*tanh(100*(v(N0)+v(N3)-1.8))}
R_cmfb N4_ideal N4 1k
C_cmfb N4 0 100f

* Inputs (DC=0.6V, AC diff=1V, Pulse for slew rate)
V_INP LABEL_NET_1 0 DC 0.6 AC 0.5 PULSE(0.6 0.8 1n 10p 10p 10n 20n)
V_INN LABEL_NET_2 0 DC 0.6 AC -0.5 PULSE(0.6 0.4 1n 10p 10p 10n 20n)

* Load capacitance (170fF from paper)
C1 N3 0 170f
C2 N0 0 170f

* Differential output VCVS for easy measurement
E_diff out_diff 0 N0 N3 1.0

.control
  * DC Operating Point & Power
  op
  let power = - (i(VVDD) + i(V_L4) + i(V_L5)) * 1.8
  print power
  print v(N0) v(N3) v(N4) v(N5) v(N1) v(N2)

  * AC Analysis for Gain, GBW, Phase Margin
  ac dec 100 1 10G
  let gain_db = db(v(out_diff))
  let phase_deg = ph(v(out_diff)) * 180 / 3.141592653589793
  let phase_margin_vec = 180 + phase_deg
  
  meas ac dc_gain find gain_db at=10
  meas ac gbw when gain_db=0 fall=1
  meas ac phase_margin find phase_margin_vec when gain_db=0 fall=1
  
  * Transient Analysis for Slew Rate
  tran 10p 20n
  meas tran t1 when v(out_diff)=0.1 rise=1
  meas tran t2 when v(out_diff)=0.5 rise=1
  let slew_rate = 0.4 / (t2 - t1) / 1e6
  print slew_rate
  
  quit
.endc
.end