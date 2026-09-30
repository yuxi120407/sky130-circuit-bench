* TIA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm5=0.5
.param L_xm6=0.5

* DUT Parameters
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

* DUT Netlist
XM1 N1 IN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N1 N3 N3 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM5 OUT N9 N10 N10 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N10 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Biasing and Loads
VVDD VDD 0 1.8
R1 VDD N1 1k
V_N2 VDD N2 0
R2 N3 0 1k
RF N3 IN 1k
C_PD IN 0 50f
V_N9 N9 0 1.8
V_N6 N3 N6 -0.4
R3 VDD OUT 500

* Input Source (AC=1 for Zt in dB, Tran=10uA sine)
IIN 0 IN DC 10u AC 1 SIN(10u 10u 100MEG)

.control
* DC Operating Point & Power
op
let power = -i(VVDD)*1.8
print power

* AC Analysis for Transimpedance Gain and Bandwidth
ac dec 100 1MEG 200G
let zt_db = db(v(out))
meas ac zt_max max zt_db
let zt_3db = zt_max - 3
meas ac bw_3db when zt_db=zt_3db fall=1
print zt_max
print bw_3db

* Transient Analysis for Output Swing
tran 10p 50n
meas tran vout_pp pp v(out) from=20n to=50n
print vout_pp

quit
.endc
.end