* Testbench for PAM-4 Transmitter Output Stage
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=50.0 L_xm1=0.15
.param W_xm2=50.0 L_xm2=0.15
.param W_xm3=25.0 L_xm3=0.15
.param W_xm4=25.0 L_xm4=0.15

* DUT
XM1 N3 LABEL_NET_1 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 LABEL_NET_2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 LABEL_NET_3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 LABEL_NET_4 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Biasing and Loads
VVDD VDD 0 1.8
VCM VCM 0 0.9

* Tail currents
I_TAIL_P VDD N1 10m
I_TAIL_N N0 GND 10m

* Loads (50 ohm to VCM)
R1 N3 VCM 50
R2 N4 VCM 50

* Inputs (10 Gb/s -> 100ps UI)
V1 LABEL_NET_1 0 DC 0.9 AC 1 PULSE(0 1.8 50p 20p 20p 80p 200p)
V4 LABEL_NET_4 0 DC 0.9 AC 1 PULSE(0 1.8 50p 20p 20p 80p 200p)
V2 LABEL_NET_2 0 DC 0.9 AC -1 PULSE(1.8 0 50p 20p 20p 80p 200p)
V3 LABEL_NET_3 0 DC 0.9 AC -1 PULSE(1.8 0 50p 20p 20p 80p 200p)

.control
  * AC Analysis
  ac dec 20 100M 100G
  let vout_diff_ac = v(N3) - v(N4)
  let gain_db = db(vout_diff_ac)
  meas ac dc_gain MAX gain_db
  let gain_3db = dc_gain - 3
  meas ac bandwidth_3db when gain_db=$&gain_3db fall=1
  print bandwidth_3db
  
  * Transient Analysis
  tran 1p 1n
  let vout_diff = v(N3) - v(N4)
  
  * Measure swing
  meas tran vout_max max vout_diff
  meas tran vout_min min vout_diff
  let output_swing = vout_max - vout_min
  print output_swing
  
  * Measure fall time (approx 80% to 20% of the transition)
  let v80 = vout_max - 0.2 * output_swing
  let v20 = vout_min + 0.2 * output_swing
  let v50 = vout_min + 0.5 * output_swing
  
  meas tran t_fall trig vout_diff val=$&v80 fall=1 targ vout_diff val=$&v20 fall=1
  
  * Measure rise time (on the next edge)
  meas tran t_rise trig vout_diff val=$&v20 rise=1 targ vout_diff val=$&v80 rise=1
  
  let rise_fall_time = (t_fall + t_rise) / 2
  print rise_fall_time
  
  * Measure delay (50% of input to 50% of output)
  meas tran propagation_delay trig v(LABEL_NET_1) val=0.9 rise=1 targ vout_diff val=$&v50 fall=1
  print propagation_delay
  
  * Measure power
  meas tran pwr_avg avg i(VVDD)
  let power_consumption = -pwr_avg * 1.8
  print power_consumption
  
  quit
.endc
.end