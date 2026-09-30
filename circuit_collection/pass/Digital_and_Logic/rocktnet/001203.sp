* SLL AND/NAND Gate Testbench
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm6=5.0 L_xm6=0.5

VVDD VDD 0 1.8
I_BIAS VDD N_C 40u

* Pull-up resistors to set 400mV swing (40uA * 10k = 400mV)
R1 VDD P1 10k
R2 VDD P2 10k

* DUT
XM4 P1 IN_L1 N_L_MID GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 N_L_MID IN_L2 N_TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM9 P2 IN_R1 N_TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM2 P2 IN_R2 N_TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_TAIL N_C GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM6 N_C N_C GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Complementary Inputs (Swing 1.4V to 1.8V)
VA IN_L1 0 PULSE(1.4 1.8 1n 50p 50p 2n 4n)
VA_BAR IN_R1 0 PULSE(1.8 1.4 1n 50p 50p 2n 4n)
VB IN_L2 0 PULSE(1.4 1.8 2n 50p 50p 4n 8n)
VB_BAR IN_R2 0 PULSE(1.8 1.4 2n 50p 50p 4n 8n)

* Load Capacitors
C1 P1 0 10f
C2 P2 0 10f

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm6=0.5
.param L_xm9=0.5

.control
tran 10p 10n

* Measure Propagation Delay (4 transitions)
meas tran t_delay_fall1 trig v(IN_L2) val=1.6 rise=1 targ v(P1) val=1.6 fall=1
meas tran t_delay_rise1 trig v(IN_L1) val=1.6 fall=1 targ v(P1) val=1.6 rise=1
meas tran t_delay_fall2 trig v(IN_L1) val=1.6 rise=2 targ v(P1) val=1.6 fall=2
meas tran t_delay_rise2 trig v(IN_L2) val=1.6 fall=1 targ v(P1) val=1.6 rise=2

let t_pd = (t_delay_fall1 + t_delay_rise1 + t_delay_fall2 + t_delay_rise2) / 4
print t_pd

* Measure Average Power
meas tran avg_current avg i(VVDD) from=1n to=7n
let avg_power = -avg_current * 1.8
print avg_power

* Measure Energy per Operation (PDP)
let energy_per_op = avg_power * t_pd
print energy_per_op

* Measure Voltage Swing
meas tran v_max max v(P1) from=2n to=4n
meas tran v_min min v(P1) from=2n to=4n
let v_swing = v_max - v_min
print v_swing

quit
.endc
.end
