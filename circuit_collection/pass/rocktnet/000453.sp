* Cross-Coupled Pair Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N1 N2 LABEL_NET_0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N1 LABEL_NET_1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}

VVDD VDD 0 DC 1.8
V_N1 N1 0 DC 1.8 AC 1
V_N2 N2 0 DC 1.8 AC -1
V_LABEL_NET_0 LABEL_NET_0 0 DC 0.9
V_LABEL_NET_1 LABEL_NET_1 0 DC 0.9
V_LABEL_NET_2 LABEL_NET_2 0 DC 0.9
V_N6 N6 0 DC 0.9

.control
dc VVDD 1.8 1.8 1
let id_m1 = -i(V_N1)
let id_m2 = -i(V_N2)
let id_m3 = -i(V_N6)
let pwr = (-i(VVDD)*1.8) + (-i(V_N1)*1.8) + (-i(V_N2)*1.8) + (-i(V_LABEL_NET_0)*0.9) + (-i(V_LABEL_NET_1)*0.9) + (-i(V_LABEL_NET_2)*0.9) + (-i(V_N6)*0.9)

meas dc id_pmos find id_m3 at=1.8
meas dc subcircuit_power find pwr at=1.8

ac dec 10 1k 100MEG
let i_n1_real = real(i(V_N1))
let r_neg = -2 / i_n1_real
meas ac r_neg_val find r_neg at=1k
let gm_nmos = i_n1_real
meas ac gm_val find gm_nmos at=1k

print id_pmos subcircuit_power r_neg_val gm_val
quit
.endc
.end
