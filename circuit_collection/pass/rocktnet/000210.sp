* Testbench for IMD3 Cancellation Passive Network

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Define VDD for completeness
VDD vdd GND 1.8

* DUT: Extracted Netlist (with assumed component values appended for simulation)
I1 n1 GND dc 1m ac 1
R1 n0 GND 50
C1 n0 GND 1p
R2 n0 n1 50
C2 n0 GND 1p
C3 n0 n2 1p
R3 n2 GND 50
I2 n2 GND dc 1m ac 0

.control
* 1. DC Operating Point
op
print v(n0) v(n1) v(n2)
let dc_power = -i(VDD) * 1.8
print dc_power

* 2. AC Analysis (Transimpedance)
ac dec 100 1M 10G
let trans_imp_db = vdb(n0)
let phase = 180/PI * cph(v(n0))

meas ac max_gain MAX trans_imp_db
meas ac bw_freq WHEN trans_imp_db='max_gain-3' FALL=1

* 3. Transient Analysis
tran 10p 10n
meas tran v_max MAX v(n0)
meas tran v_min MIN v(n0)

quit
.endc
.end