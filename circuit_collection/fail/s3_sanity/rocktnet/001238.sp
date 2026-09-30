* CMOS Transconductor Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmc1=0.5
.param L_xmc10=0.5
.param L_xmc11=0.5
.param L_xmc12=0.5
.param L_xmc13=0.5
.param L_xmc14=0.5
.param L_xmc15=0.5
.param L_xmc2=0.5
.param L_xmc3=0.5
.param L_xmc4=0.5
.param L_xmc5=0.5
.param L_xmc6=0.5
.param L_xmc7=0.5
.param L_xmc8=0.5
.param L_xmc9=0.5

.param W_xmc14=5.0 L_xmc14=0.5
.param W_xmc11=5.0 L_xmc11=0.5
.param W_xmc2=5.0 L_xmc2=0.5
.param W_xmc5=5.0 L_xmc5=0.5
.param W_xmc4=5.0 L_xmc4=0.5
.param W_xmc7=5.0 L_xmc7=0.5
.param W_xmc12=5.0 L_xmc12=0.5
.param W_xmc8=5.0 L_xmc8=0.5
.param W_xmc10=5.0 L_xmc10=0.5
.param W_xmc13=5.0 L_xmc13=0.5
.param W_xmc3=5.0 L_xmc3=0.5
.param W_xmc1=5.0 L_xmc1=0.5
.param W_xmc15=5.0 L_xmc15=0.5
.param W_xmc9=5.0 L_xmc9=0.5
.param W_xmc6=5.0 L_xmc6=0.5

XMC14 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc14} w={W_xmc14}
XMC11 N5 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc11} w={W_xmc11}
XMC2 N0 VB2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xmc2} w={W_xmc2}
XMC5 OUT_N VB2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xmc5} w={W_xmc5}
XMC4 N5 OUT_P N1 GND sky130_fd_pr__nfet_01v8 l={L_xmc4} w={W_xmc4}
XMC7 N4 VB1 GND GND sky130_fd_pr__nfet_01v8 l={L_xmc7} w={W_xmc7}
XMC12 OUT_N N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc12} w={W_xmc12}
XMC8 N1 VB1 GND GND sky130_fd_pr__nfet_01v8 l={L_xmc8} w={W_xmc8}
XMC10 N6 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc10} w={W_xmc10}
XMC13 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc13} w={W_xmc13}
XMC3 N0 VB2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xmc3} w={W_xmc3}
XMC1 N6 OUT_N N1 GND sky130_fd_pr__nfet_01v8 l={L_xmc1} w={W_xmc1}
XMC15 OUT_P N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc15} w={W_xmc15}
XMC9 N3 VB1 GND GND sky130_fd_pr__nfet_01v8 l={L_xmc9} w={W_xmc9}
XMC6 OUT_P VB2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xmc6} w={W_xmc6}

VVDD VDD 0 1.8
VVB2 VB2 0 0.54
VVB1 VB1 0 0.54

* Input resistors (as described in paper) and DC bias injection to balance CMFB
R_in_p Vin_p N3 10k
R_in_n Vin_n N4 10k
V_in_p Vin_p 0 DC 0.206 AC 0.5 SIN(0.206 10m 1Meg)
V_in_n Vin_n 0 DC 0.206 AC -0.5 SIN(0.206 -10m 1Meg)

* Typical OTA load
C_out_p OUT_P 0 1p
C_out_n OUT_N 0 1p

.control
op
let power = -i(VVDD) * 1.8
print power
print v(OUT_P) v(OUT_N) v(N3) v(N4)

ac dec 100 1k 1G
let vout_diff = v(OUT_P) - v(OUT_N)
let gain_db = 20 * log10(mag(vout_diff))
let phase = 180/PI * cph(vout_diff)

meas ac dc_gain find gain_db at=1k
meas ac bw_3db when gain_db=(dc_gain-3) fall=1
meas ac ugf when gain_db=0 fall=1
meas ac pm find phase when gain_db=0 fall=1

tran 10n 5u
meas tran vout_p_max max v(OUT_P)
meas tran vout_p_min min v(OUT_P)
let swing = vout_p_max - vout_p_min
print swing
fourier 1Meg v(OUT_P)
quit
.endc
.end
