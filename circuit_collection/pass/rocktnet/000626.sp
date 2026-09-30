* Direct Conversion I/Q Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.model npn npn (is=1e-16 bf=100 vaf=50)

* DUT
Q2 COLL_Q1 RF_P EMIT_I npn
Q10 COLL_Q2 RF_N EMIT_I npn
Q1 I_CH_P LO_I_P COLL_Q1 npn
Q6 I_CH_N LO_I_N COLL_Q1 npn
Q7 I_CH_P LO_I_N COLL_Q2 npn
Q12 I_CH_N LO_I_P COLL_Q2 npn
Q4 COLL_Q7 RF_P EMIT_Q npn
Q3 COLL_Q8 RF_N EMIT_Q npn
Q11 Q_CH_P LO_Q_P COLL_Q7 npn
Q9 Q_CH_N LO_Q_N COLL_Q7 npn
Q5 Q_CH_P LO_Q_N COLL_Q8 npn
Q8 Q_CH_N LO_Q_P COLL_Q8 npn
C1 I_CH_P VDD 10p
C2 VDD Q_CH_P 10p
C3 I_CH_N VDD 10p
C4 Q_CH_N VDD 10p
R1 EMIT_I GND 50
R2 EMIT_Q GND 50
R3 VDD Q_CH_P 500
R4 Q_CH_N VDD 500
R5 I_CH_P VDD 500
R6 I_CH_N VDD 500

* Sources
VVDD VDD 0 1.8

* RF Input (1.991 GHz, 5mV peak per side -> 20mV pp diff)
VRF_P RF_P 0 DC 0.8 SIN(0.8 0.005 1.991G 0 0 0)
VRF_N RF_N 0 DC 0.8 SIN(0.8 0.005 1.991G 0 0 180)

* LO I-Channel (1.990 GHz, 300mV peak per side)
VLO_I_P LO_I_P 0 DC 1.6 SIN(1.6 0.3 1.990G 0 0 0)
VLO_I_N LO_I_N 0 DC 1.6 SIN(1.6 0.3 1.990G 0 0 180)

* LO Q-Channel (1.990 GHz, 300mV peak per side, 90 deg shifted)
VLO_Q_P LO_Q_P 0 DC 1.6 SIN(1.6 0.3 1.990G 0 0 90)
VLO_Q_N LO_Q_N 0 DC 1.6 SIN(1.6 0.3 1.990G 0 0 270)

* Differential Output Dependent Sources
B_I_DIFF I_DIFF 0 V=v(I_CH_P)-v(I_CH_N)
B_Q_DIFF Q_DIFF 0 V=v(Q_CH_P)-v(Q_CH_N)

.control
tran 20p 3u

* Measure power
let power = -i(VVDD) * 1.8
meas tran avg_power avg power

* Measure IF output amplitude (1 MHz)
meas tran vout_I_max max v(I_DIFF) from=1u to=3u
meas tran vout_I_min min v(I_DIFF) from=1u to=3u
let vout_I_pp = vout_I_max - vout_I_min

meas tran vout_Q_max max v(Q_DIFF) from=1u to=3u
meas tran vout_Q_min min v(Q_DIFF) from=1u to=3u
let vout_Q_pp = vout_Q_max - vout_Q_min

* Calculate Conversion Gain
let vin_pp = 0.02
let cg_I_linear = vout_I_pp / vin_pp
let cg_Q_linear = vout_Q_pp / vin_pp

print avg_power
print cg_I_linear
print cg_Q_linear
quit
.endc
.end
