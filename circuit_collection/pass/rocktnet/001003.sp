* LC Tank Varactor Testbench
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm6=5.0 L_xm6=0.5

XM2 N1 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM4 GND N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VL_PLUS GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM3 GND LABEL_NET_1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM1 N2 N5 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM6 VL_MINUS LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VN4 N4 0 0
VN5 N5 0 0.9

VAC_P VL_PLUS 0 DC 0.9 AC 1
VAC_M VL_MINUS 0 DC 0.9 AC 1

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.control
op
let dc_current_p = -i(VAC_P)
let dc_current_m = -i(VAC_M)
let dc_power = (dc_current_p + dc_current_m) * 0.9
print dc_power

ac dec 10 1G 10G
let omega = 2 * 3.14159265359 * frequency
let c_plus = -imag(i(VAC_P)) / omega
let c_minus = -imag(i(VAC_M)) / omega

meas ac c_plus_8g find c_plus at=8G
meas ac c_minus_8g find c_minus at=8G

quit
.endc
.end