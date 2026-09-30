* Continuous-Time FIR Filter Tap Delay Cell
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 OUT_MINUS OUT_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT_MINUS IN_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}

VVDD VDD 0 1.8
VIN_PLUS IN_PLUS 0 DC 0.9 AC 1 SIN(0.9 0.1 100MEG 0 0)

* Bias current sink to ground to enable operation
Ibias OUT_MINUS 0 115u
* Load capacitance to set bandwidth and delay
Cload OUT_MINUS 0 50f

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 100 1MEG 10G
let gain_db = vdb(OUT_MINUS)
meas ac dc_gain find gain_db at=1MEG
let gain_db_3db = dc_gain - 3
meas ac bw_3db when gain_db=gain_db_3db fall=1

* Calculate group delay from phase derivative
let phase_rad = cph(v(OUT_MINUS))
let group_delay = -1 * deriv(phase_rad) / (2 * 3.14159265359)
meas ac delay_100M find group_delay at=100MEG

tran 10p 30n
meas tran t_in trig v(IN_PLUS) val=0.9 rise=2
meas tran t_out trig v(OUT_MINUS) val=0.9 fall=2
let delay_tran = t_out - t_in
print delay_tran

quit
.endc
.end
