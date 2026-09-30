* Testbench for Figure 26.33 Op-Amp with CMFB
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
.param L_xm1_sub=0.5
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
.param L_xm2_sub=0.5
.param L_xm3=0.5
.param L_xm30=0.5
.param L_xm31=0.5
.param L_xm32=0.5
.param L_xm33=0.5
.param L_xm34=0.5
.param L_xm35=0.5
.param L_xm3_sub=0.5
.param L_xm4=0.5
.param L_xm4_sub=0.5
.param L_xm5=0.5
.param L_xm5_sub=0.5
.param L_xm6=0.5
.param L_xm6_sub=0.5
.param L_xm7=0.5
.param L_xm7_sub=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameters for transistors
.param W_xm2=10.0 L_xm2=1.0
.param W_xm1=10.0 L_xm1=1.0
.param W_xm4=20.0 L_xm4=1.0
.param W_xm3=20.0 L_xm3=1.0
.param W_xm6=20.0 L_xm6=1.0
.param W_xm7=20.0 L_xm7=1.0
.param W_xm8=20.0 L_xm8=1.0
.param W_xm9=20.0 L_xm9=1.0
.param W_xm10=20.0 L_xm10=1.0
.param W_xm11=20.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm5=10.0 L_xm5=1.0
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
.param W_xm30=10.0 L_xm30=1.0
.param W_xm31=10.0 L_xm31=1.0
.param W_xm32=20.0 L_xm32=1.0
.param W_xm33=20.0 L_xm33=1.0
.param W_xm34=20.0 L_xm34=1.0
.param W_xm35=20.0 L_xm35=1.0

* Bias circuit parameters
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm3_sub=20.0 L_xm3_sub=1.0
.param W_xm4_sub=20.0 L_xm4_sub=1.0
.param W_xm1_sub=10.0 L_xm1_sub=1.0
.param W_xma4=20.0 L_xma4=1.0
.param W_xma3=20.0 L_xma3=1.0
.param W_xm5_sub=10.0 L_xm5_sub=1.0
.param W_xm7_sub=20.0 L_xm7_sub=1.0
.param W_xm2_sub=10.0 L_xm2_sub=1.0
.param W_xm6_sub=10.0 L_xm6_sub=1.0

* Power Supplies and Common-Mode References
VDD VDD 0 1.8
VCM VCM 0 DC 0.9 AC 1
Vdiff_src Vdiff_node 0 DC 0 AC 1
E1 Vp VCM Vdiff_node 0 1
I_startup VDD Vbiasn 10u

* Circuit Under Test (Figure 26.33)
xm2 N001 N001 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 N001 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N001 Vbiasn N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 vodm Vbiasn N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
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
xm17 ncr VCM N006 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 ncl Vp N006 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N005 Vp N007 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N005 VCM N007 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}
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

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3_sub} l={L_xm3_sub}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4_sub} l={L_xm4_sub}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1_sub} l={L_xm1_sub}
  R1 N004 0 4k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5_sub} l={L_xm5_sub}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7_sub} l={L_xm7_sub}
  xm2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2_sub} l={L_xm2_sub}
  xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6_sub} l={L_xm6_sub}
.ends SUB_1

.control
* 1. Operating Point analysis
op
let quiescent_current = -i(VDD)
let output_common_mode_voltage = (v(vop) + v(vom)) / 2
print quiescent_current output_common_mode_voltage

* 2. AC Frequency Response (Done before DC sweeps to preserve symmetric metastable operating point)
ac dec 10 1 1G
let vdiff_out = v(vop) - v(vom)
let vdiff_in = v(Vdiff_node)
let a_diff = vdiff_out / (vdiff_in + 1e-15)
let a_diff_db = db(a_diff)
meas ac differential_open_loop_gain find a_diff_db at=1
print differential_open_loop_gain

meas ac unity_gain_frequency when a_diff_db=0 fall=1
print unity_gain_frequency

let v_out_cm = (v(vop) + v(vom))/2
let v_err_in = v(vcma) - v(VCM)
let cmfb_amp_gain_complex = v(VCMFB) / (v_err_in + 1e-15)
let cmfb_amp_gain_mag = mag(cmfb_amp_gain_complex)
meas ac cmfb_amplifier_gain find cmfb_amp_gain_mag at=1
print cmfb_amplifier_gain

let cmfb_fwd_gain_complex = v_out_cm / (v(VCMFB) + 1e-15)
let cmfb_loop_complex = cmfb_amp_gain_complex * cmfb_fwd_gain_complex
let cmfb_loop_gain_mag = mag(cmfb_loop_complex)
meas ac cmfb_loop_gain find cmfb_loop_gain_mag at=1
print cmfb_loop_gain

* 3. DC Sweep for CMFB Forward Gain (Maintains differential symmetry)
dc VCM 0.5 1.3 0.01
let v_out_cm = (v(vop) + v(vom))/2
let dV_out_cm = deriv(v_out_cm)
let dV_CMFB = deriv(v(VCMFB))
let cmfb_fwd = dV_out_cm / (dV_CMFB + 1e-15)
meas dc cmfb_forward_gain find cmfb_fwd at=0.9
print cmfb_forward_gain

* 4. DC Sweep for Differential Swing (Breaks symmetry)
dc Vdiff_src -0.5 0.5 0.01
meas dc v_out_max max v(vop)
meas dc v_out_min min v(vop)
let output_voltage_swing = v_out_max - v_out_min
print output_voltage_swing

quit
.endc
.end