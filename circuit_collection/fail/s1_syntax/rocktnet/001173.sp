* Bias Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 N8 VB1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM4 N9 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM3 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 N0 VB2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Supply and Bias Voltages
VDD VDD 0 1.8
VVB1 VB1 0 0.54
VVB2 VB2 0 0.54

* Load Resistors and Current Sources to bias the drains
VR1 VDD N8_R 0
R1 N8_R N8 10k

Iref VDD N9 100u

VR3 VDD N1_R 0
R3 N1_R N1 1k

VR4 VDD N0_R 0
R4 N0_R N0 10k

.control
tran 100p 1n

meas tran I_XM1 avg i(VR1)
meas tran I_XM2 avg i(VR4)
meas tran I_XM3 avg i(VR3)
meas tran V_N9 avg v(n9)
meas tran Power avg -i(VDD)*1.8

print I_XM1 I_XM2 I_XM3 V_N9 Power
quit
.endc
.end