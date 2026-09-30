* 2-GHz CMOS Image-Reject Receiver Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm1a=0.5
.param L_xm2=0.5
.param L_xm2a=0.5
.param L_xm3=0.5
.param L_xm3a=0.5
.param L_xm4=0.5
.param L_xm4a=0.5
.param L_xm5=0.5
.param L_xm5a=0.5
.param L_xm6=0.5
.param L_xm6a=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm1a=5.0 L_xm1a=0.5
.param W_xm2a=5.0 L_xm2a=0.5
.param W_xm3a=5.0 L_xm3a=0.5
.param W_xm4a=5.0 L_xm4a=0.5
.param W_xm5a=5.0 L_xm5a=0.5
.param W_xm6a=5.0 L_xm6a=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5

XM1 N_M1D VINp GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_M2D VINn GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT1 VLOp N_M1D GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT2 VLOn N_M1D GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VOUT1 VLOn N_M2D GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VOUT2 VLOp N_M2D GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM1A N_M1AD VINp GND GND sky130_fd_pr__nfet_01v8 l={L_xm1a} w={W_xm1a}
XM2A N_M2AD VINn GND GND sky130_fd_pr__nfet_01v8 l={L_xm2a} w={W_xm2a}
XM3A N_GC1 VLOn N_M1AD GND sky130_fd_pr__nfet_01v8 l={L_xm3a} w={W_xm3a}
XM4A N_GC2 VLOp N_M1AD GND sky130_fd_pr__nfet_01v8 l={L_xm4a} w={W_xm4a}
XM5A N_GC1 VLOp N_M2AD GND sky130_fd_pr__nfet_01v8 l={L_xm5a} w={W_xm5a}
XM6A N_GC2 VLOn N_M2AD GND sky130_fd_pr__nfet_01v8 l={L_xm6a} w={W_xm6a}
XM7 VOUT1 VGp N_GC1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 VOUT2 VGn N_GC1 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 VOUT1 VGp N_GC2 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 VOUT2 VGn N_GC2 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Loads
R1 VDD VOUT1 1k
R2 VDD VOUT2 1k

* Biasing and Supplies
VVDD VDD 0 1.8
VVGp VGp 0 DC 1.8
VVGn VGn 0 DC 1.8

* RF Inputs (2.4 GHz, 10mV peak)
VVINp VINp 0 DC 0.9 AC 1 SIN(0.9 0.01 2.4G 0 0 0)
VVINn VINn 0 DC 0.9 AC -1 SIN(0.9 0.01 2.4G 0 0 180)

* LO Inputs (2.21 GHz, 500mV peak)
VVLOp VLOp 0 DC 0.9 SIN(0.9 0.5 2.21G 0 0 0)
VVLOn VLOn 0 DC 0.9 SIN(0.9 0.5 2.21G 0 0 180)

* IF Filter (4-stage RC, fc = 500 MHz)
E1 VOUT_DIFF 0 vol='v(VOUT1) - v(VOUT2)'
R_flt1 VOUT_DIFF VOUT_FLT1 1k
C_flt1 VOUT_FLT1 0 0.32p
E2 VOUT_FLT1_BUF 0 VOUT_FLT1 0 1
R_flt2 VOUT_FLT1_BUF VOUT_FLT2 1k
C_flt2 VOUT_FLT2 0 0.32p
E3 VOUT_FLT2_BUF 0 VOUT_FLT2 0 1
R_flt3 VOUT_FLT2_BUF VOUT_FLT3 1k
C_flt3 VOUT_FLT3 0 0.32p
E4 VOUT_FLT3_BUF 0 VOUT_FLT3 0 1
R_flt4 VOUT_FLT3_BUF VOUT_FLT 1k
C_flt4 VOUT_FLT 0 0.32p

.control
tran 10p 150n 50n

* Power Consumption
meas tran pwr_avg avg i(VVDD)
let power_mw = -pwr_avg * 1.8 * 1000
print power_mw

* FFT for CG and IIP3
linearize v(VOUT_DIFF)
set specwindow = rectangular
fft v(VOUT_DIFF)
let vout_diff_mag = mag(v(VOUT_DIFF))

* Measure fundamental (190 MHz) and HD3 (570 MHz)
meas ac fund_mag max vout_diff_mag from=180Meg to=200Meg
meas ac hd3_mag max vout_diff_mag from=560Meg to=580Meg

* Conversion Gain
let cg_linear = fund_mag / 0.02
let cg_db = 20 * log10(cg_linear)
print cg_db

* IIP3
let fund_dbv = 20*log10(fund_mag)
let hd3_dbv = 20*log10(hd3_mag)
let im3_dbv = hd3_dbv + 9.54
let pin_dbv = 20*log10(0.02)
let iip3_dbv = pin_dbv + (fund_dbv - im3_dbv)/2
let iip3_dbm = iip3_dbv + 10
print iip3_dbm

* Noise Figure Measurement
alter VVLOp dc=1.4
alter VVLOn dc=0.4
noise v(VOUT1, VOUT2) VVINp lin 1 190Meg 190Meg
setplot noise1
let inoise_diff = (inoise_spectrum * inoise_spectrum) / 4
let nf_db = 10 * log10(1 + inoise_diff / 8.28e-19)
print nf_db

quit
.endc
.end