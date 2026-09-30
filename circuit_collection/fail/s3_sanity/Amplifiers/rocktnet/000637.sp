* TIALA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param W_n=10.0
.param L_n=0.15

* Map NPN to SKY130 NMOS for CMOS evaluation
.subckt npn_mos d g s
XM1 d g s GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
.ends

* DUT (Q replaced with X to use subcircuit, passives given typical values)
X1 OUTN DINP N3 npn_mos
X2 N10 N10 N18 npn_mos
X3 N3 N17 N11 npn_mos
X4 N3 N21 N13 npn_mos
R1 OUTN N6 100
X5 N3 N15 N12 npn_mos
X6 N3 N20 N9 npn_mos
X7 N18 N14 N8 npn_mos
R2 OUTP N6 100
X8 ITDRV TLDRV1_TLRX1 N7 npn_mos
X9 OUTP DINN N3 npn_mos
R3 N2 DINN 500
C1 N2 GND 1p
R4 N1 3_3V 100
R5 N7 GND 50
X10 N3 ITDRV N19 npn_mos
C2 3_3V GND 10p
R6 N11 GND 50
R7 N2 N2 1
C3 N1 GND 1p
R8 N10 REFMON 1k
R9 3_3V N6 10
R10 3_3V N10 1k
R11 N19 GND 50
R12 N13 GND 50
R13 N12 GND 50
R14 N14 N16 1k
R15 N9 GND 50
R16 N8 GND 50
X11 N1 N2 N3 npn_mos
R17 N1 MON 1k

* Biasing
Vdd 3_3V GND 1.8
Vbias1 N17 GND 0.8
Vbias2 N21 GND 0.8
Vbias3 N15 GND 0.8
Vbias4 N20 GND 0.8
Vbias5 N14 GND 0.6
Vbias6 TLDRV1_TLRX1 GND 0.8
Vbias7 ITDRV GND 0.8

* Inputs (Soft voltage drive to allow auto-zero feedback to operate)
Vinp_src inp_src GND dc 1.5 ac 0.5
Vinn_src inn_src GND dc 1.5 ac -0.5
Rinp inp_src DINP 500
Rinn inn_src DINN 500

* Dummy loads for floating monitor nodes
Rref REFMON GND 1Meg
Rmon MON GND 1Meg
Rn16 N16 GND 1Meg

* Dependent source for differential output
Eout out_diff 0 OUTP OUTN 1
Esrc src_diff 0 inp_src inn_src 1

.control
* DC Operating Point & Power
op
let power_consumption = -i(Vdd) * 1.8
print power_consumption

* AC Analysis for Gain and Bandwidth
ac dec 50 1Meg 100G

let voltage_gain_vec = 20 * log10(mag(v(out_diff)) / mag(v(src_diff)))

let i_in_p = v(inp_src) / 500
let i_in_n = v(inn_src) / 500
let i_in_diff = (i_in_p - i_in_n) / 2
let transimpedance_gain_vec = 20 * log10(mag(v(out_diff)) / (mag(i_in_diff) + 1e-15))

meas ac voltage_gain MAX voltage_gain_vec
print voltage_gain

meas ac transimpedance_gain MAX transimpedance_gain_vec
print transimpedance_gain

meas ac bandwidth when voltage_gain_vec='voltage_gain - 3' fall=1
print bandwidth

quit
.endc
.end