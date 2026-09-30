* Testbench for NMOS LNA core
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5

XM1 VOUT N4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

Vdd VDD GND 1.8
Rd VDD VOUT 2k
Vin N4 GND dc 0.9 ac 1
Vsrc N2 GND 0

.control
op
let power = -i(Vdd) * 1.8
print power

ac dec 100 1Meg 100G
let gain_db = vdb(VOUT)
meas ac max_gain MAX gain_db
let gain_3db = max_gain - 3
meas ac bw WHEN gain_db=gain_3db FALL=1

quit
.endc
.end
