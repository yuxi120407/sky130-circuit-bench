* LC VCO Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

* DUT
XM1 N5 N2 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N5 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N7 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

* Biasing and Supply
VVDD VDD 0 1.8
VN6 N6 0 0
Iref N1 0 200u
VVCONTR VCONTR 0 0.9

* LC Tank for ~2.1 GHz
L1 N5 N7 2n
L2 N2 N7 2n
C1 N5 N2 1.436p
R1 N5 N2 5k

* Differential output for measurement
E1 diff 0 N5 N2 1

* Initial conditions to kickstart oscillator
.ic v(N5)=1.0 v(N2)=0.4

.control
  * Transient analysis: 2.1GHz -> T = 476ps. Run for 50ns to reach steady state.
  tran 10p 50n
  
  * Measure frequency (around cycle 80 to ensure steady state)
  meas tran t1 trig v(diff) val=0 rise=80 targ v(diff) val=0 rise=81
  let freq = 1 / t1
  print freq
  
  * Measure amplitude
  meas tran vmax max v(diff) from=30n to=50n
  meas tran vmin min v(diff) from=30n to=50n
  let vpp = vmax - vmin
  print vpp
  
  * Measure power
  meas tran ivdd avg i(VVDD) from=30n to=50n
  let power = -ivdd * 1.8
  print power
  
  quit
.endc
.end
