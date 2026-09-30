* Testbench for Two-Stage Op-Amp with SC CMFB (Figs 26.54 & 26.56)
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
.param L_xm27=0.5
.param L_xm28=0.5
.param L_xm29=0.5
.param L_xm3=0.5
.param L_xm30=0.5
.param L_xm31=0.5
.param L_xm32=0.5
.param L_xm33=0.5
.param L_xm34=0.5
.param L_xm35=0.5
.param L_xm36=0.5
.param L_xm37=0.5
.param L_xm38=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Sizing Parameters (W/L in meters)
.param W_xm1=20.0   L_xm1=1.0
.param W_xm2=10.0   L_xm2=1.0
.param W_xm3=10.0   L_xm3=3.0
.param W_xm4=20.0   L_xm4=1.0
.param W_xm5=10.0   L_xm5=1.0
.param W_xm6=20.0   L_xm6=1.0
.param W_xm7=20.0   L_xm7=1.0
.param W_xm8=10.0   L_xm8=1.0
.param W_xm9=20.0   L_xm9=1.0
.param W_xm10=20.0  L_xm10=1.0
.param W_xm11=10.0  L_xm11=1.0
.param W_xm12=10.0  L_xm12=1.0
.param W_xm13=10.0  L_xm13=1.0
.param W_xm14=10.0  L_xm14=1.0
.param W_xm15=10.0  L_xm15=1.0
.param W_xm16=10.0  L_xm16=1.0
.param W_xm17=10.0  L_xm17=1.0
.param W_xm18=10.0  L_xm18=1.0
.param W_xm19=10.0  L_xm19=1.0
.param W_xm20=10.0  L_xm20=1.0
.param W_xm21=10.0  L_xm21=1.0
.param W_xm22=10.0  L_xm22=1.0
.param W_xm23=10.0  L_xm23=1.0
.param W_xm24=10.0  L_xm24=1.0
.param W_xm25=40.0  L_xm25=1.0
.param W_xm26=40.0  L_xm26=1.0
.param W_xm27=20.0  L_xm27=1.0
.param W_xm28=20.0  L_xm28=1.0
.param W_xm29=40.0  L_xm29=1.0
.param W_xm30=40.0  L_xm30=1.0
.param W_xm31=20.0  L_xm31=1.0
.param W_xm32=20.0  L_xm32=1.0
.param W_xm33=20.0  L_xm33=1.0
.param W_xm34=20.0  L_xm34=1.0
.param W_xm35=10.0  L_xm35=1.0
.param W_xm36=10.0  L_xm36=1.0
.param W_xm37=10.0  L_xm37=1.0
.param W_xm38=10.0  L_xm38=1.0

* Subcircuit transistor sizing
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xma3=20.0  L_xma3=1.0
.param W_xma4=20.0  L_xma4=1.0

* DUT Connection
VDD VDD 0 1.8
VCM VCM 0 500m

* Clocks from Baker (page 896, 100MHz non-overlapping)
Vphi1  phi1  0 dc 0   pulse 0 1.8 0    200p 200p 4n 10n
Vphi1b phi1b 0 dc 1.8 pulse 1.8 0 0    200p 200p 4n 10n
Vphi2  phi2  0 dc 1.8 pulse 0 1.8 5n   200p 200p 4n 10n
Vphi2b phi2b 0 dc 0   pulse 1.8 0 5n   200p 200p 4n 10n

* Modes for AC/Tran
V_cmfb_mode cmfb_mode 0 pulse 1 0 10p 1p 1p 100 100 dc 1
V_loop_mode loop_mode 0 pulse 0 1 10p 1p 1p 100 100 dc 0

* Signal Inputs
V_step step 0 pulse 0 0.2 1.005u 100p 100p 2u 5u
V_ac_p ac_p 0 dc 0 ac 0.5
V_ac_m ac_m 0 dc 0 ac -0.5

B_vp vp 0 V='0.5 + V(step) - V(loop_mode) * 0.5 * (V(vop) - V(vom)) + V(ac_p)'
B_vm vm 0 V='0.5 - V(step) + V(loop_mode) * 0.5 * (V(vop) - V(vom)) + V(ac_m)'

* Artificial CMFB for DC/AC analysis
B_cmfb1 VCMFB1 0 I='V(cmfb_mode) * 1e-3 * (V(VCMFB1) - (V(Vbiasn) + 100*(0.5*(V(vopd) + V(vomd)) - V(Vbias1))))'
B_cmfb2 VCMFB2 0 I='V(cmfb_mode) * 1e-3 * (V(VCMFB2) - (V(Vbiasn) + 100*(0.5*(V(vop) + V(vom)) - V(VCM))))'

R_cmfb1 VCMFB1 0 1T
R_cmfb2 VCMFB2 0 1T

* Output Loads
CL1 vop 0 250f
CL2 vom 0 250f

* Op-Amp Circuit Netlist
xm2 vomd Vbias1 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 Vbias1 Vbias2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbiasn Vbiasp VDD 0 SUB_2
xm6 N001 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm9 N003 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm13 Vbias1 Vbias1 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm5 N010 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm16 N009 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm18 N006 VCM N009 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 Vbias2 VCM N010 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm1 N002 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm4 vomd Vbias2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm7 vopd Vbias2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 vopd Vbias1 N012 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm11 N011 vp N014 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm12 N012 vm N014 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm14 N014 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N014 VCMFB1 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm17 vomd phi1b vopd VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
xm20 vomd phi1 vopd 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}
X_X1 Vbiasn Vbias1 vopd vomd phi1 phi1b phi2 phi2b VCMFB1 VDD 0 SUB_1
xm21 vp phi1b VCM VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 vp phi1 VCM 0 sky130_fd_pr__nfet_01v8 w={W_xm22} l={L_xm22}
xm23 vm phi1b VCM VDD sky130_fd_pr__pfet_01v8 w={W_xm23} l={L_xm23}
xm24 vm phi1 VCM 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
C1 N011 vop 5e-14
C2 vom N012 5e-14
xm25 vom vopd VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm25} l={L_xm25}
xm26 N004 vomd VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm26} l={L_xm26}
xm27 vom N004 N013 0 sky130_fd_pr__nfet_01v8 w={W_xm27} l={L_xm27}
xm28 N004 N004 N008 0 sky130_fd_pr__nfet_01v8 w={W_xm28} l={L_xm28}
xm29 vop vomd VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm29} l={L_xm29}
xm30 N005 vopd VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm30} l={L_xm30}
xm31 vop N005 N013 0 sky130_fd_pr__nfet_01v8 w={W_xm31} l={L_xm31}
xm32 N005 N005 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm32} l={L_xm32}
xm33 N013 VCMFB2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm33} l={L_xm33}
xm34 N013 VCMFB2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm34} l={L_xm34}
xm35 N007 VCM 0 0 sky130_fd_pr__nfet_01v8 w={W_xm35} l={L_xm35}
xm36 N008 VCM 0 0 sky130_fd_pr__nfet_01v8 w={W_xm36} l={L_xm36}
xm37 vop phi1b vom VDD sky130_fd_pr__pfet_01v8 w={W_xm37} l={L_xm37}
xm38 vop phi1 vom 0 sky130_fd_pr__nfet_01v8 w={W_xm38} l={L_xm38}
X_X2 VCM VCM vop vom phi1 phi1b phi2 phi2b VCMFB2 VDD 0 SUB_1

.subckt SUB_2 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  R1 N004 0 4k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
.ends SUB_2

.subckt SUB_1 ideal_vcmfb ideal_vcma Vop Vom phi1 phi1b phi2 phi2b VCMFB VDD GND
  xm1 ideal_vcma phi1 N001 GND sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 N001 phi1b ideal_vcma VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
  xm3 N001 phi2 vop 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
  xm4 vop phi2b N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm5 ideal_vcmfb phi1 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm6 N003 phi1b ideal_vcmfb VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
  xm7 N003 phi2 VCMFB 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
  xm8 VCMFB phi2b N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  C1 N001 N003 50f
  C2 vop VCMFB 10f
  xm9 ideal_vcma phi1 N002 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
  xm10 N002 phi1b ideal_vcma VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
  xm11 N002 phi2 vom 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 vom phi2b N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
  xm13 ideal_vcmfb phi1 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
  xm14 N004 phi1b ideal_vcmfb VDD sky130_fd_pr__pfet_01v8 w={W_xm14} l={L_xm14}
  xm15 N004 phi2 VCMFB 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
  xm16 VCMFB phi2b N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
  C3 N002 N004 50f
  C4 vom VCMFB 10f
.ends SUB_1

.control
* 1. DC Analysis for OP power
dc VDD 1.8 1.8 1
let pwr_dc = -i(v.VDD) * 1.8
meas dc total_quiescent_power find pwr_dc at=1.8

* 2. AC Analysis
ac dec 20 1 10G
let vdiff_ac = v(vop) - v(vom)
let vdiff_db = db(vdiff_ac)
meas ac unity_gain_frequency when vdiff_db=0 cross=last

* 3. Transient Analysis
tran 1n 5u
let vocm = (v(vop) + v(vom)) / 2
let vocmd = (v(vopd) + v(vomd)) / 2

meas tran output_common_mode_voltage find vocm at=4.9u
meas tran diff_amp_output_cm_voltage find vocmd at=4.9u

let vdiff = v(vop) - v(vom)
meas tran vdiff_final find vdiff at=2.9u
meas tran t_start when v(step)=0.1 rise=1
meas tran t_settle when vdiff='vdiff_final * 0.99' td=1.005u rise=last
let settling_time = t_settle - t_start

print output_common_mode_voltage diff_amp_output_cm_voltage settling_time total_quiescent_power unity_gain_frequency
quit
.endc
.end