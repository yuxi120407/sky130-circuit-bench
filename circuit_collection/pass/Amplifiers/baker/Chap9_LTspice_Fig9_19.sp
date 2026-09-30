* Testbench for Example 9.5 Differential Circuit (Baker Ch. 9)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=10.0 L_xm1=2.0
.param W_xm2=10.0 L_xm2=2.0
.param W_xm3=30.0 L_xm3=2.0
.param W_xm4=30.0 L_xm4=2.0

xm2 vd24 N001 vs12 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
VDD VDD 0 1.8
Ibias vs12 0 40u
xm1 vd13 vg1 vs12 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 vd24 0 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 vd13 vd13 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
VG1 vg1 0 DC 0.9 AC 1m
VG2 N001 0 0.9

.control
run
op

* DC Operating Point Measurements
let v_s12_dc = v(vs12)
let v_gs_nmos = v(vg1) - v(vs12)
let v_d13_dc = v(vd13)
let v_sg3_dc = v(vdd) - v(vd13)
let v_d24_dc = v(vd24)
let v_sd4_dc = v(vdd) - v(vd24)
* Current through M4 equals drain current of M2
let id4 = 20u
let r_ch_m4 = v_sd4_dc / id4

print v_s12_dc v_gs_nmos v_d13_dc v_sg3_dc v_d24_dc r_ch_m4

* AC Small-Signal Analysis
ac dec 100 1 10k

meas ac v_s12_ac find v(vs12) at=1k
meas ac v_d13_ac find v(vd13) at=1k
meas ac v_d24_ac find v(vd24) at=1k

let gm1_meas = (2 * v_d13_ac / 1m) * (v_d13_ac / (v_d13_ac / 173u))
print v_s12_ac v_d13_ac v_d24_ac

quit
.endc
.end