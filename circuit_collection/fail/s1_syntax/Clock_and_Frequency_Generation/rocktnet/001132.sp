* Triple-Push Oscillator Subcircuit (Colpitts)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param VDD=1.8
.param L_val=0.001
.param C1_val=2p
.param C2_val=2p
.param W_m1=50.0
.param L_m1=0.15

* Supply and Bias
V1 Vcc GND {VDD}
RB1 Vcc N3 8k
RB2 N3 GND 10k

* LC Tank and Transistor (Replaced NPN with SKY130 NMOS)
L1 N0 Vcc {L_val}
C1 N0 N1 {C1_val}
C2 N1 GND {C2_val}
M1 N0 N3 N1 GND sky130_fd_pr__nfet_01v8 w={W_m1} l={L_m1}

* Emitter/Source Degeneration and Bypass
RE N1 GND 200
CB N3 GND 10p

* Output Coupling and Load
C3 N0 N4 1p
R4 N4 RF_Output 50
Rload RF_Output GND 50

* Initial condition to kickstart oscillation
.ic v(N0)=0

.control
* Transient analysis for oscillation
tran 5p 20n

* Measure Oscillation Frequency (f_osc)
meas tran t_period trig v(RF_Output) val=0 rise=10 targ v(RF_Output) val=0 rise=11
let f_osc = 1 / t_period
print f_osc

* Measure Output Power (P_out in dBm)
meas tran v_max max v(RF_Output) from=10n to=20n
meas tran v_min min v(RF_Output) from=10n to=20n
let v_pk = (v_max - v_min) / 2
let p_out_w = (v_pk * v_pk) / (2 * 50)
let p_out_dbm = 10 * log10(p_out_w / 1e-3)
print p_out_dbm

* Measure DC Power Consumption (P_DC)
op
let p_dc = -i(V1) * {VDD}
print p_dc

quit
.endc
.end