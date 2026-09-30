* PGA Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm2=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm25=0.5
.param L_xm26=0.5
.param L_xm27=0.5
.param L_xm28=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameter definitions
.param W_xm25=5.0 L_xm25=0.5
.param W_xm23=5.0 L_xm23=0.5
.param W_xm21=5.0 L_xm21=0.5
.param W_xm27=5.0 L_xm27=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm15=10.0 L_xm15=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm26=5.0 L_xm26=0.5
.param W_xm24=5.0 L_xm24=0.5
.param W_xm22=5.0 L_xm22=0.5
.param W_xm28=5.0 L_xm28=0.5

* DUT Instantiation
XM25 N_M25_D VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm25} w={W_xm25}
XM23 N_M21_D N_M21_D N_M25_D VDD sky130_fd_pr__pfet_01v8 l={L_xm23} w={W_xm23}
XM21 N_M21_D VIP N_M21_S VSS sky130_fd_pr__nfet_01v8 l={L_xm21} w={W_xm21}
XM27 N_M21_S VBN VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm27} w={W_xm27}
XM7 N_M7_D VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM3 N_M7_D VOM VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM9 N_M9_D VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM1 N_M9_D N_M7_D VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM5 VSS VBN VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM15 N_M15_D VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM11 VOM N_M9_D N_M15_D VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM13 VOM VBN VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM12 VOP N_M10_D N_M15_D VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM14 VOP VBN VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM10 N_M10_D VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM2 N_M10_D N_M8_D VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM6 VSS VBN VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM8 N_M8_D VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM4 N_M8_D VOP VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM26 N_M26_D VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm26} w={W_xm26}
XM24 N_M22_D N_M22_D N_M26_D VDD sky130_fd_pr__pfet_01v8 l={L_xm24} w={W_xm24}
XM22 N_M22_D VIM N_M22_S VSS sky130_fd_pr__nfet_01v8 l={L_xm22} w={W_xm22}
XM28 N_M22_S VBN VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm28} w={W_xm28}

* Power Supplies and Bias
VVDD VDD 0 1.8
VVSS VSS 0 0

* Bias generation
Ibias_n VDD VBN 50u
XM_bn VBN VBN VSS VSS sky130_fd_pr__nfet_01v8 l=0.5 w=5.0

Ibias_p VBP VSS 50u
XM_bp VBP VBP VDD VDD sky130_fd_pr__pfet_01v8 l=0.5 w=5.0

* Dummy bias for isolated input branches to prevent floating nodes
VVIP VIP 0 0.9
VVIM VIM 0 0.9

* Differential Current Inputs to the core (AC=1A diff for Z_T measurement, Tran=20uA p-p diff)
IinP 0 N_M7_D DC 0 AC 0.5 SIN(0 10u 10Meg 0 0 0)
IinM 0 N_M8_D DC 0 AC -0.5 SIN(0 10u 10Meg 0 0 180)

* Ideal balun/difference amplifier for easy measurement
E_DIFF VDIFF 0 VOP VOM 1

.control
  * 1. DC Operating Point & Power
  op
  let Power_Consumption = -i(VVDD) * 1.8
  print Power_Consumption

  * 2. AC Analysis (Transimpedance Gain & Bandwidth)
  ac dec 20 1Meg 10Gig
  meas ac Transimpedance_Gain max vdb(VDIFF)
  meas ac gain_3db param='Transimpedance_Gain - 3'
  meas ac Bandwidth when vdb(VDIFF)=gain_3db fall=1
  print Transimpedance_Gain Bandwidth

  * 3. Transient Analysis (Swing & Linearity)
  tran 1n 500n
  meas tran vout_max max v(VDIFF) from=100n to=500n
  meas tran vout_min min v(VDIFF) from=100n to=500n
  let vout_pp = vout_max - vout_min
  print vout_pp
  
  * THD Measurement at 10 MHz
  meas tran Linearity_THD thd v(VDIFF) from=100n to=500n fund=10Meg
  print Linearity_THD
  
  quit
.endc
.end