* Testbench for Differential Driver Stage
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

* Parameterized W/L for high-speed 50-ohm driving capability
.param W_xm1=100.0 L_xm1=0.15
.param W_xm2=100.0 L_xm2=0.15
.param W_xm3=100.0 L_xm3=0.15
.param W_xm4=100.0 L_xm4=0.15
.param W_xm5=100.0 L_xm5=0.15
.param W_xm6=100.0 L_xm6=0.15

* DUT
XM1 OUTP DCAP N3 VSS sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUTP DINN N2 VSS sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 VOA VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 VSS VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUTN DINP N2 VSS sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUTN DCAN N3 VSS sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Power Supplies
VVDD VDD 0 1.8
VVSS VSS 0 0

* Load resistors (50 ohms as per distributed amplifier architecture)
R1 VDD OUTP 50
R2 VDD OUTN 50

* Bias voltages
VVOA VOA 0 0.8
VDCAP DCAP 0 0.9
VDCAN DCAN 0 0.9

* Input signals (AC magnitude 0.5 each side -> 1.0V differential)
VDINP DINP 0 DC 0.9 AC 0.5 SIN(0.9 0.2 10G)
VDINN DINN 0 DC 0.9 AC 0.5 180 SIN(0.9 -0.2 10G)

* Voltage controlled voltage source to calculate differential output
E_diff VDIFF 0 OUTP OUTN 1.0

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis (Gain and Bandwidth)
  ac dec 50 1Meg 100G
  let gain_db = vdb(VDIFF)
  meas ac max_gain max gain_db
  let f3db_target = max_gain - 3
  meas ac bw_3db when gain_db=f3db_target fall=1

  * 3. Transient Analysis (Output Swing at 10 GHz)
  tran 1p 500p
  meas tran swing_max max v(VDIFF)
  meas tran swing_min min v(VDIFF)
  let swing_pp = swing_max - swing_min
  print swing_pp

  quit
.endc
.end
