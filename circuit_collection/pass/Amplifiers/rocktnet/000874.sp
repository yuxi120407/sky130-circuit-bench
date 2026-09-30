* Testbench for 5T OTA
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm3=5.0 L_xm3=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm2=5.0 L_xm2=0.5

* Global Sources
VVDD VDD 0 1.8
VPCHB PCHB 0 0.6

* ==========================================
* DUT 1: Open Loop (Gain, Phase Margin)
* ==========================================
XM3 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM1 N2 V_PLUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM5 N1 PCHB GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM4 VO N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM2 VO V_MINUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

V_IN_CM V_CM 0 0.9
V_IN_AC V_PLUS V_CM dc 0 ac 1
L1 VO V_MINUS 1G
C1 V_MINUS V_CM 1G
CL VO 0 1p

* ==========================================
* DUT 2: Common Mode (CMRR)
* ==========================================
XM3_C N2_C N2_C VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM1_C N2_C V_PLUS_C N1_C GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM5_C N1_C PCHB GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM4_C VO_C N2_C VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM2_C VO_C V_MINUS_C N1_C GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

V_IN_CM_C V_CM_C 0 dc 0.9 ac 1
V_IN_AC_C V_PLUS_C V_CM_C dc 0 ac 0
L1_C VO_C V_MINUS_C 1G
C1_C V_MINUS_C V_CM_C 1G
CL_C VO_C 0 1p

* ==========================================
* DUT 3: Transient (Slew Rate)
* ==========================================
XM3_T N2_T N2_T VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM1_T N2_T V_PLUS_T N1_T GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM5_T N1_T PCHB GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM4_T VO_T N2_T VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM2_T VO_T VO_T N1_T GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

V_IN_T V_PLUS_T 0 PULSE(0.4 1.4 1n 100p 100p 1u 2u)
CL_T VO_T 0 1p

* ==========================================
* Control Block
* ==========================================
.control
* 1. DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* 2. AC Analysis (Gain, UGBW, PM, CMRR)
ac dec 100 1 1G
let gain_db = vdb(VO)
let phase = 180/PI * cph(v(VO))
meas ac dc_gain find gain_db at=10
meas ac ugbw when gain_db=0 fall=1
meas ac phase_at_ugbw find phase when gain_db=0 fall=1
let pm = phase_at_ugbw + 180
print pm

let cmrr_db = vdb(VO) - vdb(VO_C)
meas ac cmrr_dc find cmrr_db at=10

* 3. Transient Analysis (Slew Rate)
tran 1n 3u
meas tran t_rise trig v(VO_T) val=0.6 rise=1 targ v(VO_T) val=1.2 rise=1
meas tran t_fall trig v(VO_T) val=1.2 fall=1 targ v(VO_T) val=0.6 fall=1
let sr_rise = 0.6 / t_rise
let sr_fall = 0.6 / t_fall
print sr_rise sr_fall

quit
.endc
.end
