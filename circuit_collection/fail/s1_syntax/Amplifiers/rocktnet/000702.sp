* 17GHz Tuned LO Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_diff=0.5
.param L_ef=0.5
.param L_load=0.5
.param L_tail=0.5

.param W_diff=20 L_diff=0.15
.param W_tail=20 L_tail=0.15
.param W_ef=10 L_ef=0.15
.param R_load=200 L_load=0.00175
.param R_deg=50

VCC VCC 0 DC 1.8
VIN_MINUS IN_MINUS 0 DC 0.9 AC 0.5 180 SIN(0.9 0.1 17G 0 0)
VIN_PLUS IN_PLUS 0 DC 0.9 AC 0.5 0 SIN(0.9 0.1 17G 0 0)
VIBIAS IBIAS 0 DC 0.75

* Modified DUT: NPNs replaced with SKY130 NMOS
R1 VCC N1 {R_load}
R2 VCC N2 {R_load}
R3 N4 0 {R_deg}
R4 N5 0 {R_deg}
R5 N6 0 {R_deg}
R6 N7 0 {R_deg}
L1 VCC N1 {L_load}
L2 VCC N2 {L_load}

XM11 N1 IN_MINUS N3 0 sky130_fd_pr__nfet_01v8 w={W_diff} l={L_diff}
XM12 N2 IN_PLUS N3 0 sky130_fd_pr__nfet_01v8 w={W_diff} l={L_diff}
XM13 IBIAS IBIAS N7 0 sky130_fd_pr__nfet_01v8 w={W_tail} l={L_tail}
XM14 LO_PLUS IBIAS N4 0 sky130_fd_pr__nfet_01v8 w={W_tail} l={L_tail}
XM15 N3 IBIAS N5 0 sky130_fd_pr__nfet_01v8 w={W_tail} l={L_tail}
XM16 LO_MINUS IBIAS N6 0 sky130_fd_pr__nfet_01v8 w={W_tail} l={L_tail}
XM17 VCC N1 LO_PLUS 0 sky130_fd_pr__nfet_01v8 w={W_ef} l={L_ef}
XM28 VCC N2 LO_MINUS 0 sky130_fd_pr__nfet_01v8 w={W_ef} l={L_ef}

* Load capacitance to simulate next stage
C1 LO_PLUS 0 50f
C2 LO_MINUS 0 50f

.control
op
let power = -i(VCC) * 1.8
print power
meas dc power_mw param power*1000

ac dec 40 1G 100G
let vout_diff = v(LO_PLUS) - v(LO_MINUS)
let gain_db = 20*log10(mag(vout_diff))
let phase_diff = 180/PI * (cph(v(LO_PLUS)) - cph(v(LO_MINUS)))

meas ac max_gain MAX gain_db
meas ac gain_17g FIND gain_db AT=17G
meas ac phase_17g FIND phase_diff AT=17G

tran 1p 200p
meas tran vpp_out_plus PP v(LO_PLUS)
meas tran vpp_out_minus PP v(LO_MINUS)
.endc
.end