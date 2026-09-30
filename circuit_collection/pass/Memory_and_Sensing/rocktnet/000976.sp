* SRAM Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5

VVDD VDD 0 1.8
* Node 1 acts as an active-low Read Wordline for the BLB side
V1 1 0 PULSE(1.8 0 5n 0.1n 0.1n 5n 20n)

* DUT
XM1 N1 DATA VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 BLB DATA 1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 BL 1 1 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 DATA N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 BL 0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 DATA N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 DATA GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 BLB 0 DATA VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 BLB 1 1 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 BL N1 0 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Bitline loads (precharged to VDD)
R_BL BL VDD 100k
R_BLB BLB VDD 100k
C_BL BL 0 10f
C_BLB BLB 0 10f

* Initialize to the stable state (N1=0, DATA=1.8)
.ic v(N1)=0 v(DATA)=1.8 v(BL)=1.8 v(BLB)=1.8
.nodeset v(N1)=0 v(DATA)=1.8 v(BL)=1.8 v(BLB)=1.8

.control
* 1. DC Operating Point for Static Power
op
let static_power = -i(VVDD) * 1.8
print static_power

* 2. Transient Analysis for Read Operation
tran 10p 20n
meas tran read_disturb_voltage min v(DATA)
meas tran read_current max i(V1)

* Calculate Energy per Access
meas tran i_avg avg i(VVDD) from=5n to=20n
let energy_per_access = -i_avg * 1.8 * 15e-9
print energy_per_access

quit
.endc
.end