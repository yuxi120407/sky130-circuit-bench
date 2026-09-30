* Testbench for Fig 26.58 Switched-Capacitor S/H Op-Amp with SC CMFB
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

* Sizing Parameters matching Chapter 26 (10/1 NMOS, 20/1 PMOS default)
.param L_def=0.15
.param W_n10=1.5
.param W_p20=3.0
.param W_n40=6.0
.param W_p40=6.0

* DUT transistor parameter assignments
.param W_xm1={W_p20} L_xm1={L_def}
.param W_xm2={W_n10} L_xm2={L_def}
.param W_xm3={W_p20} L_xm3={L_def}
.param W_xm4={W_p20} L_xm4={L_def}
.param W_xm5={W_n10} L_xm5={L_def}
.param W_xm6={W_p20} L_xm6={L_def}
.param W_xm7={W_p20} L_xm7={L_def}
.param W_xm8={W_n10} L_xm8={L_def}
.param W_xm9={W_p20} L_xm9={L_def}
.param W_xm10={W_p20} L_xm10={L_def}
.param W_xm11={W_n10} L_xm11={L_def}
.param W_xm12={W_n10} L_xm12={L_def}
.param W_xm13={W_n10} L_xm13={L_def}
.param W_xm14={W_n10} L_xm14={L_def}
.param W_xm15={W_n10} L_xm15={L_def}
.param W_xm16={W_n10} L_xm16={L_def}
.param W_xm17={W_p20} L_xm17={L_def}
.param W_xm18={W_n10} L_xm18={L_def}
.param W_xm19={W_n10} L_xm19={L_def}
.param W_xm20={W_n10} L_xm20={L_def}
.param W_xm21={W_p20} L_xm21={L_def}
.param W_xm22={W_n10} L_xm22={L_def}
.param W_xm23={W_p20} L_xm23={L_def}
.param W_xm24={W_n10} L_xm24={L_def}
.param W_xm25={W_p40} L_xm25={L_def}
.param W_xm26={W_p40} L_xm26={L_def}
.param W_xm27={W_n10} L_xm27={L_def}
.param W_xm28={W_n10} L_xm28={L_def}
.param W_xm29={W_p40} L_xm29={L_def}
.param W_xm30={W_p40} L_xm30={L_def}
.param W_xm31={W_n10} L_xm31={L_def}
.param W_xm32={W_n10} L_xm32={L_def}
.param W_xm33={W_n10} L_xm33={L_def}
.param W_xm34={W_n10} L_xm34={L_def}
.param W_xm35={W_n10} L_xm35={L_def}
.param W_xm36={W_n10} L_xm36={L_def}
.param W_xm37={W_p20} L_xm37={L_def}
.param W_xm38={W_n10} L_xm38={L_def}
.param W_xm39={W_p20} L_xm39={L_def}
.param W_xm40={W_n10} L_xm40={L_def}
.param W_xm41={W_p20} L_xm41={L_def}
.param W_xm42={W_n10} L_xm42={L_def}
.param W_xm43={W_p20} L_xm43={L_def}
.param W_xm44={W_n10} L_xm44={L_def}
.param W_xm45={W_p20} L_xm45={L_def}
.param W_xm46={W_n10} L_xm46={L_def}
.param W_xm47={W_p20} L_xm47={L_def}
.param W_xm48={W_n10} L_xm48={L_def}
.param W_xm49={W_p20} L_xm49={L_def}
.param W_xm50={W_n10} L_xm50={L_def}

* Subcircuit transistor parameters
.param W_xmsu1={W_n10} L_xmsu1={L_def}
.param W_xmsu2={W_p20} L_xmsu2={L_def}
.param W_xmsu3={W_n10} L_xmsu3={L_def}
.param W_xma3={W_p20} L_xma3={L_def}
.param W_xma4={W_p20} L_xma4={L_def}

* Power Supplies
VDD VDD 0 1.8
VCM VCM 0 0.9

* 10 MHz Non-overlapping Clocks (Period = 100ns)
* phi1: high 0 to 45ns, low 45 to 100ns
Vphi1 phi1 0 DC 0 PULSE(0 1.8 0 1n 1n 44n 100n)
Vphi1b phi1b 0 DC 1.8 PULSE(1.8 0 0 1n 1n 44n 100n)
* phi2: high 50 to 95ns, low 95 to 100ns
Vphi2 phi2 0 DC 0 PULSE(0 1.8 50n 1n 1n 44n 100n)
Vphi2b phi2b 0 DC 1.8 PULSE(1.8 0 50n 1n 1n 44n 100n)

* 500 kHz Differential Inputs (VCM +/- 0.3*sin)
V_vinp vinp 0 SIN(0.9 0.3 500k 0 0 0)
V_vinm vinm 0 SIN(0.9 0.3 500k 0 0 180)

* AC Current Sources for Open-Loop Measurement
Iac_p 0 vp AC 1
Iac_m 0 vm AC -1

* DC Bias for Floating Nodes during OP/AC
L_cmfb1 VCMFB1 Vbiasn 1G
L_cmfb2 VCMFB2 VCM 1G
L_vp vp VCM 1G
L_vm vm VCM 1G

* DUT Instantiation
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
* Run OP to get tail voltage margin
op
let diff_amp_tail_voltage_margin = v(n014)
print diff_amp_tail_voltage_margin

* Run AC for unity gain frequency
ac dec 10 1k 10G
let vdiff_in = v(vp) - v(vm)
let vdiff_out = v(vop) - v(vom)
let gain = vdiff_out / vdiff_in
let gain_db = db(gain)
meas ac unity_gain_frequency when gain_db=0
print unity_gain_frequency

* Run TRAN
tran 0.2n 2000n

* Output common-mode voltage
let v_out_cm = (v(voutp) + v(voutm)) / 2
meas tran output_common_mode_voltage avg v_out_cm from=1000n to=2000n
print output_common_mode_voltage

* Diff-amp output common-mode voltage
let v_diff_cm = (v(vopd) + v(vomd)) / 2
meas tran diff_amp_output_common_mode_voltage avg v_diff_cm from=1000n to=2000n
print diff_amp_output_common_mode_voltage

* Differential output voltage swing
let v_diff_out = v(voutp) - v(voutm)
meas tran vout_diff_max max v_diff_out from=1000n to=2000n
meas tran vout_diff_min min v_diff_out from=1000n to=2000n
meas tran differential_output_voltage_swing param='vout_diff_max - vout_diff_min'
print differential_output_voltage_swing

* Power dissipation
let power = -i(vdd) * 1.8
meas tran power_dissipation avg power from=1000n to=2000n
print power_dissipation

* Settling time
meas tran t_phi2_rise when v(phi2)=0.9 rise=18
meas tran vdiff_target find v_diff_out at=1794n
meas tran tol param='0.01 * abs(vdiff_target)'
let v_err = abs(v_diff_out - ($&vdiff_target))
meas tran t_settled when v_err=$&tol fall=last from=1750n to=1794n
meas tran settling_time param='t_settled - t_phi2_rise'
print settling_time

quit
.endc
.end