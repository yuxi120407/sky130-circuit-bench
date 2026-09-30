* NMOS Switch Characterization Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5

* DUT
XM1 VOUT VRESET GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Voltage Sources
VRESET VRESET 0 DC 0
VOUT VOUT 0 DC 1.8

.control
* 1. Measure OFF-state Leakage (VRESET=0V, VOUT=1.8V)
op
let i_leakage = -i(VOUT)
print i_leakage

* 2. Measure ON-state Resistance (VRESET=1.8V, VOUT=0.1V)
alter VRESET = 1.8
alter VOUT = 0.1
op
let r_on = 0.1 / -i(VOUT)
print r_on

* 3. Measure Threshold Voltage (VOUT=1.8V, sweep VRESET)
alter VOUT = 1.8
dc VRESET 0 1.8 0.01
let id = -i(VOUT)
* Find Vth at a constant current threshold (e.g., 1uA * W/L=10uA)
meas dc vth_meas find v(VRESET) when id=10u

quit
.endc
.end