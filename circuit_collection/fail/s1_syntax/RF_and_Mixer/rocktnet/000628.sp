* RF Front-End Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_lo=0.5
.param L_rf=0.5

.param R_load=5k
.param R_tail=1k
.param W_rf=10.0 L_rf=0.15
.param W_lo=10.0 L_lo=0.15

* Modified DUT: Changed Q to M and npn to sky130_fd_pr__nfet_01v8 to use SKY130 MOSFETs
R1 V1 VDD {R_load}
R2 V2 VDD {R_load}
R3 E3 GND {R_tail}
M1 E1 IN1 E3 GND sky130_fd_pr__nfet_01v8 W={W_rf} L={L_rf}
M2 E2 GND E3 GND sky130_fd_pr__nfet_01v8 W={W_rf} L={L_rf}
M3 V1 IN+ E1 GND sky130_fd_pr__nfet_01v8 W={W_lo} L={L_lo}
M4 V2 IN- E1 GND sky130_fd_pr__nfet_01v8 W={W_lo} L={L_lo}
M5 V1 IN- E2 GND sky130_fd_pr__nfet_01v8 W={W_lo} L={L_lo}
M6 V2 IN+ E2 GND sky130_fd_pr__nfet_01v8 W={W_lo} L={L_lo}

VGND GND 0 0

VVDD VDD 0 1.8
* RF input at 2.001 GHz, 10mV amplitude
VIN1 IN1 0 DC 0.7 SIN(0.7 0.01 2.001G 0 0)
* Differential LO at 2.000 GHz, 300mV amplitude
VINp IN+ 0 DC 1.2 SIN(1.2 0.3 2.000G 0 0)
VINn IN- 0 DC 1.2 SIN(1.2 0.3 2.000G 0 180)

B1 out_diff 0 V=v(V1)-v(V2)

.control
op
let power = -i(VVDD) * 1.8
print power
print v(V1) v(V2) v(E1) v(E3)

* Transient analysis to capture 1MHz IF (1us period)
tran 10p 3u
meas tran vout_max max v(out_diff) from=2u to=3u
meas tran vout_min min v(out_diff) from=2u to=3u
let vout_pp = vout_max - vout_min
let vout_amp = vout_pp / 2
let gain_linear = vout_amp / 0.01
let gain_db = 20 * log10(gain_linear)
print gain_db
quit
.endc
.end
