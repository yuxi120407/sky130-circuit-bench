* VCO Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

* Scaled up W/L for realistic RF gm at 2.4GHz
.param W_xm1=50.0 L_xm1=0.15
.param W_xm2=50.0 L_xm2=0.15
.param W_xm3=50.0 L_xm3=0.15

* DUT
XM1 N1 N2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Biasing and Supply
VVDD VDD 0 1.8
VVB BIAS 0 0.75

* LC Tank for 2.4 GHz
L1 VDD N1 1n
L2 VDD N2 1n
C1 N1 N2 2.2p
R1 N1 VDD 200
R2 N2 VDD 200

* Kickstart pulse to ensure oscillation starts quickly
Ikick N1 N2 PULSE(0 1m 0 100p 100p 100p 100n)

* Differential voltage dummy source for measurement
B1 VDIFF 0 V=v(N1)-v(N2)

.control
  * Transient Analysis
  tran 10p 20n
  
  * Measure Oscillation Frequency (measure later cycles to ensure steady state)
  meas tran t1 trig v(VDIFF) val=0 rise=30 targ v(VDIFF) val=0 rise=31
  let freq = 1/t1
  print freq
  
  * Measure Voltage Swing
  meas tran v_max max v(VDIFF) from=10n to=20n
  meas tran v_min min v(VDIFF) from=10n to=20n
  let v_pp = v_max - v_min
  print v_pp
  
  * Measure Power Consumption
  meas tran pwr_avg avg i(VVDD) from=10n to=20n
  let power_tran = -pwr_avg * 1.8
  print power_tran
  
  quit
.endc
.end