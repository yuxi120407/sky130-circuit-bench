* Testbench for Baker CMOS Chapter 9 - Example 9.5 Differential Circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=30.0 L_xm3=1.0
.param W_xm4=30.0 L_xm4=1.0

* Circuit Netlist (DUT)
xm2 vd24 N001 vs12 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
VDD VDD 0 1.8
Ibias vs12 0 40u
xm1 vd13 vg1 vs12 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 vd24 0 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 vd13 vd13 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
VG1 vg1 0 DC 0.9 AC 1m SIN(0.9 1m 10k)
VG2 N001 0 0.9

* Zero-volt sources to accurately measure drain currents
* (as discussed in Fig. 9.9)

.control
save all

* 1. Operating Point Analysis
op

let v_vs12 = v(vs12)
let v_vd13 = v(vd13)
let v_vd24 = v(vd24)
let v_vgs1 = v(vg1) - v(vs12)
let v_vsg3 = v(vdd) - v(vd13)
let v_vsd4 = v(vdd) - v(vd24)

* Drain current in M4 is half tail current = 20uA
let rch_m4_calc = v_vsd4 / 20e-6

print v_vs12 v_vd13 v_vd24 v_vgs1 v_vsg3 v_vsd4 rch_m4_calc

* 2. AC Analysis
ac dec 100 1 10k

let gain_vd13 = v(vd13) / 1m
let gain_vd24 = v(vd24) / 1m
let gain_vd13_db = vdb(vd13) + 60
let gain_vd24_db = vdb(vd24) + 60

meas ac av_vd13_lf find gain_vd13 at=1k
meas ac av_vd24_lf find gain_vd24 at=1k
meas ac av_vd13_mag find v(vd13) at=1k
meas ac av_vd24_mag find v(vd24) at=1k

* 3. Transient Analysis (from Baker's LTspice settings)
tran 1u 300u
meas tran vd13_pk2pk pp v(vd13)
meas tran vd24_pk2pk pp v(vd24)

quit
.endc
.end
