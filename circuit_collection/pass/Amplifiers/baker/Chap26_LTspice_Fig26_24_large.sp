* Testbench for Baker Fig. 26.24 / Fig. 26.22 Op-Amp Step Response
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

* Parameter definitions for 10/1 NMOS and 20/1 PMOS
.param W_n=10.0
.param L_n=1.0
.param W_p=20.0
.param L_p=1.0

.param W_xm1={W_n}  L_xm1={L_n}
.param W_xm2={W_n}  L_xm2={L_n}
.param W_xm3={W_p}  L_xm3={L_p}
.param W_xm4={W_p}  L_xm4={L_p}
.param W_xm5={W_n}  L_xm5={L_n}
.param W_xm6={W_p}  L_xm6={L_p}
.param W_xm7={W_p}  L_xm7={L_p}
.param W_xm8={W_p}  L_xm8={L_p}
.param W_xm9={W_p}  L_xm9={L_p}
.param W_xm10={W_p} L_xm10={L_p}
.param W_xm11={W_p} L_xm11={L_p}
.param W_xm12={W_n} L_xm12={L_n}
.param W_xm13={W_n} L_xm13={L_n}
.param W_xm14={W_n} L_xm14={L_n}
.param W_xm15={W_n} L_xm15={L_n}
.param W_xm16={W_n} L_xm16={L_n}
.param W_xm17={W_n} L_xm17={L_n}
.param W_xm18={W_n} L_xm18={L_n}
.param W_xm19={W_n} L_xm19={L_n}
.param W_xm20={W_n} L_xm20={L_n}
.param W_xm21={W_p} L_xm21={L_p}
.param W_xm22={W_p} L_xm22={L_p}
.param W_xm23={W_n} L_xm23={L_n}
.param W_xm24={W_n} L_xm24={L_n}
.param W_xm25={W_p} L_xm25={L_p}
.param W_xm26={W_p} L_xm26={L_p}
.param W_xm27={W_n} L_xm27={L_n}
.param W_xm28={W_n} L_xm28={L_n}

* Subcircuit bias generator parameters
.param W_xmsu1={W_n} L_xmsu1={L_n}
.param W_xmsu2={W_p} L_xmsu2={L_p}
.param W_xmsu3={W_n} L_xmsu3={L_n}
.param W_xma3={W_p}  L_xma3={L_p}
.param W_xma4={W_p}  L_xma4={L_p}

* Power Supplies
VDD VDD 0 1.8
VCM VCM 0 0.5

* Differential pulse inputs swinging 300mV to 700mV around 500mV
V_vid vid 0 DC 0 AC 1 PULSE(0.4 -0.4 5n 0.1n 0.1n 40n 80n)
E_vip vip VCM vid 0 0.5
E_vim vim VCM vid 0 -0.5

* Bias Circuit (Fig. 26.3)
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

X_U1 Vbiasn Vbiasp VDD 0 SUB_1

* Op-Amp Core (Fig. 26.22)
xm2 N001 N001 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 N001 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N001 Vbiasn N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 vodm Vbiasn N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm6 N001 Vbiasn N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 vodp Vbiasn N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm11 N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 vodp N001 ncr 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 vodm N001 ncl 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm5 N008 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm14 N008 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N007 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm16 N007 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 ncr Vm N007 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 ncl Vp N007 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N005 Vp N008 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N006 Vm N008 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}

* Output Stage
xm21 vom vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 N010 vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}
xm23 vom N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 N010 N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
C1 vom ncr 5e-14
xm25 vop vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm25} l={L_xm25}
xm26 N009 vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm26} l={L_xm26}
xm27 vop N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm27} l={L_xm27}
xm28 N009 N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm28} l={L_xm28}
C2 vop ncl 5e-14

* Closed-loop Feedback (Fig. 26.24)
R1 vop vm 20000.0
R2 vm vip 20000.0
R3 vom vp 20000.0
R4 vp vim 20000.0
C3 vom 0 2.5e-13
C4 vop 0 2.5e-13

* Control Block for ngspice
.control
* 1. Operating Point Analysis
op
let quiescent_current = -i(VDD)
let quiescent_power = quiescent_current * 1.8
print quiescent_current
print quiescent_power

* 2. DC Analysis for Gains
dc V_vid -0.5 0.5 0.001
let v_op_in = v(vp) - v(vm)
let vod_1st = v(vodp) - v(vodm)
let vod = v(vop) - v(vom)

let d_vod = deriv(vod)
let d_v_op_in = deriv(v_op_in)
let d_vod_1st = deriv(vod_1st)

let open_loop_gain_vec = d_vod / (d_v_op_in + 1e-15)
let first_stage_gain_vec = d_vod_1st / (d_v_op_in + 1e-15)
let second_stage_gain_vec = d_vod / (d_vod_1st + 1e-15)

meas dc open_loop_gain find open_loop_gain_vec at=0
meas dc first_stage_gain find first_stage_gain_vec at=0
meas dc second_stage_gain find second_stage_gain_vec at=0
print open_loop_gain first_stage_gain second_stage_gain

* 3. Transient Analysis
tran 0.05n 90n 0n
let vod = v(vop) - v(vom)
let vid = v(vip) - v(vim)
let v_op_in = v(vp) - v(vm)

* Differential output swing
meas tran v_max max vod from=0n to=90n
meas tran v_min min vod from=0n to=90n
let differential_output_swing = v_max - v_min
print differential_output_swing

* Closed-loop gain
meas tran vod_initial find vod at=4.9n
meas tran vod_final find vod at=44.9n
meas tran vid_initial find vid at=4.9n
meas tran vid_final find vid at=44.9n
let closed_loop_gain = (vod_final - vod_initial) / (vid_final - vid_initial)
print closed_loop_gain

* Slew rate
let dvod_dt = deriv(vod)
let dvod_dt_abs = abs(dvod_dt)
meas tran sr_max max dvod_dt_abs from=5n to=15n
let slew_rate = sr_max / 1e6
print slew_rate

* Settling time
let vod_step = vod_final - vod_initial + 1e-15
let vod_norm = (vod - vod_initial) / vod_step
let vod_error = abs(vod_norm - 1)
meas tran t_settle_cross when vod_error=0.01 fall=last from=5n to=45n
let settling_time = t_settle_cross - 5e-9
print settling_time

* Input RC time constant
meas tran v_op_in_initial find v_op_in at=4.9n
meas tran v_op_in_final find v_op_in at=44.9n
let v_op_in_step = v_op_in_final - v_op_in_initial + 1e-15
let v_op_in_norm = (v_op_in - v_op_in_initial) / v_op_in_step
meas tran t_rc when v_op_in_norm=0.632 rise=1 from=5n to=45n
let input_rc_time_constant = t_rc - 5e-9
print input_rc_time_constant

quit
.endc
.end