* Testbench for Baker Fig 22.24 Source Cross-Coupled Diff-Amp
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm25=0.5
.param L_xm26=0.5
.param L_xm3=0.5
.param L_xm31=0.5
.param L_xm4=0.5
.param L_xm41=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmisslb=0.5
.param L_xmisslt=0.5
.param L_xmissrb=0.5
.param L_xmissrt=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions matching Fig. 22.24 and Fig. 20.43
* Amplifying devices: NMOS 100/2 -> W=10.0, L=0.2u; PMOS 200/2 -> W=20.0, L=0.2
* Biasing current sources: 10/20 -> W=1.0, L=2.0
.param W_xmisslb=1.0  L_xmisslb=2.0
.param W_xmisslt=1.0  L_xmisslt=2.0
.param W_xmissrb=1.0  L_xmissrb=2.0
.param W_xmissrt=1.0  L_xmissrt=2.0
.param W_xm1=10.0     L_xm1=0.2
.param W_xm2=10.0     L_xm2=0.2
.param W_xm3=20.0     L_xm3=0.2
.param W_xm4=20.0     L_xm4=0.2
.param W_xm11=10.0    L_xm11=0.2
.param W_xm21=10.0    L_xm21=0.2
.param W_xm31=20.0    L_xm31=0.2
.param W_xm41=20.0    L_xm41=0.2

* SUB_1 cascode bias generator device parameters
.param W_xmsu1=1.0    L_xmsu1=0.2
.param W_xmsu2=3.0    L_xmsu2=0.2
.param W_xmsu3=1.0    L_xmsu3=0.2
.param W_xm5=3.0      L_xm5=0.2
.param W_xm6=1.0      L_xm6=0.2
.param W_xm7=3.0      L_xm7=0.2
.param W_xm8=1.0      L_xm8=0.2
.param W_xm9=3.0      L_xm9=0.2
.param W_xm10=3.0     L_xm10=0.2
.param W_xm12=1.0     L_xm12=0.2
.param W_xm13=1.0     L_xm13=0.2
.param W_xm14=1.0     L_xm14=0.2
.param W_xm15=3.0     L_xm15=0.2
.param W_xm16=3.0     L_xm16=0.2
.param W_xm17=3.0     L_xm17=0.2
.param W_xm18=3.0     L_xm18=0.2
.param W_xm19=3.0     L_xm19=0.2
.param W_xm20=3.0     L_xm20=0.2
.param W_xm21=3.0     L_xm21=0.2
.param W_xm22=1.0     L_xm22=0.2
.param W_xm23=1.0     L_xm23=0.2
.param W_xm24=1.0     L_xm24=0.2
.param W_xm25=1.0     L_xm25=0.2
.param W_xm26=1.0     L_xm26=0.2

* Circuit Under Test (from netlist)
VDD VDD 0 1.8
xmisslb P001 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xmisslb} l={L_xmisslb}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm1 VDD_M1 VI1 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 VDD_M2 VI2 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
VCM VCM 0 1.26
VD1 VD1 0 0
B1 VI1 0 V={v(VCM) + v(VD1)}
B2 VI2 0 V={v(VCM)}
xm4 0 N1 N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 0 N2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm41 N1 N1 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}
xm11 VDD VI1 N001 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xmissrb P002 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xmissrb} l={L_xmissrb}
xm31 N2 N2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm31} l={L_xm31}
xm21 VDD VI2 N002 0 sky130_fd_pr__nfet_01v8 w={W_xm21} l={L_xm21}
xmisslt N1 Vbias3 P001 0 sky130_fd_pr__nfet_01v8 w={W_xmisslt} l={L_xmisslt}
xmissrt N2 Vbias3 P002 0 sky130_fd_pr__nfet_01v8 w={W_xmissrt} l={L_xmissrt}

* Current sense zero-volt sources for M1 and M2 drain currents
VID1 VDD VDD_M1 0
VID2 VDD VDD_M2 0

.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 N002 N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 N002 Vbiasn N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N003 0 6.5k
  xm5 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
  xm6 Vbias2 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 N005 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8 Vbias1 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm9 Vbias1 Vbias2 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
  xm10 Vhigh Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
  xm11 Vncas Vbias2 Vhigh VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
  xm12 Vncas Vncas N009 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
  xm13 N009 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
  xm14 N010 N009 GND 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
  xm15 N006 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
  xm16 Vbias3 Vbias2 N006 VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
  xm17 N007 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
  xm18 Vbias4 Vbias2 N007 VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
  xm19 N008 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm19} l={L_xm19}
  xm20 N004 Vbias2 N008 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
  xm21 Vpcas Vpcas N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
  xm22 Vbias3 Vbias3 0 0 sky130_fd_pr__nfet_01v8 w={W_xm22} l={L_xm22}
  xm23 Vpcas Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
  xm24 N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
  xm25 Vbias4 Vbias3 Vlow 0 sky130_fd_pr__nfet_01v8 w={W_xm25} l={L_xm25}
  xm26 Vlow Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm26} l={L_xm26}
.ends SUB_1

.control
* 1. Operating Point Analysis
op
let quiescent_current_id1 = i(VID1)
let quiescent_current_id2 = i(VID2)
let bias_battery_voltage = v(N001) - v(N1)
let quiescent_power = -i(VDD) * 1.8

print quiescent_current_id1 quiescent_current_id2 bias_battery_voltage quiescent_power

* 2. DC Sweep Analysis (sweeping VD1 for differential input)
dc VD1 -1.26 0.54 0.01

meas dc peak_output_current_id1 max i(VID1)
meas dc peak_output_current_id2 max i(VID2)

meas dc id1_q_dc find i(VID1) at=0
let class_ab_boost_ratio = peak_output_current_id1 / id1_q_dc

let id_diff = i(VID1) - i(VID2)
let gm_diff = deriv(id_diff)
meas dc differential_transconductance find gm_diff at=0

print peak_output_current_id1 peak_output_current_id2 class_ab_boost_ratio differential_transconductance

* 3. DC Sweep Analysis (sweeping VCM for common-mode input)
dc VCM 0 1.8 0.01

let tail_margin = v(N1) - v(Vbias3) + 0.45
meas dc input_cm_min find v(VCM) when tail_margin=0

let m11_margin = 1.8 - v(VI1) + 0.45
meas dc input_cm_max find v(VCM) when m11_margin=0

print input_cm_min input_cm_max

quit
.endc
.end