* Testbench for PMOS Diff Pair and NMOS Parallel Pair
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N0 LABEL_NET_0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_7 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 LABEL_NET_9 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8

* PMOS Diff Pair Bias and Loads
I_tail VDD N7 50u
R1 N1 0 20k
R2 N5 0 20k
V_INP LABEL_NET_7 0 dc 0.9 ac 1
V_INN LABEL_NET_9 0 dc 0.9 ac -1

* NMOS Parallel Pair Bias and Loads
V_N4 N4 0 0
R3 VDD N0 1k
V_IN1 LABEL_NET_0 0 dc 0.9
V_IN2 LABEL_NET_2 0 dc 0.9

.control
op
let total_current = -i(VVDD)
let power = total_current * 1.8
print power

ac dec 100 1k 1G
let gain_db = vdb(N1)
meas ac midband_gain find gain_db at=10k
* Assuming midband gain is around 10dB, measure bandwidth at 7dB
meas ac bw_3db when gain_db=7 fall=1
quit
.endc
.end