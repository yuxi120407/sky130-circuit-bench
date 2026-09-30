* Charge Pump Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5

XM1 N4 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT GND N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT UP_BAR N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 GND N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 LABEL_NET_2 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT VDD OUT GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 OUT N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N7 VDD N5 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 DN_BAR N10 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 OUT DN N10 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N10 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N4 UP N7 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

VVDD VDD 0 1.8
VN6 N6 0 0.9
VOUT OUT 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9

* Logic Inputs (DC for OP analysis)
VUP UP 0 1.8
VUP_BAR UP_BAR 0 1.8
VDN DN 0 0
VDN_BAR DN_BAR 0 1.8

.control
  * 1. Find target UP current (I_UP_gross)
  alter VN6 0
  alter VUP 0
  alter VUP_BAR 0
  alter VDN 0
  alter VDN_BAR 1.8
  op
  let i_up_net_target = i(VOUT)
  set target = $&i_up_net_target

  * 2. Sweep Inactive state to get I_bleed vs VN6
  alter VUP 1.8
  alter VUP_BAR 1.8
  alter VDN 0
  alter VDN_BAR 1.8
  dc VN6 0 1.8 0.001
  let i_bleed_vec = -i(VOUT)

  * 3. Sweep DN active state to get I_DN_gross vs VN6
  alter VUP 1.8
  alter VUP_BAR 1.8
  alter VDN 1.8
  alter VDN_BAR 0
  dc VN6 0 1.8 0.001
  let i_dn_total_vec = -i(VOUT)
  let i_dn_net_vec = i_dn_total_vec - dc1.i_bleed_vec

  * 4. Find matching VN6
  meas dc vn6_match find v(N6) when i_dn_net_vec=$target
  set vn6_opt = $&vn6_match

  * 5. Set VN6 to optimal value and measure all metrics
  alter VN6 $vn6_opt

  * Measure Bleed
  alter VUP 1.8
  alter VUP_BAR 1.8
  alter VDN 0
  alter VDN_BAR 1.8
  op
  let i_bleed = -i(VOUT)
  set ib = $&i_bleed
  print i_bleed

  * Measure UP
  alter VUP 0
  alter VUP_BAR 0
  alter VDN 0
  alter VDN_BAR 1.8
  op
  let i_up_total = i(VOUT)
  let i_up_net = i_up_total + $ib
  print i_up_total i_up_net

  * Measure DN
  alter VUP 1.8
  alter VUP_BAR 1.8
  alter VDN 1.8
  alter VDN_BAR 0
  op
  let i_dn_total = -i(VOUT)
  let i_dn_net = i_dn_total - $ib
  print i_dn_total i_dn_net

  quit
.endc
.end