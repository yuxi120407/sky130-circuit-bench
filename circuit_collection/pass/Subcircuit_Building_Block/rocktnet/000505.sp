* Single-transistor amplifier testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5

XM1 N4 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

VDD VDD 0 DC 1.8
RL VDD N4 2.7k
VIN N2 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)

.control
  * 1. DC Operating Point
  op
  let id_bias = (1.8 - v(N4)) / 2700
  print id_bias

  * 2. DC Sweep for Vth
  dc VIN 0 1.8 0.01
  let id_dc = (1.8 - v(N4)) / 2700
  meas dc vth_10uA find v(N2) when id_dc=10u

  * 3. AC Analysis
  ac dec 100 1k 10G
  let gain_db = vdb(N4)
  meas ac low_freq_gain_db find gain_db at=10k

  * 4. Transient Analysis
  tran 1n 2u
  meas tran vout_max max v(N4)
  meas tran vout_min min v(N4)
  meas tran vout_swing param='vout_max - vout_min'

  quit
.endc
.end
