* TIALA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_nmos=0.5

.param W_nmos=10.0 L_nmos=0.15

* Modified DUT: Changed Q to M (NMOS), added missing resistor values
M1 N0 DINP N4 GND sky130_fd_pr__nfet_01v8 W={W_nmos} L={L_nmos}
C1 N2 N3 1.1p
R1 N11 GND 1k
M2 N9 N3 N14 GND sky130_fd_pr__nfet_01v8 W={W_nmos} L={L_nmos}
M3 N13 N2 N14 GND sky130_fd_pr__nfet_01v8 W={W_nmos} L={L_nmos}
R2 N5 N13 500
M4 N1 DINN N4 GND sky130_fd_pr__nfet_01v8 W={W_nmos} L={L_nmos}
R3 N5 N9 500
M5 N14 N10 N18 GND sky130_fd_pr__nfet_01v8 W={W_nmos} L={L_nmos}
R4 N7 N12 500
R5 N5 N8 10
R6 N18 GND 100
R8 N15 GND 100
R7 N7 N8 10
C2 N13 N16 1.1p
R9 N6 N7 10
R10 N1 N12 500
C3 N9 N19 1.1p
M6 N10 IFDB N11 GND sky130_fd_pr__nfet_01v8 W={W_nmos} L={L_nmos}
R11 N1 N0 10k
R12 N3 N2 10k
R15 N2 N3 10k
R14 N0 N6 500
R13 N2 N16 3k
M7 N4 N10 N15 GND sky130_fd_pr__nfet_01v8 W={W_nmos} L={L_nmos}
R16 N0 N1 10k
R17 N3 N19 3k

* Power Supply
Vvdd N8 0 1.8

* Bias
Vifdb IFDB 0 0.9

* TIA Inputs (AC Current for Transimpedance)
Iin_p 0 N3 AC 0.5 DC 0
Iin_n 0 N2 AC -0.5 DC 0
* DC bias for TIA inputs (floating in netlist)
Vbias_tia bias_tia 0 0.9
Rbias_tia_p bias_tia N3 100k
Rbias_tia_n bias_tia N2 100k

* LA Inputs (AC Voltage for Voltage Gain)
Vbias_la bias_la 0 0.9
Vla_p DINP bias_la AC 0.5
Vla_n DINN bias_la AC -0.5

.control
* DC Operating Point
op
let power = -i(Vvdd) * 1.8
print power

* AC Analysis
ac dec 100 1M 100G

* TIA Metrics
let vout_tia = v(N9) - v(N13)
let zt_db = 20 * log10(mag(vout_tia))
meas ac zt_max max zt_db
meas ac tia_bw when zt_db='zt_max-3' fall=1

* LA Metrics
let vout_la = v(N0) - v(N1)
let gain_la_db = 20 * log10(mag(vout_la))
meas ac gain_la_max max gain_la_db
meas ac la_bw when gain_la_db='gain_la_max-3' fall=1

print zt_max tia_bw gain_la_max la_bw
quit
.endc
.end
