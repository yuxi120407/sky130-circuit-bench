* Injection-Locked Frequency Divider Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM1 N0 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 LABEL_NET_0 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 LABEL_NET_2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

VVDD VDD 0 1.8
* Bias voltages for PMOS active loads to tune free-running frequency
V_bias1 LABEL_NET_1 0 0.4
V_bias2 N1 0 0.4
* Injection signal at 4.3 GHz
V_inj LABEL_NET_2 0 dc 0.9 sin(0.9 0.9 4.3G)
* Pull-up resistor for open-drain output buffer
R_out VDD LABEL_NET_0 1k

* Initial conditions to kickstart the ring oscillator
.ic v(N0)=1.8 v(N3)=0 v(N4)=1.8

.control
tran 10p 20n

* Measure Power Consumption
meas tran pwr avg i(VVDD) from=10n to=20n
let power_mw = -pwr * 1.8 * 1000
print power_mw

* Measure Output Frequency
meas tran t1 trig v(LABEL_NET_0) val=0.9 rise=10 targ v(LABEL_NET_0) val=0.9 rise=11
let fout = 1 / t1
print fout

* Measure Input Frequency
meas tran t_in trig v(LABEL_NET_2) val=0.9 rise=10 targ v(LABEL_NET_2) val=0.9 rise=11
let fin = 1 / t_in
print fin

* Calculate Division Ratio
let div_ratio = fin / fout
print div_ratio

quit
.endc
.end