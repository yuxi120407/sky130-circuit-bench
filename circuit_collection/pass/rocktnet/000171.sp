* PFET Source Follower Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=20.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 GND V2 V1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 V2 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* DC Sources
VVDD VDD 0 1.8
VLABEL_NET_2 LABEL_NET_2 0 0.5

* Input signal at Vin_src
Vin Vin_src 0 DC 0.4 AC 1 PULSE(0.2 0.6 5n 1n 1n 100n 200n)
Rin Vin_src V2 10k

* Bias current for the source follower (V1)
Ibias VDD V1 10u

* Load capacitance (from paper)
Cload V1 0 3.5p

.control
  * DC Operating Point Analysis
  op
  let v_out_dc = v(V1)
  let v_in_dc = v(V2)
  let level_shift = v_out_dc - v_in_dc
  let power = -i(VVDD)*1.8 - i(Vin)*0.4 - i(VLABEL_NET_2)*0.5
  print level_shift power

  * AC Analysis
  ac dec 10 1k 100meg
  let gain_db = db(v(V1))
  meas ac dc_gain find gain_db at=1k
  print dc_gain

  * Transient Analysis
  tran 1n 200n
  meas tran delay trig v(V2) val=0.3 rise=1 targ v(V1) val=1.35 rise=1
  print delay
  
  quit
.endc
.end