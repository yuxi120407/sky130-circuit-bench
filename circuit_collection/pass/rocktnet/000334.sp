* Fully Symmetric OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1_1=0.5
.param L_xm1_2=0.5
.param L_xm1_n=0.5
.param L_xm2_1=0.5
.param L_xm2_2=0.5
.param L_xm2_n=0.5
.param L_xm3=0.5
.param L_xm3_n=0.5

* Note: W_xm3_n is set to 2.5u (half of W_xm3) so the replica branch carries I_tail/2.
* This current is mirrored 1:1 by the PMOS loads (XM2_1, XM2_2), perfectly balancing
* the differential pair which sinks I_tail/2 per branch.
.param W_xm1_n=5.0 L_xm1_n=0.5
.param W_xm3_n=2.5 L_xm3_n=0.5
.param W_xm1_2=5.0 L_xm1_2=0.5
.param W_xm1_1=5.0 L_xm1_1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2_2=5.0 L_xm2_2=0.5
.param W_xm2_n=5.0 L_xm2_n=0.5
.param W_xm2_1=5.0 L_xm2_1=0.5

VVDD VDD 0 1.8
VBIAS1 BIAS1 0 0.8

* DUT
XM1_N N2 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1_n} w={W_xm1_n}
XM3_N N1 BIAS1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3_n} w={W_xm3_n}
XM1_2 VOUT_PLUS VIN_MINUS N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1_2} w={W_xm1_2}
XM1_1 VOUT_MINUS VIN_PLUS N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1_1} w={W_xm1_1}
XM3 N4 BIAS1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2_2 VOUT_PLUS N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2_2} w={W_xm2_2}
XM2_N N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2_n} w={W_xm2_n}
XM2_1 VOUT_MINUS N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2_1} w={W_xm2_1}

* DC bias for inputs
E_bias VCM 0 N2 0 1.0

* Input sources
V_IN_P VIN_PLUS VCM DC 0 AC 0.5 PULSE(-0.5 0.5 1n 10p 10p 10n 20n)
V_IN_M VIN_MINUS VCM DC 0 AC -0.5 PULSE(0.5 -0.5 1n 10p 10p 10n 20n)

* Load capacitance
CL1 VOUT_PLUS 0 100f
CL2 VOUT_MINUS 0 100f

* Differential output
E_diff VOUT_DIFF 0 VOUT_PLUS VOUT_MINUS 1

.control
op
let Power_Consumption = -i(VVDD) * 1.8
print Power_Consumption

ac dec 100 1k 10Gig
let gain_db = vdb(VOUT_DIFF)
let phase = 180/PI * vp(VOUT_DIFF)
meas ac DC_Gain max gain_db
meas ac GBW when gain_db=0 fall=1
meas ac phase_at_gbw find phase when gain_db=0 fall=1
let Phase_Margin = phase_at_gbw + 180
print Phase_Margin

tran 10p 40n
meas tran t1_r when v(VOUT_DIFF)=-0.2 rise=1
meas tran t2_r when v(VOUT_DIFF)=0.2 rise=1
let sr_rise = 0.4 / (t2_r - t1_r) / 1e6

meas tran t1_f when v(VOUT_DIFF)=0.2 fall=1
meas tran t2_f when v(VOUT_DIFF)=-0.2 fall=1
let sr_fall = 0.4 / (t2_f - t1_f) / 1e6

let Slew_Rate = (sr_rise + sr_fall) / 2
print Slew_Rate
quit
.endc
.end