* Two-Stage Fully Differential OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5

* Renamed duplicate XM2 to XM2_N and XM2_P to avoid SPICE errors
XM2_N N5 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM2_P OUTN LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUTN N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUTP LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUTP N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM1 N5 INN N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM8 N0 INP N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

* Load Capacitors for load-compensation
CL1 OUTP 0 1p
CL2 OUTN 0 1p

* Power Supply and Fixed Bias
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 0.9

* Ideal Common-Mode Feedback (CMFB) for DC stabilization
* First stage CMFB: controls NMOS loads to keep N5 and N0 at 0.9V
B_CMFB1 N3 0 V='0.9 + 100*(v(N5)+v(N0)-1.8)'
* Second stage CMFB: controls PMOS loads to keep OUTP and OUTN at 0.9V
B_CMFB2 LABEL_NET_0 0 V='0.9 + 100*(v(OUTP)+v(OUTN)-1.8)'
B_CMFB3 LABEL_NET_2 0 V='0.9 + 100*(v(OUTP)+v(OUTN)-1.8)'

* Input Signals (Differential)
VINP INP 0 DC 0.9 AC 0.5 SIN(0.9 10u 1MEG)
VINN INN 0 DC 0.9 AC -0.5 SIN(0.9 -10u 1MEG)

.control
* DC Operating Point and Power
op
let power = -i(VVDD) * 1.8
print power

* AC Analysis
ac dec 100 1 1G
let out_diff = v(OUTP) - v(OUTN)
let gain_db = 20*log10(mag(out_diff))
let phase = 180/PI * cph(out_diff)

meas ac dc_gain find gain_db at=10
meas ac ugf when gain_db=0 fall=1
meas ac pm_raw find phase when gain_db=0 fall=1
let phase_margin = pm_raw + 180
print phase_margin

* Transient Analysis
tran 1n 5u
meas tran vout_p_max max v(OUTP)
meas tran vout_p_min min v(OUTP)
.endc
.end