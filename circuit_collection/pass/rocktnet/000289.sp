* I/Q Downconversion Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm5=5.0 L_xm5=0.5

XM3 VIFI_P N7 X GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 Y VRF GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM4 VIFI_N VLOI_N X GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM6 VIFQ_N VLOQ_N Y GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM1 X VRF GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM5 VIFQ_P VLOQ_P Y GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

VVDD VDD 0 1.8

* Load resistors and capacitors (Low-pass filter for IF)
RLI_P VDD VIFI_P 2k
CLI_P VIFI_P 0 20p
RLI_N VDD VIFI_N 2k
CLI_N VIFI_N 0 20p
RLQ_P VDD VIFQ_P 2k
CLQ_P VIFQ_P 0 20p
RLQ_N VDD VIFQ_N 2k
CLQ_N VIFQ_N 0 20p

* RF Input (2.4 GHz)
VRF VRF 0 dc 0.9 sin(0.9 10m 2.4G)

* LO Inputs (2.399 GHz)
VN7 N7 0 dc 0.9 sin(0.9 0.4 2.399G 0 0 0)
VVLOI_N VLOI_N 0 dc 0.9 sin(0.9 0.4 2.399G 0 0 180)
VVLOQ_P VLOQ_P 0 dc 0.9 sin(0.9 0.4 2.399G 0 0 90)
VVLOQ_N VLOQ_N 0 dc 0.9 sin(0.9 0.4 2.399G 0 0 270)

.control
  op
  let power = -i(VVDD) * 1.8
  print power

  * Transient analysis for conversion gain
  tran 20p 3u
  
  * IF is at 1 MHz. Period is 1 us.
  * Measure peak-to-peak of IF output
  let vifi_diff = v(VIFI_P) - v(VIFI_N)
  meas tran if_max max vifi_diff from=1u to=3u
  meas tran if_min min vifi_diff from=1u to=3u
  let if_pp = if_max - if_min
  let rf_pp = 20m
  let cg_linear = if_pp / rf_pp
  let cg_db = 20 * log10(cg_linear)
  print cg_db
  
  * Measure Q channel
  let vifq_diff = v(VIFQ_P) - v(VIFQ_N)
  meas tran ifq_max max vifq_diff from=1u to=3u
  meas tran ifq_min min vifq_diff from=1u to=3u
  let ifq_pp = ifq_max - ifq_min
  let cgq_linear = ifq_pp / rf_pp
  let cgq_db = 20 * log10(cgq_linear)
  print cgq_db
  
  let gain_mismatch_db = abs(cg_db - cgq_db)
  print gain_mismatch_db

  quit
.endc
.end
