* Testbench for Figure 26.54: First-stage Diff-Amp with SC CMFB
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_SUB1_n=0.5
.param L_SUB1_p=0.5
.param L_default_n=0.5
.param L_default_p=0.5
.param L_tg=0.5
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
.param L_xm3=0.5
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

* Default Transistor Sizing Parameters (W/L in um)
.param W_default_n=10.0 L_default_n=1.0
.param W_default_p=20.0 L_default_p=1.0
.param W_tg=10.0        L_tg=1.0

* Parameter definitions for main circuit
.param W_xm1=20.0  L_xm1=1.0
.param W_xm2=10.0  L_xm2=1.0
.param W_xm3=10.0  L_xm3=3.0
.param W_xm4=20.0  L_xm4=1.0
.param W_xm5=10.0  L_xm5=1.0
.param W_xm6=20.0  L_xm6=1.0
.param W_xm7=20.0  L_xm7=1.0
.param W_xm8=10.0  L_xm8=1.0
.param W_xm9=20.0  L_xm9=1.0
.param W_xm10=20.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm14=10.0 L_xm14=1.0
.param W_xm15=10.0 L_xm15=1.0
.param W_xm16=10.0 L_xm16=1.0
.param W_xm17=10.0 L_xm17=1.0
.param W_xm18=10.0 L_xm18=1.0
.param W_xm19=10.0 L_xm19=1.0
.param W_xm20=10.0 L_xm20=1.0
.param W_xm21=10.0 L_xm21=1.0
.param W_xm22=10.0 L_xm22=1.0
.param W_xm23=10.0 L_xm23=1.0
.param W_xm24=10.0 L_xm24=1.0

* Subcircuit SUB_2 (BMR) Parameters
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xma3=20.0  L_xma3=1.0
.param W_xma4=20.0  L_xma4=1.0

* Subcircuit SUB_1 (SC CMFB) Parameters
.param W_SUB1_n=10.0 L_SUB1_n=1.0
.param W_SUB1_p=10.0 L_SUB1_p=1.0

* Subcircuit Definitions
.subckt SUB_2 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND GND sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn GND sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn GND GND sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  R1 N004 GND 4k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 GND GND sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm2 Vbiasp Vbiasn GND GND sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm6 N003 N003 N004 GND sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
.ends SUB_2

.subckt SUB_1 ideal_vcmfb ideal_vcma Vop Vom phi1 phi1b phi2 phi2b VCMFB VDD GND
  xm1 ideal_vcma phi1 N001 GND sky130_fd_pr__nfet_01v8 w={W_SUB1_n} l={L_SUB1_n}
  xm2 N001 phi1b ideal_vcma VDD sky130_fd_pr__pfet_01v8 w={W_SUB1_p} l={L_SUB1_p}
  xm3 N001 phi2 Vop GND sky130_fd_pr__nfet_01v8 w={W_SUB1_n} l={L_SUB1_n}
  xm4 Vop phi2b N001 VDD sky130_fd_pr__pfet_01v8 w={W_SUB1_p} l={L_SUB1_p}
  xm5 ideal_vcmfb phi1 N003 GND sky130_fd_pr__nfet_01v8 w={W_SUB1_n} l={L_SUB1_n}
  xm6 N003 phi1b ideal_vcmfb VDD sky130_fd_pr__pfet_01v8 w={W_SUB1_p} l={L_SUB1_p}
  xm7 N003 phi2 VCMFB GND sky130_fd_pr__nfet_01v8 w={W_SUB1_n} l={L_SUB1_n}
  xm8 VCMFB phi2b N003 VDD sky130_fd_pr__pfet_01v8 w={W_SUB1_p} l={L_SUB1_p}
  C1 N001 N003 50f
  C2 Vop VCMFB 10f
  xm9 ideal_vcma phi1 N002 GND sky130_fd_pr__nfet_01v8 w={W_SUB1_n} l={L_SUB1_n}
  xm10 N002 phi1b ideal_vcma VDD sky130_fd_pr__pfet_01v8 w={W_SUB1_p} l={L_SUB1_p}
  xm11 N002 phi2 Vom GND sky130_fd_pr__nfet_01v8 w={W_SUB1_n} l={L_SUB1_n}
  xm12 Vom phi2b N002 VDD sky130_fd_pr__pfet_01v8 w={W_SUB1_p} l={L_SUB1_p}
  xm13 ideal_vcmfb phi1 N004 GND sky130_fd_pr__nfet_01v8 w={W_SUB1_n} l={L_SUB1_n}
  xm14 N004 phi1b ideal_vcmfb VDD sky130_fd_pr__pfet_01v8 w={W_SUB1_p} l={L_SUB1_p}
  xm15 N004 phi2 VCMFB GND sky130_fd_pr__nfet_01v8 w={W_SUB1_n} l={L_SUB1_n}
  xm16 VCMFB phi2b N004 VDD sky130_fd_pr__pfet_01v8 w={W_SUB1_p} l={L_SUB1_p}
  C3 N002 N004 50f
  C4 Vom VCMFB 10f
.ends SUB_1

* Power Supplies
VDD VDD 0 DC 1.8
VCM VCM 0 DC 0.5

* DUT Instance
xm2 vomd Vbias1 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 Vbias1 Vbias2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbiasn Vbiasp VDD 0 SUB_2
xm6 N001 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm9 N003 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm13 Vbias1 Vbias1 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm5 N006 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm16 N005 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm18 N004 VCM N005 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 Vbias2 VCM N006 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm1 N002 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm4 vomd Vbias2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm7 vopd Vbias2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 vopd Vbias1 N008 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm11 N007 vp N009 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm12 N008 vm N009 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm14 N009 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N009 VCMFB1 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm17 vomd phi1b vopd VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
xm20 vomd phi1 vopd 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}
X_X1 Vbiasn Vbias1 vopd vomd phi1 phi1b phi2 phi2b VCMFB1 VDD 0 SUB_1
xm21 vp phi1b VCM VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 vp phi1 VCM 0 sky130_fd_pr__nfet_01v8 w={W_xm22} l={L_xm22}
xm23 vm phi1b VCM VDD sky130_fd_pr__pfet_01v8 w={W_xm23} l={L_xm23}
xm24 vm phi1 VCM 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}

* Load / Compensation Capacitors (Fig 26.54: 50fF to ground)
Ccomp_p vopd 0 50f
Ccomp_m vomd 0 50f

* Non-overlapping 100 MHz Clocks (Fig 26.49)
Vphi1  phi1  0 DC 0   PULSE(0   1.8 0   200p 200p 4n 10n)
Vphi1b phi1b 0 DC 1.8 PULSE(1.8 0   0   200p 200p 4n 10n)
Vphi2  phi2  0 DC 0   PULSE(0   1.8 5n  200p 200p 4n 10n)
Vphi2b phi2b 0 DC 1.8 PULSE(1.8 0   5n  200p 200p 4n 10n)

* Input Sources during amplification (phi2 phase)
Vinp vp 0 DC 0.5
Vinm vm 0 DC 0.5

.control
  tran 0.1n 200n uic

  * Measure settled output common-mode voltage during phi2 phase
  meas tran v_opd_val find v(vopd) at=198n
  meas tran v_omd_val find v(vomd) at=198n
  let v_cm_out = 0.5 * (v(vopd) + v(vomd))
  meas tran v_cm_settled find v_cm_out at=198n

  * Measure settled CMFB voltage and bias references
  meas tran v_cmfb_settled find v(vcmfb1) at=198n
  meas tran v_bias1_settled find v(vbias1) at=198n
  meas tran v_biasn_settled find v(vbiasn) at=198n

  * Measure tail current and total power
  let i_tail = - (i(xm14.d) + i(xm15.d))
  meas tran tail_current find i_tail at=198n
  let power = -i(vdd) * 1.8
  meas tran p_diss find power at=198n

  print v_cm_settled v_cmfb_settled v_bias1_settled v_biasn_settled p_diss
  quit
.endc
.end