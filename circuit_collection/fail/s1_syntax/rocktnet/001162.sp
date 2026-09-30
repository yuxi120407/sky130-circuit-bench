* ADC Sub-circuit Testbench
.param W_xm9=5.0 L_xm9=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm5=5.0 L_xm5=0.5

XM9 N0 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM4 VO_PLUS GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM3 VO_MINUS GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM1 GND VIN_PLUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND VIR GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM6 VO_PLUS N2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 N2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM5 VO_MINUS N2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}

VVDD VDD 0 1.8
VN1 N1 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VVIN_PLUS VIN_PLUS 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)
VVIR VIR 0 DC 0.9 AC -1 SIN(0.9 0.1 1MEG 180 0)

* Load resistors to prevent floating nodes
R1 VO_PLUS 0 1MEG
R2 VO_MINUS 0 1MEG

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

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 10 1 1G
let gain_db = vdb(VO_PLUS)
meas ac max_gain max gain_db

tran 1n 2u
meas tran v_max max v(VO_PLUS)
meas tran v_min min v(VO_PLUS)

quit
.endc
.end