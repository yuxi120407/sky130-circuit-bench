* Testbench for PMOS Current Mirror (Baker Fig 20.11a)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param W_xm2=5.0

* Parameter definitions
.param W_xm1=10.0 L_xm1=1.0 W_xm2=10.0 L_xm2=1.0

* Circuit DUT
xm2 0 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
IREF N001 0 10u

.control
* Set ascii filetype
set filetype=ascii

* 1. Operating Point Analysis at nominal VDD = 1.8V
op

* Total supply current: i(VDD) = -(I_M1 + I_M2)
* I_REF is fixed to 10u through xm1
let i_ref = 10u
let i_total = -i(VDD)
let i_o = i_total - i_ref
let ratio = i_o / i_ref
let v_sg = 1.8 - v(N001)
let v_ov = v_sg - 0.42
let v_sd_min = v_ov
let r_o = 1.0 / (0.1 * i_o)

print i_ref i_o ratio v_sg v_ov v_sd_min r_o

* 2. DC Sweep over VDD to calculate supply sensitivity (similar to Baker Fig 20.11b)
dc VDD 0.9 1.8 0.01

let io_sweep = -i(VDD) - 10u
let dio_dvdd = deriv(io_sweep)
let iref_sweep = 10u + 0*v(VDD)
let diref_dvdd = deriv(iref_sweep)

meas dc io_at_1v find io_sweep at=1.0
meas dc io_at_1v8 find io_sweep at=1.8
meas dc dio_dvdd_at_1v8 find dio_dvdd at=1.8
meas dc diref_dvdd_val find diref_dvdd at=1.8

print io_at_1v io_at_1v8 dio_dvdd_at_1v8 diref_dvdd_val
quit
.endc
.end
