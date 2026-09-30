* TIA Testbench
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

* DUT
XM1 N4 N12 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N12 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N11 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N7 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N12 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Biasing, Loads, and Feedback
VDD VDD GND 1.8
L1 VDD N_L1 0.5n
Rload1 N_L1 N4 1k
Rload2 VDD N3 1k
Rf N4 N12 1k

* Input Source (Photodiode model: 0.1pF cap + 10Gb/s current pulse)
Iin N12 GND DC 0 AC 1u PULSE(0 10u 10p 10p 10p 40p 100p)
Cin N12 GND 0.1p

.control
* DC Operating Point & Power
op
let power = -i(VDD) * 1.8
print power

* AC Analysis for Gain and Bandwidth
ac dec 100 1M 100G
* Zt in dB = 20*log10(Vout/Iin). With Iin=1uA, Zt_dB = vdb(N4) + 120
let zt_db = vdb(N4) + 120
meas ac zt_dc find zt_db at=10M
let zt_3db = zt_dc - 3
meas ac bw when zt_db=zt_3db fall=1

* Transient Analysis for 10Gb/s eye/swing
tran 1p 500p
meas tran vout_max max v(N4)
meas tran vout_min min v(N4)
let vout_swing = vout_max - vout_min
print vout_swing

quit
.endc
.end
