* Testbench for Figure 26.25 Sample-and-Hold Circuit with Op-Amp (Fig. 26.33)
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
.param L_xm39=0.5
.param L_xm4=0.5
.param L_xm40=0.5
.param L_xm41=0.5
.param L_xm42=0.5
.param L_xm44=0.5
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

* DUT Parameters
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=20.0 L_xm3=1.0
.param W_xm4=20.0 L_xm4=1.0
.param W_xm5=20.0 L_xm5=1.0
.param W_xm6=20.0 L_xm6=1.0
.param W_xm7=20.0 L_xm7=1.0
.param W_xm8=20.0 L_xm8=1.0
.param W_xm9=20.0 L_xm9=1.0
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
.param W_xm21=40.0 L_xm21=1.0
.param W_xm22=20.0 L_xm22=1.0
.param W_xm23=20.0 L_xm23=1.0
.param W_xm24=20.0 L_xm24=1.0
.param W_xm25=40.0 L_xm25=1.0
.param W_xm26=20.0 L_xm26=1.0
.param W_xm27=20.0 L_xm27=1.0
.param W_xm28=20.0 L_xm28=1.0
.param W_xm29=20.0 L_xm29=1.0
.param W_xm30=10.0 L_xm30=0.15
.param W_xm31=10.0 L_xm31=1.0
.param W_xm32=10.0 L_xm32=0.15
.param W_xm33=10.0 L_xm33=1.0
.param W_xm34=10.0 L_xm34=0.15
.param W_xm35=20.0 L_xm35=1.0
.param W_xm36=10.0 L_xm36=0.15
.param W_xm37=20.0 L_xm37=1.0
.param W_xm38=10.0 L_xm38=0.15
.param W_xm39=20.0 L_xm39=1.0
.param W_xm40=10.0 L_xm40=0.15
.param W_xm41=20.0 L_xm41=1.0
.param W_xm42=10.0 L_xm42=0.15
.param W_xm44=10.0 L_xm44=0.15
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xma3=20.0 L_xma3=1.0
.param W_xma4=20.0 L_xma4=1.0

* Supply and Reference Voltages
VDD VDD 0 1.8
VCM VCM 0 DC 500m AC 0

* Input Signals (Differential 5 MHz sine around VCM)
Vin_p vinp 0 DC 0.5 SIN(0.5 0.1 5MEG 0 0 0)
Vin_m vinm 0 DC 0.5 SIN(0.5 -0.1 5MEG 0 0 0)

* AC Current Sources for Open-Loop Gain Measurement
Iac_p 0 Vm DC 0 AC 1
Iac_m 0 Vp DC 0 AC -1

* Clock Generation: 3-phase non-overlapping clocks (50 MHz)
* Period = 20ns
Vphi1 phi1 0 DC 1.8 PULSE(0 1.8 0.5n 0.2n 0.2n 5n 20n)
Vphi2 phi2 0 DC 0 PULSE(0 1.8 6.5n 0.2n 0.2n 5n 20n)
Vphi3 phi3 0 DC 0 PULSE(0 1.8 12.5n 0.2n 0.2n 6n 20n)

* Nodeset to help bias circuit startup and op-amp inputs
.nodeset v(Vbiasn)=0.8 v(Vbiasp)=1.0 v(Vm)=0.5 v(Vp)=0.5 v(vop)=0.5 v(vom)=0.5

* Instantiation of Subcircuit SUB_1 (Bias generator)
X_U1 Vbiasn Vbiasp VDD 0 SUB_1

* Switched-Capacitor Network (Figure 26.25)
xm30 vinp phi2 N002 0 sky130_fd_pr__nfet_01v8 w={W_xm30} l={L_xm30}
C3 N002 Vm 2.5e-13
xm32 vinm phi2 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm32} l={L_xm32}
C4 N009 Vp 2.5e-13
xm34 N002 phi3 Vop 0 sky130_fd_pr__nfet_01v8 w={W_xm34} l={L_xm34}
xm36 N009 phi3 Vom 0 sky130_fd_pr__nfet_01v8 w={W_xm36} l={L_xm36}
xm38 Vm phi1 Vop 0 sky130_fd_pr__nfet_01v8 w={W_xm38} l={L_xm38}
xm40 Vp phi1 Vom 0 sky130_fd_pr__nfet_01v8 w={W_xm40} l={L_xm40}
xm42 Vop phi3 Voutp 0 sky130_fd_pr__nfet_01v8 w={W_xm42} l={L_xm42}
xm44 Vom phi3 voutm 0 sky130_fd_pr__nfet_01v8 w={W_xm44} l={L_xm44}
C5 Voutp 0 2.5e-13
C6 voutm 0 2.5e-13

* Core Op-Amp and CMFB Circuitry (Figure 26.33)
xm1 N001 N001 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N001 N001 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 N001 Vbiasn N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 vodm Vbiasn N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 N001 Vbiasn N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm6 vodp Vbiasn N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 N005 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm11 vodp N001 ncr 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm12 vodm N001 ncl 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 N008 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm14 N008 VCMFB 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N007 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm16 N007 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 ncr Vm N007 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 ncl Vp N007 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N006 Vp N008 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N006 Vm N008 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}
xm21 vom vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 N013 vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}
xm23 N015 N013 0 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 N013 N013 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
C1 vom ncr 5e-14
xm25 vop vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm25} l={L_xm25}
xm26 N012 vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm26} l={L_xm26}
xm27 N014 N012 0 0 sky130_fd_pr__nfet_01v8 w={W_xm27} l={L_xm27}
xm28 N012 N012 0 0 sky130_fd_pr__nfet_01v8 w={W_xm28} l={L_xm28}
C2 vop ncl 5e-14
R1 vop vcma 20000.0
R2 vcma vom 20000.0
C7 vop vcma 1e-14
C8 vcma vom 1e-14
xm29 N010 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm29} l={L_xm29}
xm31 VCMFB N011 0 0 sky130_fd_pr__nfet_01v8 w={W_xm31} l={L_xm31}
xm33 N011 N011 0 0 sky130_fd_pr__nfet_01v8 w={W_xm33} l={L_xm33}
xm35 N011 vcma N010 VDD sky130_fd_pr__pfet_01v8 w={W_xm35} l={L_xm35}
xm37 VCMFB VCM N010 VDD sky130_fd_pr__pfet_01v8 w={W_xm37} l={L_xm37}
xm39 vop VDD N014 0 sky130_fd_pr__nfet_01v8 w={W_xm39} l={L_xm39}
xm41 vom VDD N015 0 sky130_fd_pr__nfet_01v8 w={W_xm41} l={L_xm41}
C9 vop 0 2.5e-13
C10 vom 0 2.5e-13

* Subcircuit Definition for Reference Bias Circuit (Fig. 26.3)
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

* Control Script
.control
  * 1. DC Operating Point for quiescent current
  op
  let total_quiescent_current = -i(vdd)
  print total_quiescent_current

  * 2. Transient Analysis for large-signal metrics
  tran 100p 400n
  let vocm = (v(vop) + v(vom)) / 2
  let vdiff = v(vop) - v(vom)
  meas tran output_cm_voltage avg vocm from=200n to=400n
  meas tran output_voltage_swing pp vdiff from=200n to=400n
  print output_cm_voltage output_voltage_swing

  * 3. AC Analysis for Open-Loop Gain
  ac dec 10 1 1G
  let diff_out = v(vop) - v(vom)
  let diff_in = v(vp) - v(vm)
  let diff_gain_db = db(diff_out / diff_in)
  meas ac differential_open_loop_gain find diff_gain_db at=1
  print differential_open_loop_gain

  * 4. AC Analysis for CMFB Gains
  alter Iac_p ac=0
  alter Iac_m ac=0
  alter VCM ac=1
  ac dec 10 1 1G

  let cmfb_amp_in = v(vcma) - v(vcm)
  let cmfb_amp_gain_db = db(v(vcmfb) / cmfb_amp_in)
  meas ac cmfb_amplifier_gain find cmfb_amp_gain_db at=1

  let cmfb_fwd_gain_db = db(v(vcma) / v(vcmfb))
  meas ac cmfb_forward_gain find cmfb_fwd_gain_db at=1

  let cmfb_loop_gain_db = db(v(vcma) / cmfb_amp_in)
  meas ac cmfb_loop_gain find cmfb_loop_gain_db at=1

  print cmfb_amplifier_gain cmfb_forward_gain cmfb_loop_gain
  quit
.endc
.end