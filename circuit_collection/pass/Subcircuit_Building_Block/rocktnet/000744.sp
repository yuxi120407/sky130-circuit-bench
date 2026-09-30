* Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5

XM2 OUT1 BL GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 BL BL GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Power supply (used as reference)
VVDD VDD 0 1.8

* Output voltage source (holds OUT1 at 0.9V for nominal operation)
Vout OUT1 0 0.9

* Input current source (DC 10uA, AC 1A, Pulse 0 to 10uA)
Iin VDD BL_in DC 10u AC 1 PULSE(0 10u 1n 0.1n 0.1n 10n 20n)
Vmeas_in BL_in BL 0

* CCVS to convert currents to voltages for AC measurement
H1 out_meas 0 Vout -1
H2 in_meas 0 Vmeas_in 1

.control
* 1. DC Sweep for Output Resistance and Vmin
dc Vout 0 1.8 0.01
let i_out = -i(Vout)
meas dc iout_09 find i_out at=0.9
meas dc iout_10 find i_out at=1.0
let rout_approx = 0.1 / (iout_10 - iout_09)
print rout_approx

let iout_target = 0.9 * iout_09
meas dc vmin find v(OUT1) when i_out=iout_target

* 2. AC Analysis for Bandwidth
ac dec 20 1k 100G
let gain_db = vdb(out_meas) - vdb(in_meas)
meas ac dc_gain_db find gain_db at=1k
let gain_db_3db = dc_gain_db - 3
meas ac bw_3db when gain_db=gain_db_3db fall=1

* 3. Transient Analysis for Delay
tran 0.1n 20n
let i_out_tran = -i(Vout)
let i_in_tran = i(Vmeas_in)
meas tran t_delay trig i_in_tran val=5u rise=1 targ i_out_tran val=5u rise=1

* 4. DC Operating Point for Current Ratio
op
let i_out_op = -i(Vout)
let i_in_op = i(Vmeas_in)
let current_ratio = i_out_op / i_in_op
print current_ratio

quit
.endc
.end