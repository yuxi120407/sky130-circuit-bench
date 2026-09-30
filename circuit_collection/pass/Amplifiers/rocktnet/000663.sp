* Class-D Output Stage Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM1 N0 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_2 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_7 LABEL_NET_6 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

* Supplies
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8
VLABEL_NET_6 LABEL_NET_6 0 1.8

* PWM Inputs (1MHz)
V_H1 LABEL_NET_7 0 PULSE(0 1.8 0 1n 1n 490n 1u)
V_L1 LABEL_NET_0 0 PULSE(0 1.8 0 1n 1n 490n 1u)
V_H2 LABEL_NET_2 0 PULSE(1.8 0 0 1n 1n 490n 1u)
V_L2 LABEL_NET_3 0 PULSE(1.8 0 0 1n 1n 490n 1u)

* Load
Rload N0 N1 1k
Cload N0 N1 10p

.control
tran 1n 5u

* Calculate instantaneous power
let p_load = (v(N0)-v(N1))*(v(N0)-v(N1))/1000
let p_vdd = (-i(VVDD) - i(VLABEL_NET_1) - i(VLABEL_NET_6))*1.8

* Measure average power and efficiency
meas tran output_power avg p_load from=2u to=4u
meas tran p_vdd_avg avg p_vdd from=2u to=4u
let efficiency = (output_power / p_vdd_avg) * 100

* Measure switching frequency
meas tran t_period trig v(LABEL_NET_7) val=0.9 rise=1 targ v(LABEL_NET_7) val=0.9 rise=2 from=2u to=4u
let switching_frequency = 1 / t_period

* Measure rise time (adapting to actual voltage swing due to undersized transistors)
meas tran vmin min v(N0) from=2u to=4u
meas tran vmax max v(N0) from=2u to=4u
let v20 = vmin + 0.2*(vmax - vmin)
let v80 = vmin + 0.8*(vmax - vmin)
meas tran rise_time trig v(N0) val=$&v20 rise=1 targ v(N0) val=$&v80 rise=1 from=2u to=4u

print efficiency output_power switching_frequency rise_time

quit
.endc
.end