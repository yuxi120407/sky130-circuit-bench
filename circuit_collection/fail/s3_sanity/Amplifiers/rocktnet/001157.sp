* OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm12=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmt1=0.5
.param L_xmt2=0.5

* Parameter definitions
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xmt2=5.0 L_xmt2=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xmt1=5.0 L_xmt1=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm19=5.0 L_xm19=0.5

* DUT
XM1 N14 VB4 N18 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N20 VB5 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 VO_PLUS N17 N20 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N13 N12 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N18 VB5 LABEL_NET_2 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N5 N1 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N10 N19 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N19 N9 LABEL_NET_3 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 VO_MINUS N16 N13 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N4 N1 VO_MINUS GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XMT2 VO_MINUS VO_MINUS GND GND sky130_fd_pr__nfet_01v8 l={L_xmt2} w={W_xmt2}
XM12 N4 N1 VO_MINUS GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XMT1 GND VO_PLUS GND GND sky130_fd_pr__nfet_01v8 l={L_xmt1} w={W_xmt1}
XM14 N8 CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 VO_PLUS VB3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 VO_MINUS VB3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 N1 VB3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N14 N4 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XM19 N14 VIN_PLUS N4 GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}

* Voltage Sources
VVDD VDD 0 1.8
VLABEL_NET_2 LABEL_NET_2 VDD 0
VLABEL_NET_3 LABEL_NET_3 VDD 0

VVB4 VB4 0 0.6
VVB5 VB5 0 1.0
VN9 N9 VDD 0
VN12 N12 VDD 0
VN10 N10 VDD 0
VN16 N16 VDD 0
VN17 N17 0 0.6
VVB3 VB3 0 1.2
VCMFB CMFB 0 1.0
VN1 N1 0 0.8

* Servo loop for VIN_PLUS
VREF VREF 0 0.9
G1 VIN_DC 0 VO_PLUS VREF 1m
R_servo VIN_DC 0 1MEG
C_servo VIN_DC 0 1
VAC VIN_PLUS VIN_DC DC 0 AC 1

* Load Capacitors
CL1 VO_PLUS 0 1p
CL2 VO_MINUS 0 1p

.control
op
let Power_Consumption = -i(VVDD) * 1.8
print Power_Consumption

ac dec 100 10 10G
let gain_db = db(v(VO_PLUS))
let phase = 180/PI * cph(v(VO_PLUS))
let pm_calc = 180 + phase

meas ac DC_Gain find gain_db at=10
meas ac GBW when gain_db=0 fall=1
meas ac Phase_Margin find pm_calc when gain_db=0 fall=1

print DC_Gain GBW Phase_Margin
quit
.endc
.end