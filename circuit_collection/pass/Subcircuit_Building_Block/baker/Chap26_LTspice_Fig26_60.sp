* Testbench for Fig. 26.58 SC Sample-and-Hold with Fully-Differential Op-Amp
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
.param L_xm43=0.5
.param L_xm44=0.5
.param L_xm45=0.5
.param L_xm46=0.5
.param L_xm47=0.5
.param L_xm48=0.5
.param L_xm49=0.5
.param L_xm5=0.5
.param L_xm50=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Set transistor sizing parameters (W scaled by 4 for diff-pair and buffer as in text p. 903)
.param L_def=0.15
.param W_n10=1.5
.param W_n30=4.5
.param W_n40=6.0
.param W_p10=1.5
.param W_p20=3.0
.param W_p40=6.0
.param W_p80=12.0

* Parameter mappings for netlist
.param W_xm1={W_p20} L_xm1=L_def
.param W_xm2=W_n10 L_xm2=L_def
.param W_xm3=W_p10 L_xm3=0.45
.param W_xm4={W_p20} L_xm4=L_def
.param W_xm5=W_n10 L_xm5=L_def
.param W_xm6={W_p20} L_xm6=L_def
.param W_xm7={W_p20} L_xm7=L_def
.param W_xm8=W_n10 L_xm8=L_def
.param W_xm9={W_p20} L_xm9=L_def
.param W_xm10=W_p10 L_xm10=0.45
.param W_xm11={W_n40} L_xm11=L_def
.param W_xm12={W_n40} L_xm12=L_def
.param W_xm13=W_n10 L_xm13=L_def
.param W_xm14=W_n10 L_xm14=L_def
.param W_xm15=W_n10 L_xm15=L_def
.param W_xm16=W_n10 L_xm16=L_def
.param W_xm17=W_p10 L_xm17=L_def
.param W_xm18={W_n40} L_xm18=L_def
.param W_xm19={W_n40} L_xm19=L_def
.param W_xm20=W_n10 L_xm20=L_def
.param W_xm21=W_p10 L_xm21=L_def
.param W_xm22=W_n10 L_xm22=L_def
.param W_xm23=W_p10 L_xm23=L_def
.param W_xm24=W_n10 L_xm24=L_def
.param W_xm25={W_p80} L_xm25=L_def
.param W_xm26={W_p80} L_xm26=L_def
.param W_xm27={W_n40} L_xm27=L_def
.param W_xm28={W_n40} L_xm28=L_def
.param W_xm29={W_p80} L_xm29=L_def
.param W_xm30={W_p80} L_xm30=L_def
.param W_xm31={W_n40} L_xm31=L_def
.param W_xm32={W_n40} L_xm32=L_def
.param W_xm33={W_n40} L_xm33=L_def
.param W_xm34={W_n40} L_xm34=L_def
.param W_xm35={W_n40} L_xm35=L_def
.param W_xm36={W_n40} L_xm36=L_def
.param W_xm37=W_p10 L_xm37=L_def
.param W_xm38=W_n10 L_xm38=L_def
.param W_xm39=W_p10 L_xm39=L_def
.param W_xm40=W_n10 L_xm40=L_def
.param W_xm41=W_p10 L_xm41=L_def
.param W_xm42=W_n10 L_xm42=L_def
.param W_xm43=W_p10 L_xm43=L_def
.param W_xm44=W_n10 L_xm44=L_def
.param W_xm45=W_p10 L_xm45=L_def
.param W_xm46=W_n10 L_xm46=L_def
.param W_xm47=W_p10 L_xm47=L_def
.param W_xm48=W_n10 L_xm48=L_def
.param W_xm49=W_p10 L_xm49=L_def
.param W_xm50=W_n10 L_xm50=L_def

* Subcircuit parameters
.param W_xmsu1=W_n10 L_xmsu1=L_def
.param W_xmsu2={W_p20} L_xmsu2=L_def
.param W_xmsu3=W_n10 L_xmsu3=L_def
.param W_xma3={W_p20} L_xma3=L_def
.param W_xma4={W_p20} L_xma4=L_def

* DUT Netlist
VDD VDD 0 1.8
xm2 vomd Vbias1 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 Vbias1 Vbias2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
VCM VCM 0 500m
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
C1 N011 vop 1.25e-14
C2 vom N012 1.25e-14
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
xm39 vinp phi1b N015 VDD sky130_fd_pr__pfet_01v8 w={W_xm39} l={L_xm39}
xm40 vinp phi1 N015 0 sky130_fd_pr__nfet_01v8 w={W_xm40} l={L_xm40}
C3 vm N015 2.5e-13
xm41 N015 phi2b Vop VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}
xm42 N015 phi2 Vop 0 sky130_fd_pr__nfet_01v8 w={W_xm42} l={L_xm42}
xm43 vinm phi1b N016 VDD sky130_fd_pr__pfet_01v8 w={W_xm43} l={L_xm43}
xm44 vinm phi1 N016 0 sky130_fd_pr__nfet_01v8 w={W_xm44} l={L_xm44}
C4 vp N016 2.5e-13
xm45 N016 phi2b Vom VDD sky130_fd_pr__pfet_01v8 w={W_xm45} l={L_xm45}
xm46 N016 phi2 Vom 0 sky130_fd_pr__nfet_01v8 w={W_xm46} l={L_xm46}
xm47 Vop phi2b Voutp VDD sky130_fd_pr__pfet_01v8 w={W_xm47} l={L_xm47}
xm48 Vop phi2 Voutp 0 sky130_fd_pr__nfet_01v8 w={W_xm48} l={L_xm48}
xm49 Vom phi2b Voutm VDD sky130_fd_pr__pfet_01v8 w={W_xm49} l={L_xm49}
xm50 Vom phi2 Voutm 0 sky130_fd_pr__nfet_01v8 w={W_xm50} l={L_xm50}
C5 Voutp 0 2.5e-13
C6 Voutm 0 2.5e-13

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
  xm1 ideal_vcma phi1 N001 GND sky130_fd_pr__nfet_01v8 w={W_n10} l={L_def}
  xm2 N001 phi1b ideal_vcma VDD sky130_fd_pr__pfet_01v8 w={W_p10} l={L_def}
  xm3 N001 phi2 vop 0 sky130_fd_pr__nfet_01v8 w={W_n10} l={L_def}
  xm4 vop phi2b N001 VDD sky130_fd_pr__pfet_01v8 w={W_p10} l={L_def}
  xm5 ideal_vcmfb phi1 N003 0 sky130_fd_pr__nfet_01v8 w={W_n10} l={L_def}
  xm6 N003 phi1b ideal_vcmfb VDD sky130_fd_pr__pfet_01v8 w={W_p10} l={L_def}
  xm7 N003 phi2 VCMFB 0 sky130_fd_pr__nfet_01v8 w={W_n10} l={L_def}
  xm8 VCMFB phi2b N003 VDD sky130_fd_pr__pfet_01v8 w={W_p10} l={L_def}
  C1 N001 N003 50f
  C2 vop VCMFB 10f
  xm9 ideal_vcma phi1 N002 0 sky130_fd_pr__nfet_01v8 w={W_n10} l={L_def}
  xm10 N002 phi1b ideal_vcma VDD sky130_fd_pr__pfet_01v8 w={W_p10} l={L_def}
  xm11 N002 phi2 vom 0 sky130_fd_pr__nfet_01v8 w={W_n10} l={L_def}
  xm12 vom phi2b N002 VDD sky130_fd_pr__pfet_01v8 w={W_p10} l={L_def}
  xm13 ideal_vcmfb phi1 N004 0 sky130_fd_pr__nfet_01v8 w={W_n10} l={L_def}
  xm14 N004 phi1b ideal_vcmfb VDD sky130_fd_pr__pfet_01v8 w={W_p10} l={L_def}
  xm15 N004 phi2 VCMFB 0 sky130_fd_pr__nfet_01v8 w={W_n10} l={L_def}
  xm16 VCMFB phi2b N004 VDD sky130_fd_pr__pfet_01v8 w={W_p10} l={L_def}
  C3 N002 N004 50f
  C4 vom VCMFB 10f
.ends SUB_1

* Clocks: 10 MHz non-overlapping clock generation
Vphi1  phi1  0 PULSE(0 1.8 0      1n 1n 44n 100n)
Vphi1b phi1b 0 PULSE(1.8 0 0      1n 1n 44n 100n)
Vphi2  phi2  0 PULSE(0 1.8 50n    1n 1n 44n 100n)
Vphi2b phi2b 0 PULSE(1.8 0 50n    1n 1n 44n 100n)

* Inputs: 500 kHz square wave differential inputs centered at VCM = 0.5 V
Vinp vinp 0 PULSE(0.4 0.6 1500n 1n 1n 1000n 2000n)
Vinm vinm 0 PULSE(0.6 0.4 1500n 1n 1n 1000n 2000n)

.control
save all
save @m.xm11.msky130_fd_pr__nfet_01v8[gm]

* Run transient analysis for 2000 ns
tran 0.5n 2000n uic

* Define vectors
let v_diff_out = v(voutp) - v(voutm)
let v_diff_in  = v(vinp) - v(vinm)
let v_opd_cm   = (v(vopd) + v(vomd)) / 2
let v_out_cm   = (v(vop) + v(vom)) / 2

* 1. unity_gain_frequency
meas tran gm_val find @m.xm11.msky130_fd_pr__nfet_01v8[gm] at=1590n
let unity_gain_frequency = $&gm_val / (2 * 3.1415926535 * 1.25e-14)

* 2. settling_time
meas tran vfinal find v_diff_out at=1590n
let v_diff_out_norm = v_diff_out / $&vfinal
meas tran settling_time trig v(phi2) val=0.9 rise=1 targ v_diff_out_norm val=0.99 cross=last from=1540n to=1594n

* 3. diff_amp_output_cm
meas tran diff_amp_output_cm find v_opd_cm at=1590n

* 4. output_cm_voltage
meas tran output_cm_voltage find v_out_cm at=1590n

* 5. diff_amp_cmfb_control_voltage
meas tran diff_amp_cmfb_control_voltage find v(vcmfb1) at=1590n

* 6. differential_output_swing
meas tran v_low find v_diff_out at=1490n
let differential_output_swing = $&vfinal - $&v_low

print unity_gain_frequency settling_time diff_amp_output_cm output_cm_voltage diff_amp_cmfb_control_voltage differential_output_swing
quit
.endc
.end