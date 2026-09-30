* Rectifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N1 IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N1 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT N1 GND VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VVSS VSS 0 0
VGND GND 0 0
* 10Hz AC input representing piezoelectric harvester
VIN IN 0 DC 0.9 AC 1 SIN(0.9 0.9 10 0 0)

* 1uF load capacitor as reported in paper
CLOAD OUT 0 1u
RLOAD OUT 0 1MEG

.control
* Transient analysis for 1 second (10 cycles)
tran 1m 1
meas tran vout_dc avg v(out) from=0.5 to=1
meas tran vout_max max v(out) from=0.5 to=1
meas tran vout_min min v(out) from=0.5 to=1
let ripple = vout_max - vout_min
print ripple

meas tran ivdd_avg avg i(VVDD) from=0.5 to=1
let power = -ivdd_avg * 1.8
print power

let energy_per_cycle = power * 0.1
print energy_per_cycle

* DC sweep to observe switching threshold
dc VIN 0 1.8 0.01
meas dc vout_at_0 find v(out) at=0
meas dc vout_at_1_8 find v(out) at=1.8

quit
.endc
.end
