* SiGe Differential TIA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameterized missing resistor values
.param R_default=1k
.param R_fb=280
.param R_out=50

* DUT Netlist
R1 GND IN {R_default}
Q1 GND N2 N7 npn
Q2 N3 N3 N17 npn
Q3 N2 N2 N10 npn
Q4 IN N0 N11 npn
Q5 N8 IN N19 npn
R2 N7 N12 {R_default}
Q6 OUT N7 N20 npn
R3 N11 N12 {R_default}
R4 GND OUT {R_out}
R5 N1 N12 {R_default}
R6 N10 N12 {R_default}
Q7 N19 N0 N15 npn
Q8 N14 IN N0 npn
Q9 N9 N0 N13 npn
Q10 N18 N18 N14 npn
R7 N12 N15 {R_default}
R8 N12 N17 {R_default}
RL2 N4 GND {R_default}
R10 N12 N13 {R_default}
RE1 N9 N9 {R_default}
RL1 GND N8 {R_default}
Q11 N4 IN N19 npn
RE2 N9 N20 {R_default}
RFB2 N2 IN {R_fb}
R15 GND OUT {R_out}
RFB1 N3 IN {R_fb}
Q12 GND N4 N2 npn
Q13 GND GND N18 npn
Q14 OUT N1 LABEL_NET_0 npn
Q15 N3 N8 GND pnp
Q16 N1 N3 GND pnp

* Generic BJT models for simulation
.model npn npn bf=100 is=1e-15 cjc=100f cje=100f tf=10p
.model pnp pnp bf=50 is=1e-15 cjc=100f cje=100f tf=10p

* Supplies and Stimulus
* GND is treated as the positive supply (0V), N12 as the negative supply (-1.8V)
VEE N12 0 DC -1.8
VLABEL LABEL_NET_0 0 DC -1.8
IIN IN 0 DC 0 AC 1

.control
* 1. DC Operating Point & Power
dc VEE -1.8 -1.8 1
let pwr = abs(1.8 * i(VEE)) + abs(1.8 * i(VLABEL))
meas dc Power_Consumption find pwr at=-1.8

* 2. AC Analysis for Gain and Bandwidth
ac dec 50 1M 1000G
let gain_db = vdb(OUT)
meas ac Transimpedance_Gain find gain_db at=10M
let gain_3db = Transimpedance_Gain - 3
meas ac Bandwidth_3dB when gain_db=gain_3db fall=LAST

* 3. Noise Analysis
noise v(OUT) IIN dec 10 100M 10G
setplot noise1
meas noise Input_Referred_Noise find inoise_spectrum at=1G

quit
.endc
.end