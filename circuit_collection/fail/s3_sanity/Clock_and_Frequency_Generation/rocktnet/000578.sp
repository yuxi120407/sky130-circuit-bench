* Testbench for 4-channel CML buffer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm8=5.0 L_xm8=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm9=5.0 L_xm9=0.5

XM8 VDD N4 P3 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM3 N4 P3_BAR N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM1 N0 P1_BAR N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM7 VDD N3 P4 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM4 N3 P4_BAR N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM10 VDD N0 P1 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM6 N11 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM2 N2 P2_BAR N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM5 N1 BIAS N11 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM9 VDD N2 P2 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

VVDD VDD 0 1.8
VBIAS BIAS 0 1.0

* Missing load resistors for CML
R1 VDD N0 1k
R2 VDD N2 1k
R3 VDD N4 1k
R4 VDD N3 1k

* Missing pull-down resistors for source followers
RP1 P1 0 1k
RP2 P2 0 1k
RP3 P3 0 1k
RP4 P4 0 1k

* Inputs (25% duty cycle pulses)
VP1 P1_BAR 0 DC 1.5 AC 1 PULSE(1.2 1.8 0 5p 5p 23.3p 133.3p)
VP2 P2_BAR 0 DC 1.5 PULSE(1.2 1.8 33.3p 5p 5p 23.3p 133.3p)
VP3 P3_BAR 0 DC 1.5 PULSE(1.2 1.8 66.6p 5p 5p 23.3p 133.3p)
VP4 P4_BAR 0 DC 1.5 PULSE(1.2 1.8 100p 5p 5p 23.3p 133.3p)

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 10 100MEG 100G
let vout_db = db(v(P1))
meas ac dc_gain find vout_db at=100MEG
let gain_3db = dc_gain - 3
meas ac bandwidth when vout_db="$&gain_3db" fall=1
print dc_gain bandwidth

tran 1p 400p
meas tran v_max max v(P1) from=100p to=300p
meas tran v_min min v(P1) from=100p to=300p
let v_swing = v_max - v_min
let v_mid = v_min + 0.5 * v_swing
meas tran t_delay trig v(P1_BAR) val=1.5 rise=1 td=100p targ v(P1) val="$&v_mid" fall=1 td=100p

print v_swing t_delay
quit
.endc
.end