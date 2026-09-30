* Fully-Differential Sample-and-Hold Simulation Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

* Parameter definitions for switches (10u/1u as in Fig 25.19)
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=10.0 L_xm4=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7=10.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0

* Input differential sinusoidal sources at 5 MHz referenced to 500 mV VCM
V1 Vinm 0 SINE(500m -100m 5MEG)
V2 Vinp 0 SINE(500m 100m 5MEG)

* Ideal differential op-amp model (Fig 25.18)
E1 vop N002 vp vm 1e6
E2 N002 vom vp vm 1e6
VCM N002 0 500mV

* Sampling and hold capacitors (1 pF)
C1 vm N001 1e-12
C2 vp N003 1e-12
C3 voutp 0 1e-12
C4 voutm 0 1e-12

* Switches (Fig 25.19)
xm1 N001 phi2 vinp 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N003 phi2 vinm 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 vop phi1 vm 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 vom phi1 vp 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 vop phi3 N001 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N003 phi3 vom 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 voutp phi3 vop 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 vom phi3 voutm 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}

* Non-overlapping Clock Generator: Period T = 20 ns (50 MHz)
* phi1: early turn-off switch (turns off at t1 = 7.5 ns)
Vphi1 phi1 0 PULSE(0 1.8 0.5n 0.2n 0.2n 7.0n 20n)
* phi2: input sampling switch (turns off at t2 = 8.5 ns)
Vphi2 phi2 0 PULSE(0 1.8 0.5n 0.2n 0.2n 8.0n 20n)
* phi3: hold mode switch (turns on at t3 = 10.5 ns, off at 18.5 ns)
Vphi3 phi3 0 PULSE(0 1.8 10.5n 0.2n 0.2n 8.0n 20n)

.control
tran 0.05n 200n

* Calculate differential signals
let vdiff_in = v(vinp) - v(vinm)
let vdiff_out = v(voutp) - v(voutm)
let vcm_out = 0.5 * (v(voutp) + v(voutm))
let vdiff_op_in = v(vp) - v(vm)

* Measure common-mode voltage during hold phase
meas tran meas_vcm_out avg vcm_out from=100n to=200n

* Measure op-amp input virtual short error
meas tran max_vdiff_op_in max abs(vdiff_op_in) from=100n to=200n

* Measure peak input and output differential voltages
meas tran vdiff_in_max max vdiff_in from=100n to=200n
meas tran vdiff_out_max max vdiff_out from=100n to=200n

* Calculate gain
let diff_gain = vdiff_out_max / vdiff_in_max
print meas_vcm_out max_vdiff_op_in vdiff_in_max vdiff_out_max diff_gain

quit
.endc
.end
