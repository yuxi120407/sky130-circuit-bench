* 8-Gb/s Capacitively Coupled Receiver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Component Parameters
.param C_ac=60f
.param R_fb=2k
.param R_bias=10k
.param R_load=500
.param R_deg=400
.param C_deg=100f
.param V_bias=1.0
.param W_m=10.0
.param L_m=0.15

* Supply
VVDD VDD 0 1.8

* Inputs (AC for bandwidth, PULSE for 8Gb/s 1010 pattern -> 4GHz square wave)
V_in_plus nin_plus 0 DC 0 AC 0.5 PULSE(-0.125 0.125 50p 20p 20p 105p 250p)
V_in_minus nin_minus 0 DC 0 AC -0.5 PULSE(0.125 -0.125 50p 20p 20p 105p 250p)

* DUT (NPNs replaced with SKY130 NMOS for generic MOSFET compatibility)
Cin_plus nin_plus n1_plus {C_ac}
Cin_minus nin_minus n1_minus {C_ac}
R1_2 n1_plus n2_minus {R_fb}
R1 n1_minus n2_plus {R_fb}
R1_3 n1_plus n4 {R_bias}
R1_4 n1_minus n4 {R_bias}
R3 n2_plus VDD {R_load}
R3_2 n2_minus VDD {R_load}
M1 n2_plus n1_plus n3_plus GND sky130_fd_pr__nfet_01v8 W={W_m} L={L_m}
M2 n2_minus n1_minus n3_minus GND sky130_fd_pr__nfet_01v8 W={W_m} L={L_m}
R2 n3_plus GND {R_deg}
R2_2 n3_minus GND {R_deg}
C2 n3_plus n3_minus {C_deg}
V1 n4 GND V_bias

* Differential output dependent source for easy measurement
E_diff out_diff 0 n2_minus n2_plus 1.0

.control
  * 1. DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis
  ac dec 50 10Meg 100G
  let gain_db = vdb(out_diff)
  meas ac midband_gain find gain_db at=1G
  * Assuming midband gain is ~6dB, measure 3dB bandwidth at 3dB
  meas ac bw_3db when gain_db=3 fall=1

  * 3. Transient Analysis (2ns duration for 8Gb/s data)
  tran 2p 2n
  meas tran vout_max max v(out_diff)
  meas tran vout_min min v(out_diff)
  let vout_swing = vout_max - vout_min
  print vout_swing
  meas tran t_delay trig v(nin_plus) val=0 rise=2 targ v(out_diff) val=0 rise=2
.endc

.end
