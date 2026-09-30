* Testbench for Baker Fig 26.33 Op-Amp with Modified Output Buffer
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

* Parameter defaults matching Baker CMOS textbook dimensions
.param W_xm1=10.0  L_xm1=1.0
.param W_xm2=10.0  L_xm2=1.0
.param W_xm3=20.0  L_xm3=1.0
.param W_xm4=20.0  L_xm4=1.0
.param W_xm5=10.0  L_xm5=1.0
.param W_xm6=20.0  L_xm6=1.0
.param W_xm7=20.0  L_xm7=1.0
.param W_xm8=20.0  L_xm8=1.0
.param W_xm9=20.0  L_xm9=1.0
.param W_xm10=20.0 L_xm10=1.0
.param W_xm11=20.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm14=10.0 L_xm14=1.0
.param W_xm15=10.0 L_xm15=1.0
.param W_xm16=10.0 L_xm16=1.0
.param W_xm17=10.0 L_xm17=1.0
.param W_xm18=10.0 L_xm18=1.0
.param W_xm19=10.0 L_xm19=1.0
.param W_xm20=10.0 L_xm20=1.0
.param W_xm21=40.0 L_xm21=1.0
.param W_xm22=40.0 L_xm22=1.0
.param W_xm23=20.0 L_xm23=1.0
.param W_xm24=20.0 L_xm24=1.0
.param W_xm25=40.0 L_xm25=1.0
.param W_xm26=40.0 L_xm26=1.0
.param W_xm27=20.0 L_xm27=1.0
.param W_xm28=20.0 L_xm28=1.0
.param W_xm29=20.0 L_xm29=1.0
.param W_xm30=10.0 L_xm30=1.0
.param W_xm31=10.0 L_xm31=1.0
.param W_xm32=20.0 L_xm32=1.0
.param W_xm33=20.0 L_xm33=1.0
.param W_xm34=20.0 L_xm34=1.0
.param W_xm35=20.0 L_xm35=1.0

* Subcircuit SUB_1 bias generator parameters
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xma3=20.0  L_xma3=1.0
.param W_xma4=20.0  L_xma4=1.0

* DUT Circuit Instance
VDD VDD 0 1.8
xm2 N001 N001 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 N001 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N001 Vbiasn N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 vodm Vbiasn N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
VCM VCM 0 dc 0.9 ac 0
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xm6 N001 Vbiasn N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 vodp Vbiasn N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm11 N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 vodp N001 ncr 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 vodm N001 ncl 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm5 N007 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm14 N007 VCMFB 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N006 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm16 N006 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 ncr Vm N006 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 ncl Vp N006 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N005 Vp N007 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N005 Vm N007 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}
xm21 vom vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 N011 vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}
xm23 N013 N011 0 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 N011 N011 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
C1 vom ncr 5e-14
xm25 vop vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm25} l={L_xm25}
xm26 N010 vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm26} l={L_xm26}
xm27 N012 N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xm27} l={L_xm27}
xm28 N010 N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xm28} l={L_xm28}
C2 vop ncl 5e-14
R1 vop vcma 20000.0
R2 vcma vom 20000.0
C3 vop vcma 1e-14
C4 vcma vom 1e-14
xm29 N008 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm29} l={L_xm29}
xm30 VCMFB N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm30} l={L_xm30}
xm31 N009 N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm31} l={L_xm31}
xm32 N009 vcma N008 VDD sky130_fd_pr__pfet_01v8 w={W_xm32} l={L_xm32}
xm33 VCMFB VCM N008 VDD sky130_fd_pr__pfet_01v8 w={W_xm33} l={L_xm33}
xm34 vop VDD N012 0 sky130_fd_pr__nfet_01v8 w={W_xm34} l={L_xm34}
xm35 vom VDD N013 0 sky130_fd_pr__nfet_01v8 w={W_xm35} l={L_xm35}
R3 vop vm 20000.0
R4 vm vip 20000.0
R5 vom vp 20000.0
R6 vp vim 20000.0
C5 vop 0 2.5e-13
C6 vom 0 2.5e-13

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__pfet_01v8 w={W_xmsu3} l={L_xmsu3}
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
.ends SUB_1

* Differential pulse sources for transient step response (Fig. 26.35)
V_diff vdiff 0 dc 0 ac 1 PULSE(-0.4 0.4 10n 100p 100p 1u 2u)
V_cm_in vcm_in 0 dc 0.9
B_vip vip 0 V='2*v(vcm_in) - v(vcma) + 0.5*v(vdiff)'
B_vim vim 0 V='2*v(vcm_in) - v(vcma) - 0.5*v(vdiff)'

.control
  * 1. Operating Point Analysis
  op
  let total_quiescent_current = -i(VDD)
  let output_common_mode_voltage = (v(vop) + v(vom)) / 2
  print total_quiescent_current
  print output_common_mode_voltage

  * 2. DC Analysis for CMFB gains and Output Swing
  dc VCM 0.8 1.0 0.001
  let d_vcmfb = deriv(v(VCMFB))
  let d_vcma = deriv(v(vcma))
  let d_error = d_vcma - 1
  let ea_gain = d_vcmfb / d_error
  let fwd_gain = d_vcma / d_vcmfb
  meas dc cmfb_error_amp_gain find ea_gain at=0.9
  meas dc cmfb_forward_gain find fwd_gain at=0.9
  print cmfb_error_amp_gain cmfb_forward_gain

  dc V_diff -2.0 2.0 0.01
  let v_diff_out_dc = v(vop) - v(vom)
  meas dc max_vout max v_diff_out_dc
  meas dc min_vout min v_diff_out_dc
  let differential_output_swing = max_vout - min_vout
  print differential_output_swing

  * 3. AC Analysis for Open Loop Gain
  ac dec 10 1 1G
  let A_OL = (v(vop) - v(vom)) / (v(vp) - v(vm))
  let A_OL_db = db(A_OL)
  meas ac open_loop_differential_gain find A_OL_db at=1
  print open_loop_differential_gain

  * 4. AC Analysis for CMFB Loop Gain
  alter VCM ac=1
  alter V_diff ac=0
  ac dec 10 1 1G
  let cmfb_loop_gain_vec = abs( v(vcma) / (v(VCM) - v(vcma)) )
  meas ac cmfb_loop_gain find cmfb_loop_gain_vec at=1
  print cmfb_loop_gain

  * 5. Transient Analysis for Settling Time
  tran 0.1n 100n
  let v_diff_out_tran = v(vop) - v(vom)
  meas tran vfinal find v_diff_out_tran at=90n
  meas tran vinitial find v_diff_out_tran at=9n
  let vtarget_vec = vinitial + 0.99 * (vfinal - vinitial) + 0 * v_diff_out_tran
  meas tran t_settle_abs find time when v_diff_out_tran=vtarget_vec cross=last
  let large_signal_step_response_settling = t_settle_abs - 10n
  print large_signal_step_response_settling

  quit
.endc
.end