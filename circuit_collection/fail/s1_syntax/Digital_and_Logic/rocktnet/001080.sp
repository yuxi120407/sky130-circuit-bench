* MCML Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xmc1=0.5
.param L_xmn1=0.5
.param L_xmn2=0.5

.param W_xmn1=5.0 L_xmn1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xmn2=5.0 L_xmn2=0.5
.param W_xmc1=5.0 L_xmc1=0.5

VVDD VDD 0 1.8
VGND GND 0 0
VVLOAD VLOAD 0 1.0

* Differential inputs (Common mode = 1.2V, Swing = 0.4V single-ended)
VD D 0 DC 1.2 AC 0.5 PULSE(1.0 1.4 100p 20p 20p 400p 1n)
VDBAR D_BAR 0 DC 1.2 AC -0.5 PULSE(1.4 1.0 100p 20p 20p 400p 1n)

* DUT
XMN1 Q_BAR D NC NC sky130_fd_pr__nfet_01v8 l={L_xmn1} w={W_xmn1}
XM2 Q_BAR GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 Q GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XMN2 Q D_BAR NC NC sky130_fd_pr__nfet_01v8 l={L_xmn2} w={W_xmn2}
XMC1 NC VLOAD GND GND sky130_fd_pr__nfet_01v8 l={L_xmc1} w={W_xmc1}

* Load capacitance
CL1 Q 0 10f
CL2 Q_BAR 0 10f

.control
  * AC Analysis
  ac dec 50 1Meg 100G
  let vout_diff = v(Q) - v(Q_BAR)
  let gain_mag = mag(vout_diff)
  let gain_db = 20*log10(gain_mag)
  meas ac dc_gain_db find gain_db at=1Meg
  meas ac ugbw when gain_db=0 fall=1

  * Transient Analysis
  tran 1p 2n
  meas tran v_high max v(Q)
  meas tran v_low min v(Q)
  let v_swing = v_high - v_low
  print v_swing

  * Delay measurement at differential crossing points
  meas tran t_cross_in when v(D)=v(D_BAR) cross=1
  meas tran t_cross_out when v(Q)=v(Q_BAR) cross=1
  let t_delay = t_cross_out - t_cross_in
  print t_delay

  * Power measurement
  meas tran i_vdd avg i(VVDD)
  let power = -i_vdd * 1.8
  print power
  
  quit
.endc
.end