* Testbench for Current Comparator
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
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm15=5.0 L_xm15=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm12=5.0 L_xm12=0.5

VVDD VDD 0 3.3

* Input current control voltage
V_CTRL CTRL 0 DC 0 AC 1 PULSE(-50u 50u 10n 1n 1n 500n 1u)
G_IN_PLUS 0 IN_PLUS CTRL 0 0.5
G_IN_MINUS IN_MINUS 0 CTRL 0 0.5

* DUT
XM15 OUT N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM7 N5 IN_PLUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM5 IN_MINUS IN_PLUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM8 N0 IN_MINUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM3 IN_MINUS IN_MINUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM13 N3 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM11 VB VB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM10 N5 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM4 IN_PLUS IN_PLUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 IN_MINUS IN_MINUS VB VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 IN_PLUS IN_PLUS VB VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM9 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM6 IN_PLUS IN_MINUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM14 OUT N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM12 N3 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

.control
op
let Power_Consumption = -i(VVDD) * 3.3
let Supply_Voltage = 3.3
print Power_Consumption
print Supply_Voltage

ac dec 10 1k 100Meg
let v_diff = v(IN_PLUS) - v(IN_MINUS)
let zin_db = db(v_diff)
meas ac Input_Impedance find zin_db at=100k
let gain_db = db(v(N5))
meas ac Transimpedance_Gain find gain_db at=100k

tran 1n 2u
meas tran t_pd_fall trig v(CTRL) val=0 rise=1 targ v(OUT) val=1.65 fall=1
meas tran t_pd_rise trig v(CTRL) val=0 fall=1 targ v(OUT) val=1.65 rise=1
let Propagation_Delay = (t_pd_rise + t_pd_fall) / 2
let Operating_Frequency = 1 / (2 * Propagation_Delay)
print Propagation_Delay
print Operating_Frequency

quit
.endc
.end