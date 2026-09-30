* Two-Stage Common-Source Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

* DUT
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 X VIN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 LABEL_NET_1 X GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Biasing and Loads
VVDD VDD 0 1.8
VVIN VIN 0 DC 0.7 AC 1 SIN(0.7 0.01 100MEG 0 0)

* Load resistors to convert the bare transistors into an amplifier
R1 VDD X 5k
R2 VDD LABEL_NET_1 800

* Analyses
.control
  * DC Operating Point and Power
  op
  let total_current = -i(VVDD)
  let power = total_current * 1.8
  print power
  print v(X) v(LABEL_NET_1)

  * AC Analysis for Gain and Bandwidth
  ac dec 100 1MEG 100G
  let gain_db = vdb(LABEL_NET_1)
  meas ac gain_1mhz find gain_db at=1MEG
  meas ac ugbw when gain_db=0 fall=1

  * Transient Analysis for Output Swing
  tran 0.1n 50n
  meas tran vout_pp pp v(LABEL_NET_1)
  
  quit
.endc
.end