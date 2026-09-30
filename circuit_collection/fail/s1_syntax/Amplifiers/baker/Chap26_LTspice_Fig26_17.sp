* Testbench for Fig. 26.17 Diff-Amp with Split-Tail CMFB
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm1_sub=0.5
.param L_xm2=0.5
.param L_xm2_sub=0.5
.param L_xm3=0.5
.param L_xm3_sub=0.5
.param L_xm4=0.5
.param L_xm4_sub=0.5
.param L_xm5=0.5
.param L_xm5_sub=0.5
.param L_xm6_sub=0.5
.param L_xm6t=0.5
.param L_xm7_sub=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for 10/1 NMOS and 20/1 PMOS
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=20.0 L_xm3=1.0
.param W_xm4=20.0 L_xm4=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6t=10.0 L_xm6t=1.0
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm1_sub=10.0 L_xm1_sub=1.0
.param W_xm2_sub=10.0 L_xm2_sub=1.0
.param W_xm3_sub=20.0 L_xm3_sub=1.0
.param W_xm4_sub=20.0 L_xm4_sub=1.0
.param W_xm5_sub=10.0 L_xm5_sub=1.0
.param W_xm6_sub=10.0 L_xm6_sub=1.0
.param W_xm7_sub=20.0 L_xm7_sub=1.0
.param W_xma3=20.0 L_xma3=1.0
.param W_xma4=20.0 L_xma4=1.0

* Power Supplies and Inputs
VDD VDD 0 1.8
VCM1 N001 0 500m
VCM N002 0 500m
Vcmfb VCMFB 0 700m

* DUT: Diff-Amp with split-tail CMFB (Fig. 26.17)
xm1 vop N001 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 vom N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 vop Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 vom Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 N003 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6t N003 VCMFB 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}

* Bias Generator Subcircuit
X_U1 Vbiasn Vbiasp VDD 0 SUB_1

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3_sub} l={L_xm3_sub}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4_sub} l={L_xm4_sub}
  xm1 Vbiasn Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xm1_sub} l={L_xm1_sub}
  R1 N004 GND 4k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 GND 0 sky130_fd_pr__nfet_01v8 w={W_xm5_sub} l={L_xm5_sub}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7_sub} l={L_xm7_sub}
  xm2 Vbiasp Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xm2_sub} l={L_xm2_sub}
  xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6_sub} l={L_xm6_sub}
.ends SUB_1

.control
* Run operating point analysis
op
let vbiasn_val = v(vbiasn)
let vbiasp_val = v(vbiasp)
let diff_offset = abs(v(vop) - v(vom))
let itail_op = -(i(Vcmfb) + i(VDD))
print vbiasn_val vbiasp_val diff_offset

* Sweep VCMFB as in Fig. 26.17
dc Vcmfb 0.4 1.2 0.002
let vocm = (v(vop) + v(vom)) / 2
let gain_cmfb = deriv(vocm)

* Measure Vocm when VCMFB = Vbiasn
meas dc vocm_at_vbiasn find vocm at=vbiasn_val

* Measure target VCMFB where Vocm = Vbiasp
meas dc vcmfb_target when vocm=vbiasp_val

* Measure forward CMFB gain at target VCMFB
meas dc cmfb_forward_gain find gain_cmfb when vocm=vbiasp_val

let vcmfb_offset = vcmfb_target - vbiasn_val
print vcmfb_offset
quit
.endc
.end