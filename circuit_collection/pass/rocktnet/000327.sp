* Active-Feedback Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xma=0.5
.param L_xmb1=0.5
.param L_xmb2=0.5
.param L_xmb3=0.5
.param L_xmc1=0.5
.param L_xmc2=0.5

.param W_xmc1=5.0 L_xmc1=0.5
.param W_xmb1=5.0 L_xmb1=0.5
.param W_xma=5.0 L_xma=0.5
.param W_xmb2=5.0 L_xmb2=0.5
.param W_xmc2=5.0 L_xmc2=0.5
.param W_xmb3=5.0 L_xmb3=0.5

XMC1 IN N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc1} w={W_xmc1}
XMB1 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmb1} w={W_xmb1}
XMA IN VB4 GMA VSS sky130_fd_pr__nfet_01v8 l={L_xma} w={W_xma}
XMB2 N0 IN N3 VSS sky130_fd_pr__nfet_01v8 l={L_xmb2} w={W_xmb2}
XMC2 GMA VB5 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xmc2} w={W_xmc2}
XMB3 N3 VB5 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xmb3} w={W_xmb3}

VVDD VDD 0 1.8
VVSS VSS 0 0
VIN IN 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)
VVB4 VB4 0 0.54
VVB5 VB5 0 0.54

.control
op
let power = -i(VVDD) * 1.8
print power
print v(N0) v(GMA) v(N3)

ac dec 100 1 1G
* Calculate input impedance Z_in = V(IN) / I_in
* i(VIN) is current from IN to 0, so current into circuit is -i(VIN)
let Z_in = v(IN) / -i(VIN)
let R_in = real(Z_in)
let X_in = imag(Z_in)
let omega = 2 * pi * frequency
let C_in = -1 / (omega * X_in)

meas ac Rin_dc find R_in at=10
meas ac Cin_dc find C_in at=10k

* Measure bandwidth where negative resistance drops by half
let Rin_half = Rin_dc / 2
meas ac bw_Rin when R_in=Rin_half cross=1

* Measure gain from IN to N0
let gain_N0_db = vdb(N0)
meas ac gain_N0_dc find gain_N0_db at=10

tran 1n 2u
meas tran v_N0_max max v(N0)
meas tran v_N0_min min v(N0)
.endc
.end