* Diode-Connected PMOS Array Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm3a=0.5
.param L_xm3b=0.5
.param L_xm3c=0.5
.param L_xm3d=0.5
.param L_xm3e=0.5

.param W_xm3a=5.0 L_xm3a=0.5
.param W_xm3b=5.0 L_xm3b=0.5
.param W_xm3c=5.0 L_xm3c=0.5
.param W_xm3d=5.0 L_xm3d=0.5
.param W_xm3e=5.0 L_xm3e=0.5

* Supply and Bias
VVDD VDD 0 1.8
Ibias N0 0 10u ac 1

* DUT
XM3A N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3a} w={W_xm3a}
XM3B N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3b} w={W_xm3b}
XM3C N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3c} w={W_xm3c}
XM3D N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3d} w={W_xm3d}
XM3E N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3e} w={W_xm3e}

.control
* DC Operating Point
op
let v_n0 = v(N0)
let v_sg = 1.8 - v(N0)
let pwr_device = v_sg * 10u
print v_n0 v_sg pwr_device

* AC Analysis for Impedance (R_eq)
ac dec 10 1 1G
let z_out_db = vdb(N0)
meas ac z_out_db_1k find z_out_db at=1k

* DC Sweep for I-V characteristics
dc Ibias 0 50u 1u
meas dc v_n0_at_20u find v(N0) at=20u
meas dc v_n0_at_50u find v(N0) at=50u

quit
.endc
.end