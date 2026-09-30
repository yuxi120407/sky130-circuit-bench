* Comparator Preamplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm10=5.0 L_xm10=0.5

XM1 VAP VIP N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM7 VAN VAN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM9 VAN VAP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM2 VAP VIN N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM5 N2 VB1 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM8 VAP VAP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM3 VAN VRP N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VAN VRN N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM6 N3 VB1 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM10 VDD VAN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

VVDD VDD 0 1.8
VVSS VSS 0 0
VVB1 VB1 0 0.8

VVIP VIP 0 DC 0.9 AC 0.5
VVIN VIN 0 DC 0.9 AC 0.5
VVRP VRP 0 DC 0.9 AC -0.5
VVRN VRN 0 DC 0.9 AC -0.5

.control
  op
  let dc_power = -i(VVDD) * 1.8
  let sys_offset = v(VAN) - v(VAP)
  print dc_power
  print sys_offset

  ac dec 20 1Meg 10Gig
  let vout_diff = v(VAP) - v(VAN)
  let gain_db = 20 * log10(mag(vout_diff) + 1e-15)
  meas ac diff_gain max gain_db
  meas ac ugbw when gain_db=0 fall=1
  print diff_gain
  print ugbw
  
  quit
.endc
.end