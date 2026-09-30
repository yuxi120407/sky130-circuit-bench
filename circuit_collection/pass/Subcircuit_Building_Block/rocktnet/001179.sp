* LC Network Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param C_shunt=2p C_series=10p

* DUT
L1 VDD N2 17nH
L2 VDD N1 17nH
C2 LABEL_NET_0 GND {C_shunt}
C1 LABEL_NET_2 GND {C_shunt}
C3 N1 LABEL_NET_0 {C_series}
C4 N2 LABEL_NET_2 {C_series}

* Biasing and stimuli
VVDD VDD 0 1.8
VLABEL_NET_0_bias LABEL_NET_0_bias 0 0.9
VLABEL_NET_2_bias LABEL_NET_2_bias 0 0.9

* Large resistors to apply DC bias without loading the AC signal
Rbias1 LABEL_NET_0 LABEL_NET_0_bias 100k
Rbias2 LABEL_NET_2 LABEL_NET_2_bias 100k

* Parallel resistors to model inductor loss / tank Q
R_tank1 N1 VDD 1k
R_tank2 N2 VDD 1k

* AC Current sources for differential excitation
I1 0 N1 DC 0 AC 1
I2 0 N2 DC 0 AC -1

.control
ac dec 100 100Meg 10G
let v_diff_out = v(LABEL_NET_0) - v(LABEL_NET_2)
let z_trans = mag(v_diff_out) / 2

meas ac max_z_trans MAX z_trans
let z_3db = max_z_trans / 1.4142
meas ac f_low WHEN z_trans=z_3db RISE=1
meas ac f_high WHEN z_trans=z_3db FALL=1
let f_center = (f_low + f_high) / 2
let bw = f_high - f_low
let Q = f_center / bw

print f_center max_z_trans bw Q
quit
.endc
.end