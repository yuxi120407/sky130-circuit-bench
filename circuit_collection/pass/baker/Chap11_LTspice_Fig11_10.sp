* CMOS Inverter Characterization Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=1.0
.param L_xm1=0.15
.param W_xm2=2.0
.param L_xm2=0.15

* DUT
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}

* Load capacitor
Cload Vout 0 10f

* Input source for transient analysis
Vin Vin 0 pulse(0 1.8 0.5n 50p 50p 2n 4.1n)

.control
* === 1. DC Transfer Analysis ===
dc Vin 0 1.8 0.001

let vdiff = v(vout) - v(vin)
meas dc switching_point_voltage when vdiff=0

meas dc voh max v(vout)
meas dc vol min v(vout)

let ivdd_dc = -i(VDD)
meas dc peak_crossing_current max ivdd_dc

let dvout = deriv(v(vout))
meas dc input_low_voltage when dvout=-1 fall=1
meas dc input_high_voltage when dvout=-1 rise=1

let noise_margin_low = $&input_low_voltage - $&vol
let noise_margin_high = $&voh - $&input_high_voltage

print switching_point_voltage input_low_voltage input_high_voltage noise_margin_low noise_margin_high peak_crossing_current

* === 2. Transient Analysis ===
tran 10p 8.2n

meas tran propagation_delay_hl trig v(vin) val=0.9 rise=1 targ v(vout) val=0.9 fall=1
meas tran propagation_delay_lh trig v(vin) val=0.9 fall=1 targ v(vout) val=0.9 rise=1

let tpd = 0.5 * ($&propagation_delay_hl + $&propagation_delay_lh)

let ivdd_tran = -i(VDD)
meas tran iavg avg ivdd_tran from=0.5n to=4.6n

let average_dynamic_power = $&iavg * 1.8
let power_delay_product = $&average_dynamic_power * $&tpd

print propagation_delay_hl propagation_delay_lh average_dynamic_power power_delay_product

quit
.endc
.end