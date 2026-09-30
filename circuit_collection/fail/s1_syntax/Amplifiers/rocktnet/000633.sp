* Wideband Differential Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

VVDD VDD 0 1.8
VGND GND 0 0

* Input signals: 0.9V DC common mode, 200mVpp differential AC, 100MHz transient
VIN_L IN_L 0 DC 0.9 AC 0.5 SIN(0.9 0.1 100MEG 0 0 0)
VIN_R IN_R 0 DC 0.9 AC -0.5 SIN(0.9 0.1 100MEG 0 0 180)

* Biasing and loads
ITAIL N_TAIL GND 200u
RL OUT_L GND 5k
RR OUT_R GND 5k

* DUT
XM1 VDD N_L OUT_L GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD N_R OUT_R GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_R IN_R N_TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N_L IN_L N_TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_R N_R VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N_R N_R VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N_L N_L VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N_L N_L VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

.control
* DC Operating Point
op
let power = -i(VVDD)*1.8
print power

* AC Analysis
ac dec 20 1MEG 100G
let vout_diff = v(OUT_L) - v(OUT_R)
let gain_mag = mag(vout_diff)
let gain_db = 20*log10(gain_mag)
meas ac diff_gain find gain_db at=1MEG
let gain_3db = diff_gain - 3
meas ac bandwidth when gain_db=gain_3db fall=1

* Transient Analysis
tran 10p 20n
let vout_diff_tran = v(OUT_L) - v(OUT_R)
meas tran vout_max max vout_diff_tran from=10n to=20n
meas tran vout_min min vout_diff_tran from=10n to=20n
let tran_vout_pp = vout_max - vout_min
print tran_vout_pp

quit
.endc
.end
