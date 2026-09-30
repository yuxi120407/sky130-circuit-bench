* Continuous-Time FIR Filter Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm1_prime=0.5
.param L_xm2=0.5
.param L_xm2_prime=0.5
.param L_xm3=0.5
.param L_xm3_prime=0.5
.param L_xm4=0.5
.param L_xm4_prime=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xm3_prime=5.0 L_xm3_prime=0.5
.param W_xm1_prime=5.0 L_xm1_prime=0.5
.param W_xm4_prime=5.0 L_xm4_prime=0.5
.param W_xm2_prime=5.0 L_xm2_prime=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM4 OUT_MINUS OUT_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM3_PRIME N2 IN_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3_prime} w={W_xm3_prime}
XM1_PRIME N4 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1_prime} w={W_xm1_prime}
XM4_PRIME OUT_PLUS OUT_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4_prime} w={W_xm4_prime}
XM2_PRIME OUT_PLUS N4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2_prime} w={W_xm2_prime}
XM1 N0 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM3 N3 IN_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM2 OUT_MINUS N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Sources
VVDD VDD 0 1.8
VIN_PLUS IN_PLUS 0 DC 1.2 AC 0.5 PULSE(1.1 1.3 1n 50p 50p 1n 2n)
VIN_MINUS IN_MINUS 0 DC 1.2 AC -0.5 PULSE(1.3 1.1 1n 50p 50p 1n 2n)

* Bias Current Sources
I_N0 VDD N0 5u
I_N4 VDD N4 5u
I_N3 N3 0 50u
I_N2 N2 0 50u

.control
  * OP Analysis for Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis for Bandwidth and Gain
  ac dec 50 1Meg 10G
  let vout_diff = v(N2) - v(N3)
  let vin_diff = v(IN_PLUS) - v(IN_MINUS)
  let out_mag = mag(vout_diff)
  let in_mag = mag(vin_diff)
  let gain_db = 20 * log10((out_mag + 1e-20) / (in_mag + 1e-20))
  
  meas ac gain find gain_db at=1Meg
  let gain_3db = gain - 3
  meas ac bandwidth when gain_db=gain_3db fall=1
  print gain bandwidth

  * Transient Analysis for Delay
  tran 10p 5n
  let vout_diff_tran = v(N2) - v(N3)
  let vin_diff_tran = v(IN_PLUS) - v(IN_MINUS)
  
  meas tran delay trig vin_diff_tran val=0 rise=1 targ vout_diff_tran val=0 rise=1
  print delay

  quit
.endc
.end