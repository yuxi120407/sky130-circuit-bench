* Testbench for CMFB Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm31=0.5
.param L_xm32=0.5
.param L_xm41=0.5
.param L_xm42=0.5
.param L_xm51=0.5
.param L_xm52=0.5
.param L_xm62=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm9=5.0 L_xm9=0.5
.param W_xm41=5.0 L_xm41=0.5
.param W_xm62=5.0 L_xm62=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm32=5.0 L_xm32=0.5
.param W_xm31=5.0 L_xm31=0.5
.param W_xm42=5.0 L_xm42=0.5
.param W_xm51=5.0 L_xm51=0.5
.param W_xm52=5.0 L_xm52=0.5

* DUT
XM9 N4 VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM41 N4 PHI_CH1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm41} w={W_xm41}
XM62 N1 N4 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm62} w={W_xm62}
XM1 N1 IN_PLUS N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM8 N3 VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM2 N1 IN_MINUS N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM7 N6 VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM32 N3 PHI_CH2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm32} w={W_xm32}
XM31 N3 N3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm31} w={W_xm31}
XM42 N4 N4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm42} w={W_xm42}
XM51 N1 N3 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm51} w={W_xm51}
XM52 N1 N4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm52} w={W_xm52}

* Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
VGND GND 0 0
VVBIAS VBIAS 0 0.9

* Common-mode input excitation
VIN_PLUS IN_PLUS 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)
VIN_MINUS IN_MINUS 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)

* Chopper / Dynamic bias clocks
VPHI1 PHI_CH1 0 DC 1.8 PULSE(0 1.8 0 1n 1n 499n 1u)
VPHI2 PHI_CH2 0 DC 0 PULSE(1.8 0 0 1n 1n 499n 1u)

* Load capacitor
CLOAD N1 0 1p

.control
* DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* AC Analysis for Common-Mode Gain
ac dec 100 1 1G
let gain_db = vdb(N1)
meas ac cm_gain_db find gain_db at=1k

* Transient Analysis
tran 10n 5u
meas tran vout_max max v(N1)
meas tran vout_min min v(N1)
let vout_pp = vout_max - vout_min
print vout_pp

quit
.endc
.end
