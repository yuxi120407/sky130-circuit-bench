* Testbench for Fig. 26.25 Switched-Capacitor Sample-and-Hold Circuit
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
.param L_xm30=0.5
.param L_xm32=0.5
.param L_xm34=0.5
.param L_xm36=0.5
.param L_xm38=0.5
.param L_xm4=0.5
.param L_xm40=0.5
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

* Default transistor dimensions matching 10/1 NMOS and 20/1 PMOS (L=1.0)
.param L_default=1.0
.param W_nmos=10.0
.param W_pmos=20.0

* Param definitions for DUT instances
.param W_xm1=W_nmos L_xm1=L_default
.param W_xm2=W_nmos L_xm2=L_default
.param W_xm3=W_pmos L_xm3=L_default
.param W_xm4=W_pmos L_xm4=L_default
.param W_xm5=W_nmos L_xm5=L_default
.param W_xm6=W_pmos L_xm6=L_default
.param W_xm7=W_pmos L_xm7=L_default
.param W_xm8=W_pmos L_xm8=L_default
.param W_xm9=W_pmos L_xm9=L_default
.param W_xm10=W_pmos L_xm10=L_default
.param W_xm11=W_pmos L_xm11=L_default
.param W_xm12=W_nmos L_xm12=L_default
.param W_xm13=W_nmos L_xm13=L_default
.param W_xm14=W_nmos L_xm14=L_default
.param W_xm15=W_nmos L_xm15=L_default
.param W_xm16=W_nmos L_xm16=L_default
.param W_xm17=W_nmos L_xm17=L_default
.param W_xm18=W_nmos L_xm18=L_default
.param W_xm19=W_nmos L_xm19=L_default
.param W_xm20=W_nmos L_xm20=L_default
.param W_xm21=W_pmos L_xm21=L_default
.param W_xm22=W_pmos L_xm22=L_default
.param W_xm23=W_nmos L_xm23=L_default
.param W_xm24=W_nmos L_xm24=L_default
.param W_xm25=W_pmos L_xm25=L_default
.param W_xm26=W_pmos L_xm26=L_default
.param W_xm27=W_nmos L_xm27=L_default
.param W_xm28=W_nmos L_xm28=L_default
.param W_xm30=W_nmos L_xm30=L_default
.param W_xm32=W_nmos L_xm32=L_default
.param W_xm34=W_nmos L_xm34=L_default
.param W_xm36=W_nmos L_xm36=L_default
.param W_xm38=W_nmos L_xm38=L_default
.param W_xm40=W_nmos L_xm40=L_default
.param W_xm42=W_nmos L_xm42=L_default
.param W_xm44=W_nmos L_xm44=L_default

* SUB_1 Bias circuit parameters
.param W_xmsu1=W_nmos L_xmsu1=L_default
.param W_xmsu2=W_pmos L_xmsu2=L_default
.param W_xmsu3=W_nmos L_xmsu3=L_default
.param W_xma3=W_pmos L_xma3=L_default
.param W_xma4=W_pmos L_xma4=L_default

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_pmos} l={L_default}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_pmos} l={L_default}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_nmos} l={L_default}
  R1 N004 0 4k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_nmos} l={L_default}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_pmos} l={L_default}
  xm2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_nmos} l={L_default}
  xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_nmos} l={L_default}
.ends SUB_1

* DUT: Sample-and-Hold Circuit (Fig. 26.25)
VDD VDD 0 1.8
xm2 N001 N001 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 N001 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
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
xm5 N009 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm14 N009 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N008 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm16 N008 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 ncr Vm N008 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 ncl Vp N008 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N005 Vp N009 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N006 Vm N009 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}
xm21 vom vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 N012 vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}
xm23 vom N012 0 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 N012 N012 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
C1 vom ncr 5e-14
xm25 vop vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm25} l={L_xm25}
xm26 N011 vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm26} l={L_xm26}
xm27 vop N011 0 0 sky130_fd_pr__nfet_01v8 w={W_xm27} l={L_xm27}
xm28 N011 N011 0 0 sky130_fd_pr__nfet_01v8 w={W_xm28} l={L_xm28}
C2 vop ncl 5e-14
xm30 vinp phi2 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm30} l={L_xm30}
C3 N007 Vm 2.5e-13
xm32 vinm phi2 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm32} l={L_xm32}
C4 N010 Vp 2.5e-13
xm34 N007 phi3 Vop 0 sky130_fd_pr__nfet_01v8 w={W_xm34} l={L_xm34}
xm36 N010 phi3 Vom 0 sky130_fd_pr__nfet_01v8 w={W_xm36} l={L_xm36}
xm38 Vm phi1 Vop 0 sky130_fd_pr__nfet_01v8 w={W_xm38} l={L_xm38}
xm40 Vp phi1 Vom 0 sky130_fd_pr__nfet_01v8 w={W_xm40} l={L_xm40}
xm42 Vop phi3 Voutp 0 sky130_fd_pr__nfet_01v8 w={W_xm42} l={L_xm42}
xm44 Vom phi3 voutm 0 sky130_fd_pr__nfet_01v8 w={W_xm44} l={L_xm44}
C5 Voutp 0 2.5e-13
C6 voutm 0 2.5e-13

* Signal inputs: 5 MHz differential sine wave around VCM = 500 mV
Vin_diff_p vinp VCM sin(0 0.1 5meg)
Vin_diff_m vinm VCM sin(0 -0.1 5meg)

* Non-overlapping 3-phase clocks (50 MHz, T = 20 ns)
Vphi1 phi1 0 pulse(0 1.8 0.2n 0.1n 0.1n 7.5n 20n)
Vphi2 phi2 0 pulse(0 1.8 0.2n 0.1n 0.1n 8.2n 20n)
Vphi3 phi3 0 pulse(0 1.8 10.2n 0.1n 0.1n 8.5n 20n)

* Added for AC open-loop gain measurement and OP startup
.options gmin=1e-12
.nodeset v(X_U1.Vbiasn)=0.7 v(X_U1.Vbiasp)=1.1
I_bias_m 0 Vm dc 0.5p ac 1
I_bias_p 0 Vp dc 0.5p ac -1

.control
op
let quiescent_current = -i(vdd)
print quiescent_current

tran 100p 200n
let vcm_out = 0.5 * (v(vop) + v(vom))
meas tran vcm_start find vcm_out at=15n
meas tran vcm_end find vcm_out at=190n
let output_cm_wandering = vcm_start - vcm_end
let output_cm_offset = vcm_start - 0.5
print output_cm_wandering output_cm_offset

let dvop = deriv(v(vop))
meas tran sr_min min dvop from=10.5n to=15n
let slew_rate = abs(sr_min) / 1e6
print slew_rate

ac dec 10 1 100
let gain_mag = (v(vop) - v(vom)) / (v(Vm) - v(Vp))
let gain_db = db(gain_mag)
meas ac open_loop_gain find gain_db at=1
print open_loop_gain

quit
.endc
.end