* Baker Fig 27.5 Preamp and Decision Circuit Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm31=0.5
.param L_xm4=0.5
.param L_xm41=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for SKY130 (W/L based on Baker Fig 27.5 & Ex 27.1)
.param W_xmsu3=20.0 L_xmsu3=2.0
.param W_xm1=10.0   L_xm1=2.0
.param W_xm2=10.0   L_xm2=2.0
.param W_xm31=30.0  L_xm31=2.0
.param W_xm41=30.0  L_xm41=2.0
.param W_xm3=30.0   L_xm3=2.0
.param W_xm4=30.0   L_xm4=2.0
.param W_xm5=10.0   L_xm5=1.0
.param W_xm6=12.0   L_xm6=1.0
.param W_xm7=12.0   L_xm7=1.0
.param W_xm8=10.0   L_xm8=1.0

* Parameters for SUB_1 bias circuit
.param W_xmsu1=10.0 L_xmsu1=2.0
.param W_xmsu2=10.0 L_xmsu2=2.0

* Power Supplies and Inputs
VDD VDD 0 1.8
Vp vp 0 0.9
Vm vm 0 0.9

* Pre-amp Tail Current Source
xmsu3 N003 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}

* Pre-amp Diode-Connected PMOS Loads
xm31 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm31} l={L_xm31}
xm41 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}

* Pre-amp Differential Pair NMOS
xm1 N002 vp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N001 vm N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}

* Current Mirror Drivers to Decision Circuit
xm3 vop N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 vom N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}

* Positive Feedback Decision Circuit (M5, M6, M7, M8)
xm5 vop vop 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 vop vom 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 vom vop 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 vom vom 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}

* Bias Generator Subcircuit (Fig. 20.15)
.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 VDD N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 Vbiasp Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 Vbiasp Vbiasn N002 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N002 GND 6.5k
.ends SUB_1

X_U1 Vbiasn Vbiasp VDD 0 SUB_1

.control
* 1. DC Operating Point Analysis
op
let iss_val = @m.xmsu3.msky130_fd_pr__nfet_01v8[id]
let p_diss = -i(vdd) * 1.8
print iss_val
print p_diss

* 2. Sweep Vp upwards to find VSPH, VOH, VOL
dc Vp 0.85 0.95 0.1m
let diff_out = v(vop) - v(vom)
meas dc v_oh max v(vop)
meas dc v_ol min v(vom)
meas dc vp_cross_up when diff_out=0 rise=1
let vsph_val = vp_cross_up - 0.9
print vsph_val

* 3. Sweep Vp downwards to find VSPL
dc Vp 0.95 0.85 -0.1m
let diff_out_dn = v(vop) - v(vom)
meas dc vp_cross_dn when diff_out_dn=0 fall=1
let vspl_val = vp_cross_dn - 0.9
let vhyst_val = vsph_val - vspl_val
print vspl_val
print vhyst_val

quit
.endc
.end