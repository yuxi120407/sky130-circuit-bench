* Full-Wave Rectifier / Amplitude Detector Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 VOUT VCM Q GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT VINP P GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT VCM P GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT VINN Q GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Biasing and Load
RtailP P 0 1k
RtailQ Q 0 1k
Rload VDD VOUT 1k
Cload VOUT 0 10p

* Sources
VVDD VDD 0 1.8
VVCM VCM 0 0.9

* Differential input setup using a behavioral source for easy sweeping and transient
Vvid vid 0 DC 0 SIN(0 0.4 100MEG)
Bvinp VINP 0 V='0.9 + v(vid)/2'
Bvinn VINN 0 V='0.9 - v(vid)/2'

.control
* 1. DC Sweep for Transfer Characteristic
dc Vvid -0.5 0.5 0.01
meas dc vout_0 find v(VOUT) at=0
meas dc vout_400 find v(VOUT) at=0.4
let detector_gain = (vout_0 - vout_400) / 0.4
print detector_gain
print vout_0

* 2. Operating Point for Power
op
let power = -i(VVDD) * 1.8
print power

* 3. Transient Analysis for Ripple
tran 100p 50n
meas tran vout_max max v(VOUT) from=20n to=50n
meas tran vout_min min v(VOUT) from=20n to=50n
let ripple = vout_max - vout_min
print ripple

quit
.endc
.end