* SIMO Converter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Switch and Diode models for DCM operation
.model switch_model SW(vt=0.5 vh=0.1 ron=0.2 roff=1Meg)
.model Dideal D(Is=1e-12 Rs=0.1 N=1)

.subckt switch_ideal n1 n2 ctrl
S1 n1 n2 ctrl 0 switch_model
.ends

.subckt switch_ideal_out n1 n2 ctrl
S1 n_mid n1 ctrl 0 switch_model
D1 n2 n_mid Dideal
.ends

* Input Source
V1 Vg 0 dc 1.8

* Original netlist adapted for ngspice syntax and DCM operation
X1 Vg N1 ctrl1 switch_ideal
L1 N1 0 1u
Xa N1 Voa ctrla switch_ideal_out
Xb N1 Vob ctrlb switch_ideal_out
Coa Voa 0 10u
Roa Voa 0 50
Cob Vob 0 10u
Rob Vob 0 50

* Control signals for Time-Multiplexing (1MHz per channel -> 2us total period)
Vctrl1 ctrl1 0 PULSE(0 1 0 1n 1n 0.4u 1u)
Vctrla ctrla 0 PULSE(0 1 0.4u 1n 1n 0.5u 2u)
Vctrlb ctrlb 0 PULSE(0 1 1.4u 1n 1n 0.5u 2u)

.control
tran 10n 3m

* Measure steady-state averages and ripples over the last 100us
meas tran voa_avg avg v(Voa) from=2.9m to=3m
meas tran vob_avg avg v(Vob) from=2.9m to=3m
meas tran voa_max max v(Voa) from=2.9m to=3m
meas tran voa_min min v(Voa) from=2.9m to=3m
meas tran vob_max max v(Vob) from=2.9m to=3m
meas tran vob_min min v(Vob) from=2.9m to=3m
meas tran Iin_avg avg i(V1) from=2.9m to=3m

* Calculate metrics
let voa_ripple = voa_max - voa_min
let vob_ripple = vob_max - vob_min
let Pin = -1.8 * Iin_avg
let Pout_a = (voa_avg * voa_avg) / 50
let Pout_b = (vob_avg * vob_avg) / 50
let output_power = Pout_a + Pout_b
let efficiency = output_power / Pin * 100

print efficiency output_power voa_avg voa_ripple
quit
.endc
.end