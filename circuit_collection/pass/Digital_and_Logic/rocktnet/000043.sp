* DyCML Evaluation Tree Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N2 LABEL_NET_0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 LABEL_NET_1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

VDD VDD 0 1.8
R1 VDD N2 1k
R2 VDD N3 1k

* Clock signal on tail (500 MHz, 0.9V reduced swing)
VCLK LABEL_NET_2 0 PULSE(0 0.9 0 50p 50p 0.95n 2n)

* Differential inputs
VINP LABEL_NET_0 0 PULSE(1.5 1.8 0.2n 50p 50p 2n 4n)
VINN LABEL_NET_1 0 PULSE(1.8 1.5 0.2n 50p 50p 2n 4n)

.control
tran 10p 8n

* Measure voltage swing
meas tran vout_max MAX v(n3) FROM=3.5n TO=5n
meas tran vout_min MIN v(n3) FROM=3.5n TO=5n
let voltage_swing = vout_max - vout_min
print voltage_swing

* Measure delay (CLK to OUT)
* CLK rises at 4ns, N3 evaluates low. Thresholds: CLK 50% (0.45V), OUT 1.75V
meas tran delay TRIG v(LABEL_NET_2) VAL=0.45 RISE=1 FROM=3.5n TARG v(n3) VAL=1.75 FALL=1 FROM=3.5n
print delay

* Measure power
meas tran avg_current AVG i(VDD) FROM=0 TO=8n
let power = -avg_current * 1.8
print power

quit
.endc
.end