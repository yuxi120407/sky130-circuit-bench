* Fully Differential Current-Mirror OTA Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm5=5.0 L_xm5=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5

* DUT
XM5 N1 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM4 OUTN LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM7 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM2 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 N2 INN N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM6 OUTP N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM3 OUTN N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM8 OUTP LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 INP N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}

* Power Supply
VVDD VDD 0 1.8

* Tail Bias (~20uA)
VLABEL_NET_0 LABEL_NET_0 0 1.1

* Ideal CMFB for Load Bias (Stabilizes output common-mode to 0.9V)
B_SUM OUT_SUM 0 V=V(OUTP)+V(OUTN)
V_REF VCM_REF 0 1.8
B_CMFB1 LABEL_NET_1 0 V=1.18 + 10*(V(OUT_SUM) - V(VCM_REF))
B_CMFB3 LABEL_NET_3 0 V=1.18 + 10*(V(OUT_SUM) - V(VCM_REF))

* Inputs (DC=0.9V, AC=1V diff, Pulse for Slew Rate)
VINP INP 0 DC 0.9 AC 0.5 PULSE(0.9 1.4 10n 1n 1n 5u 10u)
VINN INN 0 DC 0.9 AC -0.5 PULSE(0.9 0.4 10n 1n 1n 5u 10u)

* Load Capacitors
CL1 OUTP 0 1p
CL2 OUTN 0 1p

* Differential Output
B_OUT_DIFF OUT_DIFF 0 V=V(OUTP)-V(OUTN)

.control
* 1. DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* 2. AC Analysis (Gain, UGBW, Phase Margin)
ac dec 100 1 1G
let gain_db = vdb(OUT_DIFF)
let phase = 180/PI * cph(v(OUT_DIFF))
meas ac dc_gain find gain_db at=10
meas ac ugbw when gain_db=0 fall=1
meas ac phase_at_ugbw find phase when gain_db=0 fall=1
let pm = 180 + phase_at_ugbw
print dc_gain ugbw pm

* 3. Transient Analysis (Slew Rate)
tran 10n 10u
* Measure time for a 1V differential change (0.1V to 1.1V) to avoid railing issues
meas tran t_rise trig v(OUT_DIFF) val=0.1 rise=1 targ v(OUT_DIFF) val=1.1 rise=1
let sr_rise_vus = (1.0 / t_rise) * 1e-6
meas tran t_fall trig v(OUT_DIFF) val=1.1 fall=1 targ v(OUT_DIFF) val=0.1 fall=1
let sr_fall_vus = (1.0 / t_fall) * 1e-6
print sr_rise_vus sr_fall_vus

quit
.endc
.end
