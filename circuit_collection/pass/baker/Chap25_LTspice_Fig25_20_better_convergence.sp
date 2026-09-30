* Fully-Differential Sample-and-Hold Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

* Parameter definitions for switches (detail from Fig. 25.19: 10/1)
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=10.0 L_xm4=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7=10.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0

* DUT Netlist
V1 Vinm 0 SINE(500m -100m 5MEG)
V2 Vinp 0 SINE(500m 100m 5MEG)
C1 vm N001 1e-12
C2 vp N003 1e-12
C3 voutp 0 1e-12
C4 voutm 0 1e-12
xm1 N001 phi2 vinp 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N003 phi2 vinm 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 vop phi1 vm 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 vom phi1 vp 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 vop phi3 N001 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N003 phi3 vom 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 voutp phi3 vop 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 vom phi3 voutm 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
G1 0 vop vp vm 150u
G2 vom 0 vp vm 150u
R1 vop N002 10000000.0
R2 N002 vom 10000000.0
G3 0 vop VCM N002 10u
G4 0 vom VCM N002 10u
VCM1 VCM 0 500m

* Clock Generation: 50 MHz (Period = 20ns)
* phi1 turns off first (bottom plate sampling), then phi2, then non-overlapping phi3
Vphi1 phi1 0 PULSE(0 1.8 0 0.2n 0.2n 5n 20n)
Vphi2 phi2 0 PULSE(0 1.8 0 0.2n 0.2n 7n 20n)
Vphi3 phi3 0 PULSE(0 1.8 10n 0.2n 0.2n 8n 20n)

* Simulation Control
.control
tran 0.05n 200n

* Derived signals
let vin_diff = v(vinp) - v(vinm)
let vout_diff = v(voutp) - v(voutm)
let vcm_out = 0.5 * (v(vop) + v(vom))
let v_vshort = v(vp) - v(vm)

* Measurements
meas tran vcm_avg avg vcm_out from=10n to=200n
meas tran vin_diff_max max vin_diff from=50n to=200n
meas tran vin_diff_min min vin_diff from=50n to=200n
meas tran vout_diff_max max vout_diff from=50n to=200n
meas tran vout_diff_min min vout_diff from=50n to=200n

let diff_swing = vout_diff_max - vout_diff_min
let in_swing = vin_diff_max - vin_diff_min
let diff_gain = diff_swing / in_swing
let diff_offset = (vout_diff_max + vout_diff_min) / 2

meas tran max_vshort max abs(v_vshort) from=1n to=5n

print vcm_avg
print diff_swing
print diff_gain
print diff_offset
print max_vshort

quit
.endc
.end
