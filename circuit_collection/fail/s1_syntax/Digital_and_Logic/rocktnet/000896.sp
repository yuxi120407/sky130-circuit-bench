* 2:1 MUX Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Supplies
VCC VCC 0 1.8
VEE VEE 0 0

* Inputs (1 GHz Clock, 500 MHz Data)
VCLK CLK 0 pulse(1.4 1.8 0 20p 20p 480p 1n)
VCLKN CLKN 0 pulse(1.8 1.4 0 20p 20p 480p 1n)
VD1 D1 0 pulse(1.4 1.8 0 20p 20p 980p 2n)
VD1N D1N 0 pulse(1.8 1.4 0 20p 20p 980p 2n)
VD2 D2 0 pulse(1.8 1.4 0 20p 20p 980p 2n)
VD2N D2N 0 pulse(1.4 1.8 0 20p 20p 980p 2n)

* Modified Netlist (Q -> M, npn/pnp -> sky130_fd_pr__nfet_01v8)
R1 N16 VEE 100
R2 N5 VEE 100
R3 VCC Iout 500
R4 Iout N11 500
M1 N11 N11 N16 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
M2 VCC N12 N4 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
R5 VCC Q 500
R6 VCC QN 500
R7 N8 VEE 2k
M3 N3 N11 N5 0 sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
R8 N4 VEE 2k
R9 N1 VEE 2k
R10 N14 VEE 2k
M4 VCC D1N N0 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
R11 N6 VEE 2k
M5 N19 N15 N3 0 sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
R12 N15 VEE 2k
M6 VCC N18 N12 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
R13 N12 VEE 2k
M7 QN N8 N7 0 sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
R14 N0 VEE 2k
M8 VCC CLK N14 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
M9 VCC N14 N15 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
M10 VCC D1 N1 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
M11 QN N0 N19 0 sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
M12 VCC D2N N8 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
M13 VCC D2 N6 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
M14 Q N6 N7 0 sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
R15 Iout Iout 1
M15 Q N1 N19 0 sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
* Note: Q16 was extracted as PNP, but must be NPN (NFET) to form a proper diff pair with M5.
M16 N7 N4 N3 0 sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
R16 N18 CLKN 1

* Control block
.control
tran 10p 5n

meas tran v_max max v(q)
meas tran v_min min v(q)
let swing = v_max - v_min
print swing

* Measure delay from CLK rising edge to Q falling edge (D1 is high, so Q pulls low)
meas tran t_delay trig v(clk) val=1.6 rise=2 targ v(q) val=1.6 fall=1

op
let power = -i(VCC) * 1.8
print power

quit
.endc
.end
