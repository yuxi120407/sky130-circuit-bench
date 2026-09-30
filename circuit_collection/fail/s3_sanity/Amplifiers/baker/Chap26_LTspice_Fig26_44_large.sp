* Testbench for Baker Fig 26.43 Op-Amp with Output CMFB
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

* Parameter definitions based on Fig 26.43 annotations
.param W_xm1=10.0  L_xm1=1.0
.param W_xm2=10.0  L_xm2=1.0
.param W_xm3=20.0  L_xm3=1.0
.param W_xm4=10.0  L_xm4=1.0
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
.param W_xm19=10.0 L_xm19=3.0
.param W_xm20=10.0 L_xm20=1.0
.param W_xm21=40.0 L_xm21=1.0
.param W_xm22=40.0 L_xm22=1.0
.param W_xm23=40.0 L_xm23=1.0
.param W_xm24=40.0 L_xm24=1.0
.param W_xm25=40.0 L_xm25=1.0
.param W_xm26=40.0 L_xm26=1.0
.param W_xm27=40.0 L_xm27=1.0
.param W_xm28=40.0 L_xm28=1.0
.param W_xm29=20.0 L_xm29=1.0
.param W_xm30=10.0 L_xm30=1.0
.param W_xm31=10.0 L_xm31=1.0
.param W_xm32=20.0 L_xm32=1.0
.param W_xm33=20.0 L_xm33=1.0
.param W_xm34=80.0 L_xm34=1.0
.param W_xm35=80.0 L_xm35=1.0

* Subcircuit transistor parameters (Bias generator Fig 26.3)
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xma3=20.0  L_xma3=1.0
.param W_xma4=20.0  L_xma4=1.0

* Power supplies and reference
VDD VDD 0 DC 1.8
VCM VCM 0 DC 0.9

* Bias generator subcircuit
X_U1 Vbiasn Vbiasp VDD 0 SUB_1

* Op-Amp Core (Fig 26.43)
xm2 N001 N001 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 vodm N004 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm6 N001 N004 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 vodp N004 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 N004 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm11 N005 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 vodp N001 ncr 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 vodm N001 ncl 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm5 N008 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm14 N009 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N007 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm16 N007 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 ncr Vm N007 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 ncl Vp N007 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N006 VCM N008 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N004 VCM N009 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}
xm21 vom vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 N012 vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}
xm23 vom N012 N016 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 N012 N012 N015 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
C1 vom ncr 2.5e-14
xm25 vop vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm25} l={L_xm25}
xm26 N013 vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm26} l={L_xm26}
xm27 vop N013 N016 0 sky130_fd_pr__nfet_01v8 w={W_xm27} l={L_xm27}
xm28 N013 N013 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm28} l={L_xm28}
C2 vop ncl 2.5e-14
xm1 N014 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N015 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}

* CMFB circuitry
R1 vop vcma 20000.0
R2 vcma vom 20000.0
C3 vop vcma 1e-14
C4 vcma vom 1e-14
xm29 N010 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm29} l={L_xm29}
xm30 VCMFB N011 0 0 sky130_fd_pr__nfet_01v8 w={W_xm30} l={L_xm30}
xm31 N011 N011 0 0 sky130_fd_pr__nfet_01v8 w={W_xm31} l={L_xm31}
xm32 N011 vcma N010 VDD sky130_fd_pr__pfet_01v8 w={W_xm32} l={L_xm32}
xm33 VCMFB VCM N010 VDD sky130_fd_pr__pfet_01v8 w={W_xm33} l={L_xm33}
xm34 N016 VCMFB 0 0 sky130_fd_pr__nfet_01v8 w={W_xm34} l={L_xm34}
xm35 N016 VCMFB 0 0 sky130_fd_pr__nfet_01v8 w={W_xm35} l={L_xm35}

* Closed-loop Feedback resistors and Output Load capacitors
R3 vop vm 20000.0
R4 vm vip 20000.0
R5 vom vp 20000.0
R6 vp vim 20000.0
C5 vop 0 2.5e-13
C6 vom 0 2.5e-13

* Input sources (Differential pulse + AC source)
Vip_src vip 0 DC 0.9 AC 0.5 PULSE(0.85 0.95 10n 0.1n 0.1n 100n 200n)
Vim_src vim 0 DC 0.9 AC -0.5 PULSE(0.95 0.85 10n 0.1n 0.1n 100n 200n)

* Bias generator definition
.subckt SUB_1 Vbiasn Vbiasp VDD GND
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
.ends SUB_1

.control
  * 1. Operating Point Analysis
  op
  let quiescent_current = -i(VDD)
  let power_dissipation = -i(VDD) * 1.8
  let output_common_mode_voltage = (v(vop) + v(vom)) / 2
  let differential_output_offset = v(vop) - v(vom)
  print quiescent_current power_dissipation output_common_mode_voltage differential_output_offset

  * 2. AC Analysis (Frequency Response)
  ac dec 50 1 10G
  let vodiff = v(vop) - v(vom)
  let vidiff_ol = v(vp) - v(vm)
  let av_ol = vodiff / vidiff_ol
  let av_db = db(av_ol)
  let phase = (180 / PI * cph(av_ol)) + 180
  
  let differential_dc_gain = 0
  let unity_gain_frequency = 0
  let phase_margin = 0
  
  meas ac differential_dc_gain find av_db at=1
  meas ac unity_gain_frequency when av_db=0 fall=1
  meas ac phase_margin find phase when av_db=0 fall=1
  
  print differential_dc_gain unity_gain_frequency phase_margin

  * 3. Transient Analysis
  tran 0.1n 120n 0
  let v_diff_out = v(vop) - v(vom)
  
  let settling_time = 0
  meas tran settling_time trig v(vip) val=0.9 rise=1 targ v_diff_out val=-0.098 cross=LAST
  
  print settling_time
  quit
.endc
.end