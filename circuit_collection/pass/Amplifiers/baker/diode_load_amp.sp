* Common-Source Amplifier with Diode-Connected Load Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Define parameters used in the DUT
.param L_XM_INPUT=1
.param W_XM_INPUT=10
.param L_XM_LOAD=1
.param W_XM_LOAD=10

* --- DUT ---
.global VDD GND
.temp 27

XM_INPUT VOUT VIN GND GND sky130_fd_pr__nfet_01v8 l={L_XM_INPUT} w={W_XM_INPUT}

* Diode-connected load (PMOS)
XM_LOAD VOUT VOUT VDD VDD sky130_fd_pr__pfet_01v8 l={L_XM_LOAD} w={W_XM_LOAD}

* Load capacitor
CL VOUT GND 10e-15

VIN VIN GND DC 0.6 AC 1

* Supply
VDD VDD GND DC 1.8
* -----------

* Stimulus for Output Resistance
IOUT GND VOUT DC 0 AC 0

.control
* 1. DC Operating Point & Power
op
let power_consumption = -i(VDD) * 1.8
print power_consumption

* 2. AC Analysis for Gain and Bandwidth
alter @VIN[ac]=1
alter @IOUT[ac]=0
ac dec 100 1 100G

let gain_mag = mag(v(VOUT))
let gain_db = vdb(VOUT)

* Measure low-frequency gain
meas ac voltage_gain MAX gain_mag
meas ac dc_gain_db MAX gain_db

* Measure -3dB bandwidth
let f3db_target = dc_gain_db - 3
meas ac bandwidth WHEN gain_db=f3db_target FALL=1

* 3. AC Analysis for Output Resistance
alter @VIN[ac]=0
alter @IOUT[ac]=1
ac dec 10 1 100G

let rout_mag = mag(v(VOUT))
meas ac output_resistance MAX rout_mag

quit
.endc
.end