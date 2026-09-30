* CML D-Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic NPN model since SKY130 NPNs are subcircuits and netlist uses Q instances
.model npn NPN(IS=1e-16 BF=100 VAF=50 CJC=10f CJE=20f TF=10p TR=1n)

* DUT (with added resistor values for simulation)
Q1 N4 N5 N3 npn
Q2 N12 N14 N3 npn
R1 Q_P N6 1k
Q3 N14 N14 N9 npn
Q4 VDD N1 Q_N npn
Q5 VDD Clk_N N14 npn
Q6 N6 N6 GND npn
Q7 N1 D_P N4 npn
Q8 N1 Q_P N12 npn
R2 Q_N N6 1k
R3 N7 VDD 500
R4 N1 VDD 500
Q9 N9 N6 GND npn
Q10 N7 D_N N4 npn
Q11 N7 Q_N N12 npn
Q12 N5 N5 N13 npn
Q13 VDD Clk_P N5 npn
Q14 N3 N6 GND npn
Q15 N13 N6 GND npn
Q16 VDD N7 Q_P npn

* Sources
VVDD VDD GND 1.8
* Clock: 1 GHz, 1.7V common mode to keep input transistors out of saturation
Vclk_p Clk_P GND dc 1.7 pulse(1.6 1.8 0 10p 10p 490p 1n)
Vclk_n Clk_N GND dc 1.7 pulse(1.8 1.6 0 10p 10p 490p 1n)
* Data: 500 MHz, transitions during the clock high (track) phase
Vd_p D_P GND dc 1.7 pulse(1.6 1.8 250p 10p 10p 0.99n 2n)
Vd_n D_N GND dc 1.7 pulse(1.8 1.6 250p 10p 10p 0.99n 2n)

.control
tran 5p 3n

* Power
meas tran I_vdd avg i(VVDD)
let power_consumption = -I_vdd * 1.8

* Swing
meas tran V_QP_max max v(Q_P) from=1n to=3n
meas tran V_QP_min min v(Q_P) from=1n to=3n
let voltage_swing = V_QP_max - V_QP_min

* Delay (Data to Output during track phase)
* Output common mode settles around 0.93V with these resistor values
meas tran delay_rise trig v(D_P) val=1.7 rise=1 td=200p targ v(Q_P) val=0.93 rise=1 td=200p
meas tran delay_fall trig v(D_P) val=1.7 fall=1 td=1.2n targ v(Q_P) val=0.93 fall=1 td=1.2n
let propagation_delay = (delay_rise + delay_fall) / 2

print power_consumption
print voltage_swing
print propagation_delay

quit
.endc
.end