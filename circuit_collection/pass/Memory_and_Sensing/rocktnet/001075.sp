* CAM Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
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

XM1 N2 N2 WL VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N2 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 BL_BAR N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N2 BL GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 BL_BAR N2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 WL BL GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 BL_BAR WL N2 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8

* Stimulus: Write (10-20ns), Search Match (30-40ns), Search Mismatch (40-50ns)
VWL WL 0 PWL(0 0 10n 0 10.1n 1.8 20n 1.8 20.1n 0 50n 0)
VBL BL 0 PWL(0 0 10n 0 10.1n 1.8 20n 1.8 20.1n 0 30n 0 30.1n 1.8 40n 1.8 40.1n 0 50n 0)
VBL_BAR BL_BAR 0 PWL(0 0 10n 0 10.1n 0 20n 0 20.1n 0 30n 0 30.1n 0 40n 0 40.1n 1.8 50n 1.8)

.control
tran 0.1n 50n

let i_ml = -i(VLABEL_NET_1)
meas tran mismatch_current AVG i_ml FROM=42n TO=48n

let p_total = abs(i(VVDD)*v(VDD)) + abs(i(VLABEL_NET_1)*v(LABEL_NET_1)) + abs(i(VWL)*v(WL)) + abs(i(VBL)*v(BL)) + abs(i(VBL_BAR)*v(BL_BAR))
meas tran search_energy INTEG p_total FROM=40n TO=50n

meas tran t_start WHEN v(BL_BAR)=0.05 RISE=1 FROM=39n
meas tran t_eval WHEN v(N3)=0.05 RISE=1 FROM=39n
let search_delay = t_eval - t_start

print search_energy search_delay mismatch_current
quit
.endc
.end