* I/Q Mixer Testbench
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

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=15.0
.param W_xm10=5.0

* DUT
XM1 N0 LABEL_NET_1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 LABEL_NET_5 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N7 LABEL_NET_6 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 LABEL_NET_8 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 LABEL_NET_9 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N7 LABEL_NET_10 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N6 LABEL_NET_11 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N5 LABEL_NET_12 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 LABEL_NET_13 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Biasing and Loads
VVDD VDD 0 1.8
R1 N0 VDD 1k
R2 N1 VDD 1k
R3 N6 VDD 1k
R4 N7 VDD 1k

V_short_N2 N2 N4 0
V_short_N3 N3 N5 0
I_N8 N8 0 1m

* RF Inputs (100 MHz, 100mV amplitude)
VLABEL_NET_5 LABEL_NET_5 0 DC 1.0 SIN(1.0 100m 100Meg 0 0 0)
VLABEL_NET_8 LABEL_NET_8 0 DC 1.0 SIN(1.0 100m 100Meg 0 0 180)

* LO Inputs (99.75 MHz, 900mV amplitude)
* I-Mixer LO
VLABEL_NET_1 LABEL_NET_1 0 DC 0.9 SIN(0.9 0.9 99.75Meg 0 0 180)
VLABEL_NET_3 LABEL_NET_3 0 DC 0.9 SIN(0.9 0.9 99.75Meg 0 0 0)
VLABEL_NET_9 LABEL_NET_9 0 DC 0.9 SIN(0.9 0.9 99.75Meg 0 0 0)
VLABEL_NET_12 LABEL_NET_12 0 DC 0.9 SIN(0.9 0.9 99.75Meg 0 0 0)

* Q-Mixer LO (90 degree phase shift)
VLABEL_NET_6 LABEL_NET_6 0 DC 0.9 SIN(0.9 0.9 99.75Meg 0 0 270)
VLABEL_NET_10 LABEL_NET_10 0 DC 0.9 SIN(0.9 0.9 99.75Meg 0 0 90)
VLABEL_NET_11 LABEL_NET_11 0 DC 0.9 SIN(0.9 0.9 99.75Meg 0 0 90)
VLABEL_NET_13 LABEL_NET_13 0 DC 0.9 SIN(0.9 0.9 99.75Meg 0 0 270)

* IF Filters
E_I I_diff 0 N0 N1 1
R_I1 I_diff I_diff_1 10k
C_I1 I_diff_1 0 2p
R_I2 I_diff_1 I_diff_2 10k
C_I2 I_diff_2 0 2p
R_I3 I_diff_2 I_diff_f 10k
C_I3 I_diff_f 0 2p

E_Q Q_diff 0 N7 N6 1
R_Q1 Q_diff Q_diff_1 10k
C_Q1 Q_diff_1 0 2p
R_Q2 Q_diff_1 Q_diff_2 10k
C_Q2 Q_diff_2 0 2p
R_Q3 Q_diff_2 Q_diff_f 10k
C_Q3 Q_diff_f 0 2p

* Phase Measurement Filters (Heavy filtering to guarantee clean zero-crossings)
E_I_phase I_phase_in 0 I_diff_f 0 1
R_Ip1 I_phase_in I_p1 10k
C_Ip1 I_p1 0 50p
R_Ip2 I_p1 I_p2 10k
C_Ip2 I_p2 0 50p
R_Ip3 I_p2 I_phase_out 10k
C_Ip3 I_phase_out 0 50p

E_Q_phase Q_phase_in 0 Q_diff_f 0 1
R_Qp1 Q_phase_in Q_p1 10k
C_Qp1 Q_p1 0 50p
R_Qp2 Q_p1 Q_p2 10k
C_Qp2 Q_p2 0 50p
R_Qp3 Q_p2 Q_phase_out 10k
C_Qp3 Q_phase_out 0 50p

.control
op
let power = -i(VVDD) * 1.8 * 1000
print power

tran 1n 20u

* Measure I-channel Conversion Gain (Using RMS to reject high-frequency ripple)
meas tran I_dc avg v(I_diff_f) from=12u to=20u
meas tran I_rms rms v(I_diff_f) from=12u to=20u
let I_ac_rms = sqrt(abs(I_rms * I_rms - I_dc * I_dc))
let I_amp = I_ac_rms * 1.41421356
let CG_linear = I_amp / 200m
let CG_dB = 20 * log10(CG_linear)
print CG_dB

* Measure Q-channel Conversion Gain
meas tran Q_dc avg v(Q_diff_f) from=12u to=20u
meas tran Q_rms rms v(Q_diff_f) from=12u to=20u
let Q_ac_rms = sqrt(abs(Q_rms * Q_rms - Q_dc * Q_dc))
let Q_amp = Q_ac_rms * 1.41421356
let CG_Q_linear = Q_amp / 200m
let CG_Q_dB = 20 * log10(CG_Q_linear)
print CG_Q_dB

* Measure phase difference between I and Q
meas tran I_dc_phase avg v(I_phase_out) from=12u to=20u
meas tran Q_dc_phase avg v(Q_phase_out) from=12u to=20u

meas tran t_I_cross when v(I_phase_out)=I_dc_phase rise=1 from=11.5u to=16.5u
meas tran t_Q_cross when v(Q_phase_out)=Q_dc_phase rise=1 from=11.5u to=16.5u

let phase_diff = (t_Q_cross - t_I_cross) * 250k * 360
print phase_diff

quit
.endc
.end