* Gm Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm12=0.5
.param L_xm1d=0.5
.param L_xm2=0.5
.param L_xm2d=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm2d=5.0 L_xm2d=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm1d=5.0 L_xm1d=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm12=5.0 L_xm12=0.5

* DUT
XM2D N0 VBIAS_EN_BAR GND GND sky130_fd_pr__nfet_01v8 l={L_xm2d} w={W_xm2d}
XM5 N1 VBIAS_EN GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM8 CM I_MINUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM1D CM I_PLUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1d} w={W_xm1d}
XM2 N1 VBIAS_EN GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM6 N0 VBIAS_EN_BAR GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 O_PLUS I_MINUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM3 O_MINUS CMFB N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM9 O_PLUS CMFB N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM1 O_MINUS I_PLUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM4 N4 VDD_EN_BAR VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM12 N12 VDD_EN_BAR VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

* Biasing and Supplies
V_VDD VDD 0 1.8
V_VBIAS_EN VBIAS_EN 0 1.8
V_VBIAS_EN_BAR VBIAS_EN_BAR 0 0
V_VDD_EN_BAR VDD_EN_BAR 0 0
V_CM CM 0 0.9

* Ideal CMFB Loop to stabilize output common-mode at 0.9V
B_CMFB CMFB 0 V='0.9 + 10*(v(O_PLUS)+v(O_MINUS)-1.8)'

* Inputs
V_IN_CM IN_CM 0 0.9
V_IN_D IN_D 0 0 ac 1 sin(0 0.1 100Meg)
E_IN_P I_PLUS IN_CM IN_D 0 0.5
E_IN_M I_MINUS IN_CM IN_D 0 -0.5

* Loads
C_L1 O_PLUS 0 50f
C_L2 O_MINUS 0 50f

* Differential Output for Measurement
E_DIFF OUT_DIFF 0 O_PLUS O_MINUS 1

.control
* DC Operating Point and Power
op
let power = -i(V_VDD) * 1.8
print power

* AC Analysis
ac dec 100 1Meg 10G
let gain_db = vdb(OUT_DIFF)
meas ac dc_gain find gain_db at=1Meg
meas ac bw_3db when gain_db='dc_gain-3' fall=1
meas ac unity_gain_freq when gain_db=0 fall=1

* Transient Analysis
tran 10p 20n
meas tran vout_pp pp v(OUT_DIFF)
.endc
.end
