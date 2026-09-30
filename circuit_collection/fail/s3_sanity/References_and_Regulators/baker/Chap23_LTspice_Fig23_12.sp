* Cascoded BMR Simulation Testbench (Baker Fig. 23.11)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1b=0.5
.param L_xm1t=0.5
.param L_xm2b=0.5
.param L_xm2t=0.5
.param L_xm3b=0.5
.param L_xm3t=0.5
.param L_xm4b=0.5
.param L_xm4t=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Transistor dimensions from Fig. 23.11
.param W_xmsu1=50.0 L_xmsu1=2.0
.param W_xmsu2=10.0 L_xmsu2=20.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm3t=100.0 L_xm3t=2.0
.param W_xm3b=100.0 L_xm3b=2.0
.param W_xm4t=100.0 L_xm4t=2.0
.param W_xm4b=100.0 L_xm4b=2.0
.param W_xm1t=50.0  L_xm1t=2.0
.param W_xm1b=50.0  L_xm1b=2.0
.param W_xm2t=50.0  L_xm2t=2.0
.param W_xm2b=200.0 L_xm2b=2.0

* Power Supply
VDD VDD 0 1.8

* DUT Netlist from Fig. 23.11
xmsu1 N002 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
xm3t N001 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3t} l={L_xm3t}
xm3b Vncas Vpcas N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm3b} l={L_xm3b}
xm4t Vbiasp Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4t} l={L_xm4t}
xm4b Vpcas Vpcas Vbiasp VDD sky130_fd_pr__pfet_01v8 w={W_xm4b} l={L_xm4b}
xm2b N003 Vbiasn N004 0 sky130_fd_pr__nfet_01v8 w={W_xm2b} l={L_xm2b}
xm1b Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1b} l={L_xm1b}
R1 N004 0 6500.0
xm2t Vpcas Vncas N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2t} l={L_xm2t}
xm1t Vncas Vncas Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xm1t} l={L_xm1t}

.control
  * DC Sweep of VDD from 0V to 1.8V to observe true startup behavior
  dc VDD 0 1.8 0.01

  let iref2_sweep = v(N004) / 6500.0
  let iref1_sweep = abs(@m.xm1b.msky130_fd_pr__nfet_01v8[id])
  let current_matching_error_sweep = 100.0 * abs(iref1_sweep - iref2_sweep) / (iref2_sweep + 1e-15)

  meas dc iref_nominal find iref2_sweep at=1.8
  meas dc current_matching_error find current_matching_error_sweep at=1.8

  meas dc vdd_min when iref2_sweep='0.90 * iref_nominal' cross=last

  meas dc iref_1v6 find iref2_sweep at=1.6
  let line_sensitivity = (iref_nominal - iref_1v6) / 0.2

  meas dc vbiasn find v(Vbiasn) at=1.8

  let vgs_msu3_sweep = v(N002) - v(Vbiasn)
  meas dc vgs_msu3 find vgs_msu3_sweep at=1.8

  let p_tot_sweep = -i(VDD) * v(VDD)
  meas dc total_power find p_tot_sweep at=1.8

  echo "=== Summary of Extracted Metrics ==="
  print iref_nominal
  print current_matching_error
  print vdd_min
  print line_sensitivity
  print vbiasn
  print vgs_msu3
  print total_power

  quit
.endc
.end