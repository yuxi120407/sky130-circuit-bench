* Pre-amplifier Testbench
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
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5

XM1 VB3 N_CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_FOLD1 N_CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VON VON N_FOLD1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N_FOLD2 VB3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_FOLD1 VB3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N_CMFB VCM N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N_CASC_P1 VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N_CMFB N_CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N7 VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 VON VON N_CASC_P1 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N_CMFB N_CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 VB3 N_CMFB N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N_FOLD1 VIP N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 VOP VOP N_FOLD2 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N_CASC_P2 VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N_TAIL VB2 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N_CMFB VCM N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm17} w={W_xm17}
XM18 VOP VOP N_CASC_P2 VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}

* DC Sources
VVDD VDD 0 1.8
VVB1 VB1 0 0.8
VVB2 VB2 0 0.4

* Input Signal
VVCM VCM 0 0.9
EVIP VIP_DC 0 VCM 0 1.0
VVIP VIP VIP_DC dc 0 ac 1 pulse(0 0.2 10u 1n 1n 5u 20u)

* Load Capacitors
C1 VON 0 50f
C2 VOP 0 50f

.control
* 1. Find the correct VCM to balance the amplifier
dc VVCM 0.2 1.4 0.001
meas dc vcm_target WHEN v(VOP)=0.9 CROSS=1
alter VVCM $&vcm_target

* 2. DC Operating Point
op
let power = -i(VVDD) * 1.8
print power
print v(VON) v(VOP) v(VB3) v(N_CMFB) v(VCM)

* 3. AC Analysis
ac dec 100 1 10G
let gain_db = db(v(VON))
meas ac dc_gain max gain_db
let gain_3db = $&dc_gain - 3
meas ac bw when gain_db=$&gain_3db fall=1
print dc_gain bw

* 4. Transient Analysis
tran 10n 20u
meas tran v_out_max max v(VON) from=9u to=20u
meas tran v_out_min min v(VON) from=9u to=20u
let v_out_pp = $&v_out_max - $&v_out_min
print v_out_pp

quit
.endc
.end