* Fully Differential OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5

* DUT
XM1 N0 VCM N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOM N4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N11 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N7 N11 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 VIM N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N7 VIP N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 VOM N8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 VDD VFCM N2 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N6 VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 VOP N8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 VOP N7 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

* Power and Bias
VVDD VDD 0 1.8
VVCM VCM 0 0.9
VN1 N1 0 0
VN11 N11 0 0.61

* Injecting tail currents to bypass off-state transistors in extracted netlist
Itail1 VDD N6 100u
Itail2 N2 0 50u

* Close CMFB loop (connect CMFB output N0 to 2nd stage bias N8)
Vshort N8 N0 0

* CMFB sensing network
Rcm1 VOP VFCM 1Meg
Rcm2 VOM VFCM 1Meg
Ccm1 VOP VFCM 1p
Ccm2 VOM VFCM 1p

* Miller Compensation
Cc1 N4 VOM 1p
Cc2 N7 VOP 1p

* Load Capacitance
CL1 VOP 0 1p
CL2 VOM 0 1p

* Inputs (AC for freq response, Pulse for slew rate)
V_in_cm V_in_cm 0 0.9
V_in_d_p VIP V_in_cm dc 0 ac 0.5 pulse(-0.5 0.5 1n 100p 100p 1u 2u)
V_in_d_m VIM V_in_cm dc 0 ac -0.5 pulse(0.5 -0.5 1n 100p 100p 1u 2u)

.control
* 1. AC Analysis
ac dec 100 1 1G
let vout_diff = v(VOP) - v(VOM)
let gain_db = vdb(vout_diff)
let phase = 180/PI * cph(vout_diff)
meas ac dc_gain find gain_db at=10
meas ac ugbw when gain_db=0 fall=1
meas ac phase_at_ugbw find phase when gain_db=0 fall=1
let phase_margin = phase_at_ugbw + 180
print dc_gain ugbw phase_margin

* 2. Transient Analysis
tran 10p 20n
let vout_diff = v(VOP) - v(VOM)
meas tran t_rise trig vout_diff val=-1 rise=1 targ vout_diff val=1 rise=1
let sr_rise = 2 / t_rise
print sr_rise

* 3. DC Operating Point
op
let power = -i(VVDD) * 1.8
print power

quit
.endc
.end