* Latched Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Supply Voltages
VVDD VDD 0 DC 1.8
VVR V_R 0 DC 0.6

* Clocks (1 GHz, Common Mode = 0.9V, Swing = 1.2Vpp diff)
VCLK_P CLK_P 0 DC 0.9 PULSE(0.6 1.2 0 20p 20p 480p 1n)
VCLK_N CLK_N 0 DC 0.9 PULSE(1.2 0.6 0 20p 20p 480p 1n)

* Inputs (110 MHz, Common Mode = 1.4V, Swing = 0.4Vpp diff)
VIN_P IN_P 0 DC 1.4 SIN(1.4 0.2 110MEG 0 0 0)
VIN_N IN_N 0 DC 1.4 SIN(1.4 0.2 110MEG 0 0 180)

* Modified Netlist for SKY130 (Added resistor values, mapped NPN to NMOS)
R16 VDD N1 400
R8 VDD N2 400
R3 VDD N6 400
R1 VDD N7 400
R10 VDD N13 400
R2 VDD N14 400
R11 N18 0 50
R13 N19 0 50
R5 N20 0 50
R4 N21 0 50
R9 N22 0 50
R12 N23 0 50
R7 N24 0 50
R6 N25 0 50
R15 N26 0 50
XM14 N1 IN_P N3 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM25 N2 IN_N N3 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM6 N3 V_R N18 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM23 VDD N1 N4 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM2 VDD N2 N5 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM9 N4 V_R N19 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM21 N5 V_R N20 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM28 N10 CLK_P N12 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM16 N11 CLK_N N12 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM13 N12 V_R N21 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM24 N6 N4 N10 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM30 N7 N5 N10 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM10 N6 N9 N11 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM8 N7 N8 N11 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM12 VDD N6 N8 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM4 VDD N7 N9 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM5 N8 V_R N22 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM1 N9 V_R N23 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM22 N15 CLK_N N17 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM27 N16 CLK_P N17 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM15 N17 V_R N24 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM18 N13 N8 N15 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM29 N14 N9 N15 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM3 N13 Q_P N16 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM11 N14 Q_N N16 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM20 VDD N13 Q_N 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM19 VDD N14 Q_P 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM7 Q_N V_R N25 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM26 Q_P V_R N26 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15

.control
* DC Operating Point for Power
op
let power = -i(VVDD) * 1.8
print power

* Transient Analysis
tran 10p 20n
let out_diff = v(Q_P) - v(Q_N)
let clk_diff = v(CLK_P) - v(CLK_N)

* Measure Clock Frequency
meas tran clk_period trig clk_diff val=0 rise=1 targ clk_diff val=0 rise=2
let clk_freq = 1 / clk_period
print clk_freq

* Measure Output Swing
meas tran v_max max out_diff from=10n to=20n
meas tran v_min min out_diff from=10n to=20n
let swing = v_max - v_min
print swing

* Measure Propagation Delay
meas tran t_pd trig clk_diff val=0 fall=1 td=5n targ out_diff val=0 fall=1 td=5n
print t_pd

quit
.endc
.end