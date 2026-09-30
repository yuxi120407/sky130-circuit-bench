* Testbench for Analog Turbo Decoder Diff Pair
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
XM1 LABEL_NET_0 N2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 LABEL_NET_3 N1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 GND LABEL_NET_4 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 GND LABEL_NET_6 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}

* Power and Bias
VVDD VDD 0 1.8
VBIAS LABEL_NET_5 0 0.9

* Loads (Added to convert OTA currents to measurable voltages)
RL1 VDD LABEL_NET_0 10k
RL2 VDD LABEL_NET_3 10k
CL1 LABEL_NET_0 0 10f
CL2 LABEL_NET_3 0 10f

* Inputs
V_INP LABEL_NET_4 0 DC 0.9 AC 0.5 PULSE(0.8 1.0 100n 10n 10n 1u 2u)
V_INN LABEL_NET_6 0 DC 0.9 AC -0.5 PULSE(1.0 0.8 100n 10n 10n 1u 2u)

* Differential signal extractors (VCVS)
E_diff OUT_DIFF 0 LABEL_NET_3 LABEL_NET_0 1.0
E_indiff IN_DIFF 0 LABEL_NET_4 LABEL_NET_6 1.0

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1k 10G
  let gain_db = db(v(OUT_DIFF))
  meas ac dc_gain find gain_db at=10k
  let gain_3db = dc_gain - 3
  meas ac bw_3db when gain_db=gain_3db fall=1
  print dc_gain bw_3db

  * Transient Analysis
  tran 0.1n 2u
  meas tran delay trig v(IN_DIFF) val=0 rise=1 targ v(OUT_DIFF) val=0 rise=1
  print delay
  
  quit
.endc
.end