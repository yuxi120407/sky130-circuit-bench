* OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1_l=0.5
.param L_xm1_r=0.5
.param L_xm2_l=0.5
.param L_xm2_r=0.5
.param L_xmnb_l=0.5
.param L_xmnb_r=0.5
.param L_xmpb_l=0.5
.param L_xmpb_r=0.5
.param L_xmrn_l=0.5
.param L_xmrn_r=0.5
.param L_xmrp=0.5

.param W_xmrp=5.0
.param W_xm2_r=5.0
.param W_xm1_r=5.0
.param W_xm1_l=5.0
.param W_xmnb_l=5.0
.param W_xm2_l=5.0
.param W_xmpb_l=5.0
.param W_xmnb_r=5.0
.param W_xmrn_r=5.0
.param W_xmpb_r=5.0
.param W_xmrn_l=5.0

XMRP N6 VT_P N9 VDD sky130_fd_pr__pfet_01v8 L={L_xmrp} W={W_xmrp}
XM2_R OUTP VIN N6 VDD sky130_fd_pr__pfet_01v8 L={L_xm2_r} W={W_xm2_r}
XM1_R OUTP VIN N5 VSS sky130_fd_pr__nfet_01v8 L={L_xm1_r} W={W_xm1_r}
XM1_L OUTN VIP N2 VSS sky130_fd_pr__nfet_01v8 L={L_xm1_l} W={W_xm1_l}
XMNB_L N2 VCMFB VSS VSS sky130_fd_pr__nfet_01v8 L={L_xmnb_l} W={W_xmnb_l}
XM2_L OUTN VIP N9 VDD sky130_fd_pr__pfet_01v8 L={L_xm2_l} W={W_xm2_l}
XMPB_L N9 VB2 VDD VDD sky130_fd_pr__pfet_01v8 L={L_xmpb_l} W={W_xmpb_l}
XMNB_R N5 VCMFB VSS VSS sky130_fd_pr__nfet_01v8 L={L_xmnb_r} W={W_xmnb_r}
XMRN_R N5 VT_N N2 VSS sky130_fd_pr__nfet_01v8 L={L_xmrn_r} W={W_xmrn_r}
XMPB_R N6 VB2 VDD VDD sky130_fd_pr__pfet_01v8 L={L_xmpb_r} W={W_xmpb_r}
XMRN_L N2 VT_N N5 VSS sky130_fd_pr__nfet_01v8 L={L_xmrn_l} W={W_xmrn_l}

VVDD VDD 0 1.8
VVSS VSS 0 0

VVB2 VB2 0 0.6
VVT_P VT_P 0 0.0
VVT_N VT_N 0 1.8

* Ideal CMFB to hold output common-mode at 0.9V
B_CMFB VCMFB 0 V='0.9+(V(OUTP)+V(OUTN)-1.8)*10'

* Inputs with DC and AC
VVIP VIP 0 DC 0.9 AC 0.5
VVIN VIN 0 DC 0.9 AC -0.5

* Load Capacitors
CL1 OUTP 0 1p
CL2 OUTN 0 1p
R_diff OUTP OUTN 1G

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac dec 100 1 10G
let vout_diff = v(OUTP) - v(OUTN)
let gain_db = db(vout_diff)
let phase_deg = ph(vout_diff) * 180 / 3.14159265358979323846
let pm = 180 + phase_deg

meas ac dc_gain find gain_db at=1
meas ac ugbw when gain_db=0 fall=1
meas ac phase_margin find pm when gain_db=0 fall=1

print dc_gain
print ugbw
print phase_margin

quit
.endc
.end