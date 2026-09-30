* Symmetrical OTA Testbench

.param W_xmb1=5.0 L_xmb1=0.5
.param W_xmb3=5.0 L_xmb3=0.5
.param W_xmb6=5.0 L_xmb6=0.5
.param W_xmb2=5.0 L_xmb2=0.5
.param W_xmb4=5.0 L_xmb4=0.5
.param W_xmb5=5.0 L_xmb5=0.5
.param W_xmb7=5.0 L_xmb7=0.5
.param W_xmb8=5.0 L_xmb8=0.5
.param W_xmb9=5.0 L_xmb9=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5

* DUT
XMB1 N_MB1_D N_MB1_D GND GND sky130_fd_pr__nfet_01v8 l={L_xmb1} w={W_xmb1}
XMB3 N_MB2_D N_MB1_D GND GND sky130_fd_pr__nfet_01v8 l={L_xmb3} w={W_xmb3}
XMB6 N_MB5_D N_MB1_D GND GND sky130_fd_pr__nfet_01v8 l={L_xmb6} w={W_xmb6}
XMB2 N_MB2_D N_MB2_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmb2} w={W_xmb2}
XMB4 N_MB4_D N_MB5_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmb4} w={W_xmb4}
XMB5 N_MB5_D N_MB2_D N_MB4_D VDD sky130_fd_pr__pfet_01v8 l={L_xmb5} w={W_xmb5}
XMB7 N_MB7_D N_MB5_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmb7} w={W_xmb7}
XMB8 N_MB8_D N_MB2_D N_MB7_D VDD sky130_fd_pr__pfet_01v8 l={L_xmb8} w={W_xmb8}
XMB9 N_MB8_D N_MB8_D GND GND sky130_fd_pr__nfet_01v8 l={L_xmb9} w={W_xmb9}
XM15 N_M15_D N_MB5_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N_M16_D N_MB2_D N_M15_D VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM1 N_M1_D INp N_M16_D VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_M2_D INn N_M16_D VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_M1_D N_MB8_D N_M3_S GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N_M2_D N_MB8_D N_M4_S GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_M3_S N_M1_D GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N_M4_S N_M2_D GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM11 N_M11_D N_MB8_D N_M13_D GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 OUT N_MB8_D N_M14_D GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N_M13_D N_M1_D GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N_M14_D N_M2_D GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM7 N_M7_D N_MB5_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N_M8_D N_MB5_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N_M11_D N_M11_D N_M7_D VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 OUT N_M11_D N_M8_D VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

* Power Supply
VVDD VDD 0 1.8

* Bias current to start up the self-biasing network (N_MB1_D is diode-connected NMOS)
Ibias VDD N_MB1_D 10u

* DC feedback to inverting input (INp), AC open loop
* INp is the inverting input, INn is the non-inverting input
VINn INn 0 DC 0.9 AC 1
L1 OUT INp 1T
C1 INp 0 1T

* Load capacitance
CL OUT 0 1p

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmb1=0.5
.param L_xmb2=0.5
.param L_xmb3=0.5
.param L_xmb4=0.5
.param L_xmb5=0.5
.param L_xmb6=0.5
.param L_xmb7=0.5
.param L_xmb8=0.5
.param L_xmb9=0.5

.control
* DC Operating Point for Power
op
let power = -i(VVDD) * 1.8
print power

* AC Analysis for Gain, UGF, and Phase Margin
ac dec 100 1 1G
let gain_db = vdb(OUT)
let phase = 180/PI * cph(v(OUT))

meas ac dc_gain find gain_db at=10
meas ac ugf when gain_db=0 fall=1
meas ac phase_at_ugf find phase when gain_db=0 fall=1

* Calculate Phase Margin
let pm = 180 + phase_at_ugf
print pm

quit
.endc
.end