* Capacitor Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Test setup components
V1 IN 0 dc 0 ac 1
R1 IN OUT+ 1Meg
V2 OUT- 0 dc 0

* DUT
C1 OUT+ OUT- 400f
C2 OUT- OUT+ 400f

.control
ac dec 100 1k 10Meg
let gain_db = vdb(OUT+)
meas ac f3db when gain_db=-3.0103 fall=1
let measured_cap = 1 / (2 * 3.1415926535 * 1e6 * f3db)
print f3db
print measured_cap
quit
.endc
.end
