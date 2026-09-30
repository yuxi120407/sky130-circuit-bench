* Dual Differential Pair Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N1 IN N3 VEE sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 IN_BAR N3 VEE sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM4 N8 N5 N10 VEE sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM3 N9 N7 N10 VEE sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

VDD VDD 0 1.8
VEE VEE 0 0

* Tail currents
I1 N3 VEE 500u
I2 N10 VEE 500u

* Loads
R1 VDD N1 2k
R2 VDD N2 2k
R3 VDD N8 2k
R4 VDD N9 2k

* Inputs
VIN IN 0 DC 0.9 AC 1 SIN(0.9 0.001 10MEG 0 0)
VIN_BAR IN_BAR 0 DC 0.9 AC -1 SIN(0.9 -0.001 10MEG 0 0)
VN5 N5 0 DC 0.9 AC 1 SIN(0.9 0.001 10MEG 0 0)
VN7 N7 0 DC 0.9 AC -1 SIN(0.9 -0.001 10MEG 0 0)

.control
op
let power = -i(VDD) * 1.8
print power

ac dec 100 1k 10G
let out_diff1 = v(N1) - v(N2)
let gain_db1 = 20 * log10(mag(out_diff1) / 2)
meas ac max_gain MAX gain_db1
meas ac bw1 when gain_db1='max_gain - 3' fall=1

tran 1n 200n
meas tran vpp_out1 pp v(N1)
meas tran vpp_out2 pp v(N8)
quit
.endc
.end