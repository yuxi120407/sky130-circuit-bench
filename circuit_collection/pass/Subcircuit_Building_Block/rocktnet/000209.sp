* PMOS Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 VR N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}

VVDD VDD 0 1.8
Iref N3 0 dc 10u ac 1
Vout VR 0 dc 0.9 ac 0

.control
* 1. Operating Point (Current Gain and Power)
op
let i_out = i(Vout)
let i_ref = 10u
let current_gain_linear = i_out / i_ref
let current_gain_db = 20 * log10(current_gain_linear)
let power = -i(VVDD) * 1.8
print current_gain_linear current_gain_db power

* 2. AC Analysis 1: Bandwidth
ac dec 10 1 100G
let i_out_ac = mag(i(Vout))
let current_gain_ac_db = 20 * log10(i_out_ac)
meas ac dc_gain find current_gain_ac_db at=10
let gain_3db = dc_gain - 3
meas ac bandwidth when current_gain_ac_db=gain_3db fall=1

* 3. AC Analysis 2: Output Resistance
alter Iref ac = 0
alter Vout ac = 1
ac dec 10 1 100G
let rout = 1 / mag(i(Vout))
meas ac rout_dc find rout at=10

* 4. DC Sweep: Compliance Voltage
dc Vout 0 1.8 0.01
* Find the voltage where output current drops to 9uA (10% drop from 10uA nominal)
meas dc compliance_voltage when i(Vout)=9u fall=1

quit
.endc
.end
