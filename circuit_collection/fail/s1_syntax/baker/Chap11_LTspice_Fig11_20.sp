* 9-Stage Tapered CMOS Buffer Driving 20 pF Load (Baker Fig. 11.20)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param W_xm1=5.0
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0

* Scaling parameter for 50nm/Sky130 grid
.param scale=0.15u
.param L_xm1={scale}      W_xm1={10*scale}
.param L_xm2={scale}      W_xm2={20*scale}
.param L_xm3={scale}      W_xm3={27*scale}
.param L_xm4={scale}      W_xm4={54*scale}
.param L_xm5={scale}      W_xm5={74*scale}
.param L_xm6={scale}      W_xm6={148*scale}
.param L_xm7={scale}      W_xm7={200*scale}
.param L_xm8={scale}      W_xm8={400*scale}
.param L_xm9={scale}      W_xm9={546*scale}
.param L_xm10={scale}     W_xm10={1092*scale}
.param L_xm11={scale}     W_xm11={1483*scale}
.param L_xm12={scale}     W_xm12={2967*scale}
.param L_xm13={scale}     W_xm13={4032*scale}
.param L_xm14={scale}     W_xm14={8064*scale}
.param L_xm15={scale}     W_xm15={10960*scale}
.param L_xm16={scale}     W_xm16={21920*scale}
.param L_xm17={scale}     W_xm17={29780*scale}
.param L_xm18={scale}     W_xm18={59570*scale}

* Circuit Netlist (DUT)
xm1 N001 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 N001 Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 N002 N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 N003 N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N003 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 N004 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 N004 N003 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N005 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N005 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm11 N006 N005 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm12 N006 N005 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 N007 N006 0 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm14 N007 N006 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm14} l={L_xm14}
xm15 N008 N007 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm16 N008 N007 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
xm17 Vout N008 0 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 Vout N008 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
Cload Vout 0 2e-11

* Input Stimulus (Pulse with 7ns period as in Baker LTspice)
Vin Vin 0 PULSE(0 1.8 0.5n 50p 50p 3n 7n)

.control
* Run transient analysis
tran 5p 7n

* Measure t_PHL (Vin rise to Vout fall, since 9 inverters invert)
meas tran t_phl trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 fall=1

* Measure t_PLH (Vin fall to Vout rise)
meas tran t_plh trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 rise=1

* Measure output fall time (90% to 10%)
meas tran fall_time trig v(Vout) val=1.62 fall=1 targ v(Vout) val=0.18 fall=1

* Measure output rise time (10% to 90%)
meas tran rise_time trig v(Vout) val=0.18 rise=1 targ v(Vout) val=1.62 rise=1

* Total round-trip delay
let t_prop_total = t_phl + t_plh
print t_prop_total

* Per-stage delay (9 stages, both transitions)
let stage_delay = (t_phl + t_plh) / (2 * 9)
print stage_delay

* Measure average dynamic supply current
meas tran avg_current avg -i(VDD) from=0 to=7n
let dynamic_power = avg_current * 1.8
print dynamic_power

* Power-delay product
let power_delay_product = dynamic_power * t_prop_total
print power_delay_product

quit
.endc
.end