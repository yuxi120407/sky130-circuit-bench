* Differential Input Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_n=20.0 L_n=0.15 I_bias=2m

* Supplies (Using negative supply to keep GND at 0V as in original netlist)
VEE VEE 0 DC -1.8

* Input Sources (50 ohm source impedance, 2V AC yields 1V at the node due to 50 ohm termination)
VIN1 in1_src 0 DC 0 AC 2 PULSE(-0.2 0.2 1n 10p 10p 1n 2n)
RS1 in1_src in1 50
VIN2 in2_src 0 DC 0 AC 0
RS2 in2_src in2 50

* DUT (Adapted to SKY130 NMOS from generic npn)
R1 0 in1 50
R2 0 in2 50
XM2 0 in1 out1 VEE sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
XM1 0 in2 out2 VEE sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
I2 out1 VEE {I_bias}
I1 out2 VEE {I_bias}

.control
* DC Operating Point
op
let power_consumption = abs(i(VEE) * 1.8)
print power_consumption

* AC Analysis
ac dec 100 1M 100G
let gain_db = db(v(out1)) - db(v(in1))
meas ac voltage_gain find gain_db at=1M
let gain_target = voltage_gain - 3
meas ac bandwidth when gain_db=gain_target fall=1
print voltage_gain
print bandwidth

* Transient Analysis
tran 1p 5n
meas tran vout_min min v(out1)
meas tran vout_max max v(out1)
let v10 = vout_min + 0.1*(vout_max - vout_min)
let v90 = vout_min + 0.9*(vout_max - vout_min)
meas tran rise_time trig v(out1) val=v10 rise=1 targ v(out1) val=v90 rise=1
print rise_time
.endc
.end