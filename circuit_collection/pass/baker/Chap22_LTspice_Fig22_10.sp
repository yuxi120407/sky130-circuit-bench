* Testbench for Fig. 22.2 Differential Amplifier
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
.param L_xm1_b=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm25=0.5
.param L_xm26=0.5
.param L_xm2_b=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm6t=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for DUT sizing
.param W_xm6b=10.0 L_xm6b=1.0
.param W_xm6t=10.0 L_xm6t=1.0
.param W_xm1=10.0  L_xm1=1.0
.param W_xm2=10.0  L_xm2=1.0
.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu2=15.0 L_xmsu2=1.0
.param W_xmsu3=5.0 L_xmsu3=1.0
.param W_xm1_b=5.0 L_xm1_b=1.0
.param W_xm2_b=5.0 L_xm2_b=1.0
.param W_xm3=15.0 L_xm3=1.0
.param W_xm4=15.0 L_xm4=1.0
.param W_xm5=15.0 L_xm5=1.0
.param W_xm6=5.0  L_xm6=1.0
.param W_xm7=15.0 L_xm7=1.0
.param W_xm8=5.0  L_xm8=1.0
.param W_xm9=15.0 L_xm9=1.0
.param W_xm10=15.0 L_xm10=1.0
.param W_xm11=15.0 L_xm11=1.0
.param W_xm12=5.0  L_xm12=1.0
.param W_xm13=5.0  L_xm13=1.0
.param W_xm14=5.0  L_xm14=1.0
.param W_xm15=15.0 L_xm15=1.0
.param W_xm16=15.0 L_xm16=1.0
.param W_xm17=15.0 L_xm17=1.0
.param W_xm18=15.0 L_xm18=1.0
.param W_xm19=15.0 L_xm19=1.0
.param W_xm20=15.0 L_xm20=1.0
.param W_xm21=15.0 L_xm21=1.0
.param W_xm22=5.0  L_xm22=1.0
.param W_xm23=5.0  L_xm23=1.0
.param W_xm24=5.0  L_xm24=1.0
.param W_xm25=5.0  L_xm25=1.0
.param W_xm26=5.0  L_xm26=1.0

* Zero-volt sense sources for measuring branch currents
Vsens1 VDD N_drain1 0
Vsens2 VDD N_drain2 0

* Circuit DUT
VDD VDD 0 1.8
xm6b N004 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6t N003 Vbias3 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm1 N_drain1 N001 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N_drain2 N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}

* Modified Stimuli for proper common-mode and differential sweeps
VCM N_VCM 0 0.9
VI2 N002 N_VCM dc 0
VI1 N001 N_VCM dc 0 ac 1 sin(0 1m 1k)

.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 N002 N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1_b} l={L_xm1_b}
  xm2 N002 Vbiasn N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2_b} l={L_xm2_b}
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
* 1. DC Operating Point Analysis
op
let tail_current = i(Vsens1) + i(Vsens2)
let quiescent_branch_current = i(Vsens1)
print tail_current quiescent_branch_current

* 2. DC Sweep on VI1 to find current steering limits
dc VI1 -0.5 0.5 0.005
let id1 = i(Vsens1)
let id2 = i(Vsens2)
meas dc vi1_max_steering find v(N001) when id2=5n fall=1
meas dc vi1_min_steering find v(N001) when id1=5n rise=1

* 3. DC Sweep on VCM to find common-mode limits
dc VCM 0 2.5 0.01
let iss_dc = i(Vsens1) + i(Vsens2)
meas dc vcm_min when iss_dc=0.7u rise=1
let vgd1 = v(N001) - v(N_drain1)
meas dc vcm_max when vgd1=0.6 rise=1

* 4. AC Analysis for small-signal gm
ac dec 10 1k 100k
let gm_meas = 2 * mag(i(Vsens1))
meas ac transconductance_gm find gm_meas at=1k

* 5. Transient Analysis for AC current amplitude
tran 2u 2m
meas tran id1_max max i(Vsens1) from=1m to=2m
meas tran id1_min min i(Vsens1) from=1m to=2m
let diff_ac_current_amplitude = (id1_max - id1_min) / 2
print diff_ac_current_amplitude

quit
.endc
.end