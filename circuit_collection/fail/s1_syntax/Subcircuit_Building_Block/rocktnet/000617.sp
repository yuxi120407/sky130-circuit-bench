* Cascode Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=10 L_xm1=1
.param W_xm2=10 L_xm2=1
.param W_xm3=10 L_xm3=1
.param W_xm4=10 L_xm4=1

* DUT (Adapted from generic netlist to SKY130 format)
XM1 I_in I_in N0 GND sky130_fd_pr_nrf_01v8 w={W_xm1} l={L_xm1}
XM2 N0 N0 GND GND sky130_fd_pr_nrf_01v8 w={W_xm2} l={L_xm2}
XM4 N2 N0 GND GND sky130_fd_pr_nrf_01v8 w={W_xm4} l={L_xm4}
XM3 I_out I_in N2 GND sky130_fd_pr_nrf_01v8 w={W_xm3} l={L_xm3}

* Sources
Iin VDD I_in DC 10u AC 1
Vout I_out GND DC 1.0
Vdd VDD GND DC 1.8

.control
* 1. DC Operating Point
op
let i_out_op = -i(Vout)
let i_in_op = 10u
let current_ratio = i_out_op / i_in_op
let power = i_in_op * 1.8 + i_out_op * 1.0
print current_ratio power

* 2. DC Sweep for Rout and Compliance Voltage
dc Vout 0 1.8 0.01
meas dc iout_10 find i(Vout) at=1.0
meas dc iout_11 find i(Vout) at=1.1
let rout = 0.1 / (-(iout_11 - iout_10))
print rout

* Compliance voltage: when Iout drops by 5% from its value at 1.0V
let target_iout = iout_10 * 0.95
meas dc v_compliance find v(I_out) when i(Vout)=target_iout fall=1

* 3. DC Sweep for Linearity
dc Iin 1u 50u 1u
meas dc iout_10u find i(Vout) at=10u
meas dc iout_40u find i(Vout) at=40u
let ratio_10u = -iout_10u / 10u
let ratio_40u = -iout_40u / 40u
print ratio_10u ratio_40u

* 4. AC Analysis for Bandwidth
ac dec 10 1 1G
let current_gain_db = 20*log10(mag(i(Vout)))
meas ac max_gain max current_gain_db
let target_gain = max_gain - 3
meas ac bw_3db when current_gain_db=target_gain fall=1

quit
.endc
.end