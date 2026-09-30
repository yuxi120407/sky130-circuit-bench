* Testbench for DFE Tap Multiplier
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

* DUT
XM1 N_L VIN_P N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_R VIN_N N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 IOUT_P DI_BAR N_L VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 IOUT_P DI N_R VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_TAIL VBB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 IOUT_N DI_BAR N_R VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 IOUT_N DI N_L VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}

* Loads (to convert current to voltage for measurement)
RL1 IOUT_P 0 1k
RL2 IOUT_N 0 1k

* Sources
VVDD VDD 0 1.8
VVBB VBB 0 0.4

* Analog Inputs (Tap Weight)
VVIN_CM VIN_CM 0 0.4
E_VIN_P VIN_P VIN_CM VIN_DIFF 0 0.5
E_VIN_N VIN_N VIN_CM VIN_DIFF 0 -0.5
VVIN_DIFF VIN_DIFF 0 DC 0.2

* Digital Inputs (Decision)
* DC values are used during DC sweep, PULSE is used during Tran
VDI DI 0 DC 0 PULSE(0 1.8 0.5n 50p 50p 1n 2.5n)
VDI_BAR DI_BAR 0 DC 1.8 PULSE(1.8 0 0.5n 50p 50p 1n 2.5n)

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.control
  * 1. Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power
  
  * 2. DC Sweep for Gm
  * Sweeps analog input while digital decision is held constant (DI=0, DI_BAR=1.8)
  dc VVIN_DIFF -0.5 0.5 0.01
  let iout_diff = (v(IOUT_P) - v(IOUT_N)) / 1k
  let gm_array = deriv(iout_diff)
  meas dc gm max gm_array
  
  * 3. Transient for Delay and Output Swing
  * Pulses digital decision while analog input is held constant (VIN_DIFF=0.2V)
  tran 10p 3n
  let vout_diff = v(IOUT_P) - v(IOUT_N)
  let iout_diff_tran = vout_diff / 1k
  
  * Measure switching delay
  meas tran delay_fall trig v(DI) val=0.9 rise=1 targ vout_diff val=0 fall=1
  meas tran delay_rise trig v(DI) val=0.9 fall=1 targ vout_diff val=0 rise=1
  meas tran delay param='(delay_fall + delay_rise)/2'
  
  * Measure output current swing
  meas tran iout_diff_min min iout_diff_tran from=1.0n to=1.5n
  meas tran iout_diff_max max iout_diff_tran from=2.0n to=2.5n
  meas tran iout_swing param='iout_diff_max - iout_diff_min'
  
  quit
.endc
.end