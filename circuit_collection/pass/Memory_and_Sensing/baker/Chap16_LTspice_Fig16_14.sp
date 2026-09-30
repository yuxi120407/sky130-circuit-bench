* DRAM Sense Amplifier Testbench (Baker CMOS Ch 16)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=1.0  L_xm1=0.15
.param W_xm2=1.0  L_xm2=0.15
.param W_xm3=1.0  L_xm3=0.15
.param W_xm4=1.0  L_xm4=0.15
.param W_xm5=1.0  L_xm5=0.15
.param W_xm6=1.0  L_xm6=0.15
.param W_xm7=1.0  L_xm7=0.15
.param W_xm8=1.0  L_xm8=0.15
.param W_xm9=2.0  L_xm9=0.15
.param W_xm10=2.0 L_xm10=0.15
.param W_xm11=2.0 L_xm11=0.15

* DUT Instance
xm1 NLAT sense_N 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
VDDby2 VDDby2 0 500mV
xm2 bitline1 bitline0 NLAT 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 bitline0 bitline1 NLAT 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
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
xm9 ACT sense_p VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 bitline1 bitline0 ACT VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm11 bitline0 bitline1 ACT VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}

* Control Signal Stimuli (Matching Baker Figure 16.14)
* Eq: High from 0 to 5 ns to equilibrate bitlines to VDD/2
VEq Eq 0 pwl(0 1.8 4.9n 1.8 5.1n 0 30n 0)
* ra0: Word line array0 turns on at 7 ns (access DRAM cell)
Vra0 ra0 0 pwl(0 0 6.9n 0 7.1n 1.8 30n 1.8)
* sense_N: NSA fires at 12 ns
Vsense_N sense_N 0 pwl(0 0 11.9n 0 12.1n 1.8 30n 1.8)
* sense_p: PSA fires at 15 ns (active low)
Vsense_p sense_p 0 pwl(0 1.8 14.9n 1.8 15.1n 0 30n 0)

* Initial conditions
.ic v(bitline0)=250m v(bitline1)=750m v(mb0)=1.0

.control
tran 10p 30n uic

* Measure equilibration voltage at t = 5.0 ns
meas tran v_eq find v(bitline0) at=5.0n

* Measure voltage after charge sharing at t = 11.5 ns (before NSA fires)
meas tran v_final find v(bitline0) at=11.5n

* Calculate delta V bitline
let delta_v = v_final - v_eq
print delta_v

* Measure final bitline voltages after sensing
meas tran v_bl0_end find v(bitline0) at=28n
meas tran v_bl1_end find v(bitline1) at=28n
let diff_swing = v_bl0_end - v_bl1_end
print diff_swing

* Measure NSA sensing delay (reference bitline falling below 0.2V)
meas tran t_nsa trig v(sense_N) val=0.9 rise=1 targ v(bitline1) val=0.2 fall=1

* Measure PSA restore delay (active bitline rising above 1.6V)
meas tran t_psa trig v(sense_p) val=0.9 fall=1 targ v(bitline0) val=1.6 rise=1

quit
.endc
.end