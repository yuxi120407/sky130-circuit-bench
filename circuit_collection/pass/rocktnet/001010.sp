* Dynamic Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

* DUT
XM1 Q Q_BAR N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 Q CLK GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 Q_BAR CLK GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 Q_BAR D N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 Q D_BAR N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 Q_BAR Q N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

* Added PMOS header to complete the circuit (N2 to VDD gated by CLK)
XM7 N2 CLK VDD VDD sky130_fd_pr__pfet_01v8 l=0.5 w=5.0

* Power Supply
VVDD VDD 0 1.8

* Clock Signal (Active Low for evaluation)
* Period = 20ns, Fall at 2ns, Rise at 12.5ns, Fall at 22ns, Rise at 32.5ns
VCLK CLK 0 PULSE(1.8 0 2n 0.5n 0.5n 10n 20n)

* Differential Inputs (Common mode = 0.9V)
* Cycle 1 (2n-12.5n): D=0.8V, D_BAR=1.0V -> Q_BAR goes high
* Cycle 2 (22n-32.5n): D=1.0V, D_BAR=0.8V -> Q goes high
VD D 0 PWL(0 0.8 18n 0.8 19n 1.0)
VDBAR D_BAR 0 PWL(0 1.0 18n 1.0 19n 0.8)

* Load Capacitors
C1 Q 0 10f
C2 Q_BAR 0 10f

.control
tran 10p 40n

* Measure Delay (CLK fall to Output rise)
meas tran delay trig v(CLK) val=0.9 fall=1 targ v(Q_BAR) val=0.9 rise=1
print delay

* Measure Voltage Swing
meas tran v_max_q max v(Q)
meas tran v_min_q min v(Q)
let voltage_swing = v_max_q - v_min_q
print voltage_swing

* Measure Energy per Operation
* Integrate current from VDD over two cycles (0 to 40ns)
meas tran q_total integ i(VVDD) from=0 to=40n
let energy_total = -q_total * 1.8
let energy_per_op = energy_total / 2
print energy_per_op

quit
.endc
.end