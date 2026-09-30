* Capacitive Feedback Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameterized capacitor values
.param C_f=1p
.param C_s=2p
.param C_L=0.5p
.param C_p=0.1p

* Ideal fully differential amplifier subcircuit (Macro-model)
* Modeled for ~96dB open-loop gain and ~10MHz GBW with 0.5pF load
.subckt amplifier out_p cm out_n in_m in_p
  G1 out_p cm in_m cm 31.4u
  R1 out_p cm 2G
  G2 out_n cm in_p cm 31.4u
  R2 out_n cm 2G
.ends

* DUT (Modified A1 to X1 for subcircuit call, added capacitor values)
X1 Vout_p LABEL_NET_0 Vout_n N3 N2 amplifier
C1 Vout_n N2 {C_f}
C2 Vout_p N3 {C_f}
C3 N3 Vstep_p {C_s}
C4 N2 Vstep_n {C_s}
C5 Vout_n GND {C_L}
C6 N2 GND {C_p}
C7 Vout_p GND {C_L}
C8 N3 GND {C_p}

* DC feedback resistors to establish operating point (1 Gohm)
R_fb1 Vout_n N2 1G
R_fb2 Vout_p N3 1G

* Bias and Stimulus
VLABEL_NET_0 LABEL_NET_0 0 0.9
Vstep_p Vstep_p LABEL_NET_0 dc 0 ac 1 pulse(0 0.1 10n 1n 1n 1u 2u)
Vstep_n Vstep_n LABEL_NET_0 dc 0 ac -1 pulse(0 -0.1 10n 1n 1n 1u 2u)

* Dummy VDD for power measurement reference
Vdd vdd 0 1.8
Rdummy vdd 0 1k

* Differential measurement helpers
E_out_diff out_diff 0 Vout_p Vout_n 1
E_in_diff in_diff 0 Vstep_p Vstep_n 1

.control
  * DC Operating Point
  op
  print v(Vout_p) v(Vout_n) v(N3) v(N2)
  let power = -i(Vdd) * 1.8
  print power

  * AC Analysis for Closed-Loop Gain and Bandwidth
  ac dec 100 100 100Meg
  let gain_db = vdb(out_diff) - vdb(in_diff)
  meas ac midband_gain_db find gain_db at=10k
  meas ac bw_3db when gain_db=(midband_gain_db - 3) fall=1

  * Transient Analysis for Step Response
  tran 1n 2u
  meas tran vout_step_min min v(out_diff)
  meas tran vout_step_max max v(out_diff)
  
  quit
.endc
.end
