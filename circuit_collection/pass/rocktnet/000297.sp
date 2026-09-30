* Testbench for LNA and Mixer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm3=5.0 L_xm3=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm8=5.0 L_xm8=0.5

* DUT
XM3 N4 N5 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM1 N13 VIN N9 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM7 VIF_P VLO_N N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM2 N6 VB1 N13 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM4 N1 N2 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VIF_P VLO_P N4 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VIF_N VLO_N N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM8 VIF_N VLO_P N1 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Supply
VVDD VDD 0 1.8

* LNA Input with 50 ohm source
Rsrc VIN_src VIN 50
VVIN VIN_src 0 DC 0.8 AC 1 SIN(0.8 0.01 2.4G 0 0)
VVB1 VB1 0 DC 1.4

* Ground connections for sources
VN8 N8 0 0
VN9 N9 0 0
VN12 N12 0 0

* Mixer RF Inputs
VRF_P N5 0 DC 0.8 SIN(0.8 0.01 2.4G 0 0)
VRF_N N2 0 DC 0.8 SIN(0.8 -0.01 2.4G 0 0)

* Mixer LO Inputs
VLO_P VLO_P 0 DC 1.4 SIN(1.4 0.4 1.6G 0 0)
VLO_N VLO_N 0 DC 1.4 SIN(1.4 -0.4 1.6G 0 0)

* Loads
RLNA N6 VDD 2k
RIFP VIF_P VDD 2k
RIFN VIF_N VDD 2k

* IF Filter Capacitors
CIFP VIF_P 0 100f
CIFN VIF_N 0 100f

* Behavioral source for differential IF
B1 IF_DIFF 0 V='V(VIF_P)-V(VIF_N)'

.control
* 1. DC Operating Point and Power
op
let total_current = -i(VVDD)
let power_consumption = total_current * 1.8 * 1000
print power_consumption

* 2. AC Analysis for LNA Gain
ac dec 10 100M 10G
meas ac lna_voltage_gain find vdb(N6) at=2.4G
print lna_voltage_gain

* 3. Noise Analysis for LNA
noise V(N6) VVIN dec 10 100M 10G
setplot noise1
let nf_vec = 20 * log10(inoise_spectrum / 8.946e-10)
setplot ac1
let nf_vec_ac = noise1.nf_vec
meas ac noise_figure find nf_vec_ac at=2.4G
print noise_figure

* 4. Transient Analysis for Mixer Conversion Gain
tran 10p 20n
meas tran if_max max V(IF_DIFF) from=10n to=20n
meas tran if_min min V(IF_DIFF) from=10n to=20n
let if_max_v = $&if_max
let if_min_v = $&if_min
let if_p2p = if_max_v - if_min_v
let if_amp = if_p2p / 2
let rf_amp = 0.02
let conv_gain = if_amp / rf_amp
let mixer_conversion_gain = 20 * log10(conv_gain)
print mixer_conversion_gain

quit
.endc
.end