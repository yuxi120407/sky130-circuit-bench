* Standing-Wave Oscillator Equivalent Circuit Testbench
.param Cval=0.84p
.param Lval=100p
.param Rval=500

Iinj1 GND V1 dc 0 ac 1
R_gd_A_1 V1 GND {Rval}
RL_1 V1 GND {Rval}
C_1 V1 GND {Cval}
LA_1 V1 N1 Lval
LB_2 N1 GND Lval
LA_2 N1 V2 Lval
C_2 V2 GND {Cval}
RL_2 V2 GND {Rval}
R_gd_A_2 V2 GND {Rval}
Iinj2 GND V2 dc 0 ac 1

.control
ac dec 500 1G 50G
let z11 = mag(v(V1))
meas ac zmax MAX z11
let z3db = zmax / 1.41421356
meas ac f_low WHEN z11=z3db RISE=1
meas ac f_high WHEN z11=z3db FALL=1
let f_res = (f_low + f_high) / 2
let bw = f_high - f_low
let q_factor = f_res / bw
print f_res zmax q_factor
quit
.endc
.end
