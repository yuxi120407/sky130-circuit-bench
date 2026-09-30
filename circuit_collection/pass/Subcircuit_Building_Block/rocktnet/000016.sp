* Testbench for Dead-Zone Amplifier Sub-circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM1 N3 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VDD N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Power and Bias Sources
VVDD VDD 0 1.8
VN2 N2 0 0
Ibias VDD N3 10u
VN4 N4 0 0.4

* Input signal at N0 (Gate of the stack)
VIN N0 0 dc 0.6 ac 1 sin(0.6 0.1 1Meg)

* Load resistor for the stack output
RL N1 VDD 10k

.control
  * 1. DC Operating Point & Power
  op
  let total_power = -i(VVDD) * 1.8
  print total_power

  * 2. AC Analysis for Voltage Gain
  ac dec 10 1k 1G
  let gain_db = vdb(N1)
  meas ac gain_at_1k find gain_db at=1k
  meas ac gain_at_100M find gain_db at=100Meg

  * 3. Transient Analysis
  tran 10n 5u
  meas tran vout_pp pp v(N1)

  * 4. DC Sweep for Dead-Zone Threshold
  * Sweep input from 0 to 1.8V. 
  * When V(N1) drops by 10mV (to 1.79V), current is 1uA, marking the threshold.
  dc VIN 0 1.8 0.01
  meas dc dead_zone_vth when v(N1)=1.79 fall=1

  quit
.endc
.end
