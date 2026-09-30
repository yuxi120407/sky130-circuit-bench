* Testbench for Fully Differential Folded Cascode Op-Amp

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm16=0.5
.param L_xm18=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xm_bias_n=0.5
.param L_xm_bias_p=0.5
.param L_xm_in_p=0.5
.param L_xmc1=0.5
.param L_xmc2_l=0.5
.param L_xmc2_r=0.5
.param L_xmc3=0.5

.param W_xm9=5.0 L_xm9=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm_in_p=5.0 L_xm_in_p=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm_bias_n=5.0 L_xm_bias_n=0.5
.param W_xmc1=5.0 L_xmc1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xmc2_r=5.0 L_xmc2_r=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm_bias_p=5.0 L_xm_bias_p=0.5
.param W_xmc2_l=5.0 L_xmc2_l=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xmc3=5.0 L_xmc3=0.5
.param W_xm18=5.0 L_xm18=0.5

XM9 N10 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM5 N4 N11 N15 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM_IN_P N12 VIN_PLUS N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm_in_p} w={W_xm_in_p}
XM10 N12 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM_BIAS_N N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm_bias_n} w={W_xm_bias_n}
XMC1 N5 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc1} w={W_xmc1}
XM3 N15 N9 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XMC2_R N5 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc2_r} w={W_xmc2_r}
XM8 N3 N7 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM_BIAS_P LABEL_NET_1 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm_bias_p} w={W_xm_bias_p}
XMC2_L N2 VCMSET VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc2_l} w={W_xmc2_l}
XM7 N4 N7 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM11 N0 N16 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM4 N14 N9 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM6 N3 N11 N14 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM16 N1 N16 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XMC3 N2 VCMSET VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmc3} w={W_xmc3}
XM18 N0 VIN_MINUS N10 GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}

VVDD VDD 0 1.8
VVIN_PLUS VIN_PLUS 0 DC 0.9 AC 0.5 SIN(0.9 0.1 1k 0 0)
VVIN_MINUS VIN_MINUS 0 DC 0.9 AC -0.5 SIN(0.9 -0.1 1k 0 0)
VLABEL_NET_1 LABEL_NET_1 0 0.9
VVCMSET VCMSET 0 0.9

* Added bias sources for floating nodes
VN7 N7 0 0.9
VN9 N9 0 1.2
VN11 N11 0 0.6
VN16 N16 0 0.9

E_diff out_diff 0 N4 N3 1.0
CL1 N4 0 1p
CL2 N3 0 1p

.control
op
let Power_Consumption = -i(VVDD) * 1.8
print Power_Consumption

ac dec 100 1 1G
let gain_db = db(v(out_diff))
let phase = 180/PI * ph(v(out_diff))
let phase_margin_vec = phase + 180

meas ac DC_Gain find gain_db at=1
meas ac max_gain max gain_db

if $&max_gain > 0
  meas ac UGBW when gain_db=0 fall=1
  meas ac Phase_Margin find phase_margin_vec when gain_db=0 fall=1
else
  let UGBW = 0
  let Phase_Margin = 0
end

print DC_Gain
print UGBW
print Phase_Margin

quit
.endc
.end