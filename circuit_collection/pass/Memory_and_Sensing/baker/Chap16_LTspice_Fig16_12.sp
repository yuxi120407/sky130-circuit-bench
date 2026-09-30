* DRAM Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0

* Parameters for the netlist
.param W_xm1=2 W_xm2=1 W_xm3=1 W_xm4=1 W_xm5=1 W_xm6=1 W_xm7=1 W_xm8=1
.param L_xm1=0.15 L_xm2=0.15 L_xm3=0.15 L_xm4=0.15 L_xm5=0.15 L_xm6=0.15 L_xm7=0.15 L_xm8=0.15

* --- DUT START ---
xm1 N001 sense_N 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
VDDby2 VDDby2 0 500mV
xm2 bitline1 bitline0 N001 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 bitline0 bitline1 N001 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 bitline1 Eq bitline0 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 bitline0 Eq VDDby2 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 VDDby2 Eq bitline1 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
Ccol1 bitline1 0 1e-13
Ccol0 bitline0 0 1e-13
xm7 bitline0 ra0 mb0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
Cmbit0 mb0 0 2e-14
xm8 bitline1 ra1 mb1 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
Cmbit1 mb1 0 2e-14
Vsn1 ra1 0 0
* --- DUT END ---

* Stimulus
V_Eq Eq 0 PWL(0 1.8 5n 1.8 5.1n 0)
V_ra0 ra0 0 PWL(0 0 7n 0 7.1n 1.8)
V_sense_N sense_N 0 PWL(0 0 12n 0 12.1n 1.8)

* Initial conditions: precharge bitlines to 0.9V, store '1' (1.8V) in mb0, '0' in mb1
.ic v(mb0)=1.8 v(mb1)=0 v(bitline0)=0.9 v(bitline1)=0.9

.control
* Fix the hardcoded 500mV VDDby2 in the netlist to 0.9V for a 1.8V VDD system
alter VDDby2 0.9

tran 0.1n 25n

* Measure final bitline voltage after charge sharing (at 11ns, before sense amp fires)
meas tran v_final_sim find v(bitline0) at=11n
meas tran v_ref_sim find v(bitline1) at=11n

* Calculate Delta V bit
let delta_v = v_final_sim - v_ref_sim
print delta_v

quit
.endc
.end
