* Differential Clock Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

* DC Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
VLABEL_NET_1 LABEL_NET_1 0 0.9
VN0 N0 0 0.5

* Input signals (Common mode 0.9V, Differential AC=1V, Tran=400mVpp)
VCM VCM 0 0.9
VIN_DIFF VIN_DIFF 0 dc 0 ac 1 pulse(-0.2 0.2 0 50p 50p 450p 1n)
E1 CKIN_PLUS VCM VIN_DIFF 0 0.5
E2 CKIN_MINUS VCM VIN_DIFF 0 -0.5

* Load capacitance
C1 CKOUT_PLUS 0 10f
C2 CKOUT_MINUS 0 10f

* VCVS to convert differential output to single-ended for measurement
E_OUT VOUT_DIFF 0 CKOUT_PLUS CKOUT_MINUS 1

* DUT
XM1 CKOUT_MINUS CKIN_PLUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_1 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 CKOUT_PLUS CKIN_MINUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 CKOUT_MINUS N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 CKOUT_PLUS N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}

.control
* DC Operating Point
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* AC Analysis
ac dec 100 1Meg 100G
let gain_db = db(v(VOUT_DIFF))
meas ac dc_gain find gain_db at=1Meg
meas ac bandwidth_3db when gain_db='dc_gain-3' fall=1
print dc_gain
print bandwidth_3db

* Transient Analysis
tran 10p 5n
meas tran propagation_delay trig v(VIN_DIFF) val=0 rise=3 targ v(VOUT_DIFF) val=0 rise=3
print propagation_delay

quit
.endc
.end