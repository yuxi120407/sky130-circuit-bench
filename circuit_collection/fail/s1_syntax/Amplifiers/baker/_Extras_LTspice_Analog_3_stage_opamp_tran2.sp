* Testbench for Class AB Op-Amp
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm6t=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Define parameters for the parameterized netlist
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=20.0 L_xm3=1.0
.param W_xm4=20.0 L_xm4=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6t=10.0 L_xm6t=1.0
.param W_xm6=20.0 L_xm6=1.0
.param W_xm7=20.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xm9=10.0 L_xm9=1.0
.param W_xm10=10.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=20.0 L_xm12=1.0
.param W_xm13=20.0 L_xm13=1.0
.param W_xm14=40.0 L_xm14=1.0
.param W_xm15=80.0 L_xm15=1.0
.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu2=10.0 L_xmsu2=1.0
.param W_xmsu3=5.0 L_xmsu3=1.0
.param W_xma3=10.0 L_xma3=1.0
.param W_xma4=10.0 L_xma4=1.0

* Include DUT
VDD VDD 0 1.8
xm2 fbr VCM N002 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 fbl Vm N002 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 out12 out11 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 out11 out11 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm6t N002 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xm5 N002 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N001 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 N001 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 out12 VCM fbr 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 out11 Vm fbl 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 Out22 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm12 N003 Out12 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 Out22 Out11 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm13} l={L_xm13}
xm14 out Out22 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 out Out12 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
C1 out 0 1e-11
C2 out fbr 2.4e-13
C3 Out22 fbl 2.4e-13
R1 Vm out 10000.0
R2 Vin Vm 10000.0
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

* Sources
V1 VCM 0 DC 0.9
V2 Vin 0 DC 0.9 AC 1 pulse(0.4 1.4 10n 1n 1n 200n 400n)

.control
  * DC Operating Point
  op
  let power = -i(VDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1 1G
  * Calculate Open-Loop Gain from the closed-loop circuit
  let Vdiff = v(VCM) - v(Vm)
  let A_OL_mag = mag(v(out) / Vdiff)
  let A_OL_db = 20 * log10(A_OL_mag)
  let A_OL_phase = 180/PI * cph(v(out) / Vdiff)
  
  meas ac dc_gain find A_OL_db at=1
  meas ac f_un when A_OL_db=0 fall=1
  meas ac pm find A_OL_phase when A_OL_db=0 fall=1

  * Transient Analysis
  tran 1n 600n
  meas tran slew_rate_rise deriv v(out) at=12n
  meas tran slew_rate_fall deriv v(out) at=212n
  quit
.endc
.end
