* Single-Chip Multimode Receiver Baseband Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameterized W/L
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5

* DUT Netlist
XM1 N9 VB3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 VB3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N15 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 VB4 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N2 IOUTn GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N5 IOUTp GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 VB3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N8 VB3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N15 N15 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N14 VB4 N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N2 VB2 N19 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N5 VB2 N17 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 IOUTn VB1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N19 VB1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N17 VB1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 IOUTp VB1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}

* Fix typo in netlist: XM5 drain should be N5 to form the symmetric cross-coupled pair
Vfix N1 N5 0

* Fix floating drain of XM10
Vfix2 N14 VB4 0

* DC Bias Sources
VVDD VDD 0 1.8
VVB3 VB3 0 1.1
VVB2 VB2 0 0.9

* Inputs (Overriding N15 and VB4 with AC sources for pseudo-differential drive)
VVINp N15 0 DC 0.9 AC 1 SIN(0.9 0.05 50MEG 0 0)
VVINn VB4 0 DC 0.9 AC -1 SIN(0.9 0.05 50MEG 180 0)

* Ideal CMFB to stabilize high-impedance nodes N2 and N5
Ecmfb VB1 0 VALUE = {0.6 + (v(N2) + v(N5) - 1.8)*1}

* Load Capacitors
CL1 N2 0 1p
CL2 N5 0 1p

.control
* 1. DC Operating Point & Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* 2. AC Analysis
ac dec 100 1k 1G
let out_diff_ac = v(N2) - v(N5)
let in_diff_ac = v(N15) - v(VB4)
let gain_mag = mag(out_diff_ac) / mag(in_diff_ac)
let gain_db = 20 * log10(gain_mag + 1e-20)

meas ac voltage_gain find gain_db at=10k
meas ac unity_gain_frequency when gain_db=0 fall=1

* 3. Transient Analysis for IIP2
tran 1n 2999n 2000n
let out_diff_tran = v(N2) - v(N5)
linearize out_diff_tran
fft out_diff_tran
let fund_mag = mag(out_diff_tran[50])
let hd2_mag = mag(out_diff_tran[100])
let fund_mag_safe = fund_mag + 1e-20
let hd2_mag_safe = hd2_mag + 1e-20
let fund_dbv = 20*log10(fund_mag_safe)
let hd2_dbv = 20*log10(hd2_mag_safe)
let out_of_band_iip2 = -20 + (fund_dbv - hd2_dbv)
print out_of_band_iip2

quit
.endc
.end