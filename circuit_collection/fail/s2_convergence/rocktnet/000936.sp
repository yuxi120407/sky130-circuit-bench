* Switched-Capacitor Interface Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_dummy=0.5

.param W_dummy=1.0 L_dummy=0.15

* Subcircuits for ideal components
.subckt amplifier n1 n2 n3
* n1=out, n2=in-, n3=in+
G1 0 n1 n3 n2 1m
R1 n1 0 1Meg
C1 n1 0 1p
.ends

.subckt switch_ideal n1 n2
R1 n1 n2 1k
.ends

* Power and Inputs
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 DC 0.9 AC 1
VLABEL_NET_2 LABEL_NET_2 0 DC 0.9

* DUT (Adapted for standard SPICE syntax)
XA1 N0 N1 GND amplifier
XA2 VDD N9 GND amplifier
XA3 N11 N7 N3 amplifier
C1 VDD VDD 1p
C2 VDD VDD 1p
C3 N4 N10 1p
C4 N0 LABEL_NET_0 1p
C5 GND GND 1p
C6 N12 GND 1p
C7 GND GND 1p
C8 GND GND 1p
C9 VDD N11 1p
C10 VDD N6 1p
C11 N9 GND 1p
C12 N3 GND 1p
C13 N2 GND 1p
C14 VDD N8 1p
C15 GND GND 1p
XS1 N4 N11 switch_ideal
C16 N7 GND 1p
C17 N5 N5 1p
XS2 GND GND switch_ideal
C18 VDD N1 1p
XS3 N5 N11 switch_ideal
XS4 VDD N11 switch_ideal
XS5 N0 N1 switch_ideal
XS6 N2 N3 switch_ideal
C19 N6 N11 1p
XS7 N5 LABEL_NET_2 switch_ideal
XS8 GND GND switch_ideal
C20 N7 GND 1p
XS9 GND GND switch_ideal
XS10 N7 N12 switch_ideal
XS11 N10 N10 switch_ideal
XS12 GND GND switch_ideal
XS13 N0 N6 switch_ideal
XS14 N9 GND switch_ideal
XS15 N6 N8 switch_ideal

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 10 1 10Meg
let gain_db = vdb(N0)
meas ac low_freq_gain find gain_db at=100
meas ac bw when gain_db=0 fall=1

tran 1u 1m
meas tran v_out_max max v(N0)
meas tran v_out_min min v(N0)

quit
.endc
.end
