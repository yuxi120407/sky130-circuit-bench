* Summing Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N0 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 dc 0.9 ac 1
VLABEL_NET_1 LABEL_NET_1 0 dc 0.9

.control
  * DC Operating Point Analysis
  op
  let power = -i(VVDD) * 1.8
  print power
  print v(N0)
  let v_out_dc = v(N0)

  * AC Analysis for Gain and Bandwidth
  ac dec 100 1k 100G
  let gain_db = vdb(N0)
  meas ac dc_gain_db find gain_db at=1k
  let f3db_mag = dc_gain_db - 3
  meas ac bandwidth when gain_db=f3db_mag fall=1
  
  quit
.endc
.end