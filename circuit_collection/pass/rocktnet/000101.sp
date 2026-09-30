* 2-Stage Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0

* DUT
XM1 N2 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 GND N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Biasing and Loads
VVDD VDD 0 1.8
R1 N3 VDD 10k
R2 N4 VDD 10k

* Self-bias for stage 1
Rbias N3 N2 10Meg
Cin N_in N2 1u

* Input source
Vin N_in 0 DC 0 AC 1 sin(0 0.01 10Meg)

.control
  * DC Operating Point
  op
  let dc_power = -i(VVDD) * 1.8
  print dc_power

  * AC Analysis
  ac dec 50 1k 10Gig
  let gain_db = db(v(N4))
  meas ac voltage_gain MAX gain_db
  let f3db = voltage_gain - 3
  meas ac operating_frequency WHEN gain_db=f3db FALL=1
  print voltage_gain
  print operating_frequency

  * Transient Analysis
  tran 1n 500n
  meas tran vout_pp PP v(N4) from=100n to=500n
  let vout_peak = vout_pp / 2
  let p_out_w = (vout_peak * vout_peak) / 100
  let output_power = 10 * log10(p_out_w / 0.001)
  print output_power
  
  quit
.endc
.end