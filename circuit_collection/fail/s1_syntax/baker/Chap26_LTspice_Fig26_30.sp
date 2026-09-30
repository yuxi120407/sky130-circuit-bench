* Testbench for Baker Fig. 26.29 Two-Stage Op-Amp with CMFB
.lib "/home/user/sky130_pdk/libraries/sky130_fd_pr/latest/models/sky130.lib.spice" tt
.param L_nmos=0.5
.param L_out_n=0.5
.param L_out_p=0.5
.param L_pmos=0.5
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

* Parameter definitions for transistors based on Fig. 26.29 W/L
.param W_nmos=10.0 L_nmos=1.0
.param W_pmos=20.0 L_pmos=1.0
.param W_out_p=40.0 L_out_p=1.0
.param W_out_n=20.0 L_out_n=1.0

.param W_xm1={W_nmos} L_xm1={L_nmos}
.param W_xm2={W_nmos} L_xm2={L_nmos}
.param W_xm3={W_pmos} L_xm3={L_pmos}
.param W_xm4={W_pmos} L_xm4={L_pmos}
.param W_xm5={W_nmos} L_xm5={L_nmos}
.param W_xm6={W_pmos} L_xm6={L_pmos}
.param W_xm7={W_pmos} L_xm7={L_pmos}
.param W_xm8={W_pmos} L_xm8={L_pmos}
.param W_xm9={W_pmos} L_xm9={L_pmos}
.param W_xm10={W_pmos} L_xm10={L_pmos}
.param W_xm11={W_pmos} L_xm11={L_pmos}
.param W_xm12={W_nmos} L_xm12={L_nmos}
.param W_xm13={W_nmos} L_xm13={L_nmos}
.param W_xm14={W_nmos} L_xm14={L_nmos}
.param W_xm15={W_nmos} L_xm15={L_nmos}
.param W_xm16={W_nmos} L_xm16={L_nmos}
.param W_xm17={W_nmos} L_xm17={L_nmos}
.param W_xm18={W_nmos} L_xm18={L_nmos}
.param W_xm19={W_nmos} L_xm19={L_nmos}
.param W_xm20={W_nmos} L_xm20={L_nmos}
.param W_xm21={W_out_p} L_xm21={L_out_p}
.param W_xm22={W_out_p} L_xm22={L_out_p}
.param W_xm23={W_out_n} L_xm23={L_out_n}
.param W_xm24={W_out_n} L_xm24={L_out_n}
.param W_xm25={W_out_p} L_xm25={L_out_p}
.param W_xm26={W_out_p} L_xm26={L_out_p}
.param W_xm27={W_out_n} L_xm27={L_out_n}
.param W_xm28={W_out_n} L_xm28={L_out_n}
.param W_xm29={W_pmos} L_xm29={L_pmos}
.param W_xm30={W_nmos} L_xm30={L_nmos}
.param W_xm31={W_nmos} L_xm31={L_nmos}
.param W_xm32={W_pmos} L_xm32={L_pmos}
.param W_xm33={W_pmos} L_xm33={L_pmos}

* Bias circuit parameters (Fig. 26.3)
.param W_xmsu1={W_nmos} L_xmsu1={L_nmos}
.param W_xmsu2={W_pmos} L_xmsu2={L_pmos}
.param W_xmsu3={W_pmos} L_xmsu3={L_pmos}
.param W_xma3={W_pmos} L_xma3={L_pmos}
.param W_xma4={W_pmos} L_xma4={L_pmos}

* DUT Circuit Description
VDD VDD 0 1.8
xm2 N001 N001 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 N001 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N001 Vbiasn N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 vodm Vbiasn N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
VCM VCM 0 500m
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
xm22 N010 vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}
xm23 vom N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 N010 N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
C1 vom ncr 5e-14
xm25 vop vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm25} l={L_xm25}
xm26 N009 vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm26} l={L_xm26}
xm27 vop N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm27} l={L_xm27}
xm28 N009 N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm28} l={L_xm28}
C2 vop ncl 5e-14
Vp Vp 0 500m AC 1
R1 vop vcma 20000.0
R2 vcma vom 20000.0
C3 vop vcma 1e-14
C4 vcma vom 1e-14
xm29 N008 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm29} l={L_xm29}
xm30 VCMFB N011 0 0 sky130_fd_pr__nfet_01v8 w={W_xm30} l={L_xm30}
xm31 N011 N011 0 0 sky130_fd_pr__nfet_01v8 w={W_xm31} l={L_xm31}
xm32 N011 vcma N008 VDD sky130_fd_pr__pfet_01v8 w={W_xm32} l={L_xm32}
xm33 VCMFB VCM N008 VDD sky130_fd_pr__pfet_01v8 w={W_xm33} l={L_xm33}

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

* Simulation control script
.control
* 1. Operating Point analysis
op
let i_supply = -i(VDD)
let p_diss = i_supply * 1.8
let vocm_op = (v(vop) + v(vom)) / 2
print i_supply p_diss vocm_op v(VCMFB)

* 2. DC Sweep analysis (matches Baker's simulation: sweep Vp around 500 mV)
dc Vp 480m 520m 0.1m
let vdiff_out = v(vop) - v(vom)
let gain_deriv = deriv(vdiff_out)
let max_gain = vecmax(gain_deriv)
let vop_max = vecmax(v(vop))
let vop_min = vecmin(v(vop))
let vom_max = vecmax(v(vom))
let vom_min = vecmin(v(vom))
let swing_vop = vop_max - vop_min

meas dc max_diff_gain max gain_deriv
meas dc v_out_cm find v(vop) when v(vop)=v(vom)
meas dc vop_high max v(vop)
meas dc vop_low min v(vop)

print max_diff_gain v_out_cm swing_vop

* 3. AC frequency response analysis
ac dec 20 100 1G
let diff_gain_db = vdb(vop, vom)
let phase_deg = 180/PI * cph(v(vop) - v(vom))
meas ac dc_gain_db find diff_gain_db at=1k
meas ac ugbw when diff_gain_db=0 fall=1
meas ac pm find phase_deg when diff_gain_db=0 fall=1

print dc_gain_db ugbw pm
quit
.endc
.end
