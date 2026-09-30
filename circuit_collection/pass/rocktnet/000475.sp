* NMOS Differential Pair Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N0 VBIAS_B GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 IOUTn VINp N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 IOUTp VINn N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

VDD VDD 0 1.8
VVBIAS_B VBIAS_B 0 0.54
VVINp VINp 0 DC 0.9 AC 0.5 SIN(0.9 0.05 1MEG 0 0 0)
VVINn VINn 0 DC 0.9 AC -0.5 SIN(0.9 0.05 1MEG 0 0 180)

* Added loads to convert output currents to voltages for measurement
RL1 IOUTn VDD 50k
RL2 IOUTp VDD 50k
CL1 IOUTn 0 100f
CL2 IOUTp 0 100f

* Dependent source to measure differential output voltage
E1 VOUT_DIFF 0 IOUTp IOUTn 1

.control
op
* Tail current is the total current drawn from VDD (through RL1 and RL2)
let iss = -i(VDD)
let power = iss * 1.8
print iss power

ac dec 100 1k 1G
let gain_db = vdb(VOUT_DIFF)
meas ac dc_gain find gain_db at=1k
meas ac gain_10M find gain_db at=10MEG

tran 1n 5u
meas tran vout_diff_max max v(VOUT_DIFF)
meas tran vout_diff_min min v(VOUT_DIFF)
let diff_swing = vout_diff_max - vout_diff_min
print diff_swing
quit
.endc
.end
