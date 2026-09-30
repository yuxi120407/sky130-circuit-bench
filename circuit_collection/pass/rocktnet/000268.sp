* Testbench for Pseudo-Differential Gm Cell
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 IO_PLUS VI_MINUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 IO_MINUS VI_PLUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 IO_PLUS VB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 IO_MINUS VB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VVB VB 0 0.6

* Input common mode voltage
.param VCM=0.9
VIN_PLUS VI_PLUS 0 dc {VCM} ac 0.5 sin({VCM} 0.01 2Meg 0 0 0)
VIN_MINUS VI_MINUS 0 dc {VCM} ac 0.5 180 sin({VCM} 0.01 2Meg 0 0 180)

* Ideal CMFB to set output common-mode to 0.9V without affecting differential gain
B_CMFB1 IO_PLUS 0 I='((v(IO_PLUS)+v(IO_MINUS))/2 - 0.9) * 1e-2'
B_CMFB2 IO_MINUS 0 I='((v(IO_PLUS)+v(IO_MINUS))/2 - 0.9) * 1e-2'

* Load capacitors
CL1 IO_PLUS 0 100f
CL2 IO_MINUS 0 100f

* Differential output for easy measurement
E_DIFF VDIFF 0 IO_PLUS IO_MINUS 1.0

.control
* DC Analysis
op
let dc_power = -i(VVDD) * 1.8
print dc_power

* AC Analysis
ac dec 100 1k 10G
let gain_db = db(v(VDIFF))
meas ac dc_gain find gain_db at=10k
let gain_3db = dc_gain - 3
meas ac f3db when gain_db=gain_3db fall=1
print dc_gain f3db

* Transient Analysis
tran 5n 10u
meas tran vout_max max v(VDIFF) from=8u to=10u
meas tran vout_min min v(VDIFF) from=8u to=10u
let tran_swing = vout_max - vout_min
print tran_swing

quit
.endc
.end