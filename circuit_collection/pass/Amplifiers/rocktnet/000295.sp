* Testbench for Baseband Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

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
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5

XM1 OUT_PLUS IN_MINUS N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N11 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT_MINUS OUT_MINUS N9 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N12 OUT_PLUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT_PLUS OUT_PLUS N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N12 OUT_MINUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 OUT_MINUS N11 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 OUT_PLUS N11 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 OUT_MINUS IN_PLUS N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N7 CTRL N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N3 VDD N10 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N7 VDD N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N7 VDD N3 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 N3 CTRL N3 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N10 VDD N9 GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}

* Fix for likely typo in XM15 (PMOS with G=VDD blocks DC path for N6, causing severe asymmetry)
Rfix N6 N9 1m

* Power Supply
VVDD VDD 0 1.8

* Biasing
Ibias1 N2 0 60u
XM_bias N11 N11 GND GND sky130_fd_pr__nfet_01v8 l=0.5 w=5.0
Ibias2 VDD N11 20u

* Inputs
VIN_MINUS IN_MINUS 0 DC 0.1 AC -0.5 SIN(0.1 0.1 10Meg 0 0)
VIN_PLUS IN_PLUS 0 DC 0.1 AC 0.5 SIN(0.1 0.1 10Meg 0 0)
VCTRL CTRL 0 0

* Load for N12 (Common-mode output)
Rload N12 VDD 10k

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac dec 100 1k 10G
let out_diff = v(OUT_PLUS) - v(OUT_MINUS)
let gain_db = 20*log10(mag(out_diff))
meas ac voltage_gain find gain_db at=1k
meas ac bandwidth when gain_db='voltage_gain - 3' fall=1

print voltage_gain
print bandwidth
.endc
.end