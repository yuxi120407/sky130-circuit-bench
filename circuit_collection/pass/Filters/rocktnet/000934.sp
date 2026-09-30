* All-Pass Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

* Parameterized W/L for all-pass condition (gm2*gm5 = 2*gm1*gm4)
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=20.0 L_xm4=0.5
.param W_xm5=40.0 L_xm5=0.5

* DUT
XM1 VOUT VIN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 VIN GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT VOUT GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 VOUT N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}

* Sources
VVDD VDD 0 1.8
VVIN VIN 0 DC 0.9 AC 1 SIN(0.9 0.1 1G 0 0)

.control
  * OP Analysis
  op
  let power_consumption = -i(VVDD) * 1.8 * 1000
  print power_consumption

  * AC Analysis
  ac dec 100 1 100G
  let gain_db = vdb(VOUT)
  
  meas ac dc_gain find gain_db at=1
  let gain_3db = dc_gain - 3
  meas ac bw_3db_hz when gain_db=$&gain_3db fall=1
  let bandwidth_3db = bw_3db_hz / 1e9
  
  print dc_gain
  print bandwidth_3db

  * Transient Analysis
  tran 1p 10n
  meas tran delay_1G_sec trig v(VIN) val=0.9 rise=8 targ v(VOUT) val=0.9 rise=8
  let delay_1G = delay_1G_sec * 1e12
  
  print delay_1G
  
  quit
.endc
.end