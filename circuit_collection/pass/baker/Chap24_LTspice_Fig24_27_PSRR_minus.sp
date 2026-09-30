* Testbench for Chapter 24 Op-Amp PSRR and Gain
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.subckt opamp VDD VSS INP INM OUT
XM1 D1 INM S_tail VSS sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
XM2 D2 INP S_tail VSS sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
XM3 D1 D1 VDD VDD sky130_fd_pr__pfet_01v8 w=20.0 l=1.0
XM4 D2 D1 VDD VDD sky130_fd_pr__pfet_01v8 w=20.0 l=1.0
XM5 S_tail Bias VSS VSS sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
XM6 OUT D2 VDD VDD sky130_fd_pr__pfet_01v8 w=40.0 l=1.0
XM7 OUT Bias VSS VSS sky130_fd_pr__nfet_01v8 w=20.0 l=1.0
Iref VDD Bias 10u
XM8 Bias Bias VSS VSS sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
Cc D2 Rz_node 1p
Rz Rz_node OUT 1k
.ends

Vdd VDD 0 DC 1.8 AC 0
Vss VSS 0 DC 0

* Instance 1: Gain, PSRR+, Slew Rate
X1 VDD VSS INP1 INM1 OUT1 opamp
R1 OUT1 INM1 100MEG
C1 INM1 0 10u
Cload1 OUT1 0 1p
Vinp1 INP1 0 DC 0.9 AC 1 PULSE(0.9 1.4 1u 1n 1n 10u 20u)

* Instance 2: CMRR
X2 VDD VSS INP2 INM2 OUT2 opamp
R2 OUT2 INM2 100MEG
C2 INM2 Vcm_ac 10u
Vinp2 INP2 0 DC 0.9 AC 1
Vcm_ac Vcm_ac 0 DC 0 AC 1

.control
* 1. Open-loop gain and Unity Gain Frequency
ac dec 10 1 1G
let gain_mag = v(OUT1)
let gain_db = db(gain_mag)
meas ac open_loop_gain MAX gain_db
meas ac unity_gain_frequency when gain_db=0 fall=1

* 2. CMRR
let acm_mag = v(OUT2)
let acm_db = db(acm_mag)
let cmrr_vec = gain_db - acm_db
meas ac cmrr MAX cmrr_vec

* 3. PSRR+
alter Vdd ac=1
alter Vinp1 ac=0
alter Vinp2 ac=0
alter Vcm_ac ac=0
ac dec 10 1 1G
let avdd_db = db(v(OUT1))
meas ac avdd_max MAX avdd_db
let psrr_plus = ac1.open_loop_gain - avdd_max
print psrr_plus

* 4. Slew Rate
tran 1n 20u
meas tran t1 when v(OUT1)=1.0 rise=1
meas tran t2 when v(OUT1)=1.4 rise=1
let slew_rate = 0.4 / (t2 - t1) / 1e6
print slew_rate

.endc
.end