* Testbench for Differential Amplifier / DFE Summer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N2 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 LABEL_NET_0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Supply and Inputs
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 dc 0.9 ac 0.5 sin(0.9 0.1 100Meg)
VLABEL_NET_1 LABEL_NET_1 0 dc 0.9 ac -0.5 sin(0.9 -0.1 100Meg)

* Tail current source (200uA to keep PMOS in saturation)
I_tail N1 0 200u

* Configure PMOS as diode-connected loads for self-biasing
Vshort1 N4 N2 0
Vshort2 N3 N0 0

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power
  let vout_cm = (v(N0) + v(N2))/2
  print vout_cm

  * AC Analysis
  ac dec 100 1Meg 100Gig
  let vout_diff_ac = v(N0) - v(N2)
  let gain_db = 20*log10(mag(vout_diff_ac))
  meas ac dc_gain MAX gain_db
  meas ac bw_3db when gain_db='dc_gain - 3' fall=1

  * Transient Analysis
  tran 100p 20n
  meas tran vout_p_max max v(N0)
  meas tran vout_p_min min v(N0)
  meas tran vout_n_max max v(N2)
  meas tran vout_n_min min v(N2)
  
  quit
.endc
.end