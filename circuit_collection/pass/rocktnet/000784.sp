* Testbench for Area-Efficient Linear Regulator

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

* Include SKY130 models
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* DUT
XM1 N6 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 V_BIAS N6 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 V_N N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 V_AMP N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N3 V_P N0 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 V_AMP N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N2 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

* Power and Biasing
VVDD VDD 0 1.8
Vbias V_BIAS 0 0.6
V_N2 N2 0 0.9

* Reference Voltage
Vref V_P 0 0.9

* Feedback Loop (Broken for AC, Closed for DC/Tran via alter)
Rbreak V_AMP V_N 1G
Cbreak V_N V_AC 1G
Vac V_AC 0 DC 0 AC 1

* Load
Iload V_AMP 0 DC 10u PULSE(10u 50u 1u 0.1u 0.1u 5u 10u)
Cload V_AMP 0 1p

.control
* Fix DC convergence by lowering Rbreak to a reasonable value for OP/AC
alter Rbreak 1Meg

* 1. Operating Point & Power
op
let quiescent_power = -i(VVDD) * 1.8
print quiescent_power

* 2. AC Analysis (Open Loop)
ac dec 20 1 10G
let gain_db = vdb(V_AMP)
let phase = 180/PI * cph(v(V_AMP))
meas ac dc_gain find gain_db at=10
meas ac ugbf when gain_db=0 fall=1
meas ac phase_margin find phase when gain_db=0 fall=1
print dc_gain ugbf phase_margin

* Close the loop for Transient and DC analyses
alter Rbreak 0.1
alter Cbreak 1f

* 3. Transient Analysis (Load Regulation)
tran 10n 10u
meas tran vout_max max v(V_AMP)
meas tran vout_min min v(V_AMP)
let load_regulation = vout_max - vout_min
print load_regulation

* 4. DC Sweep (Line Regulation)
dc VVDD 1.6 2.0 0.01
meas dc vout_16 find v(V_AMP) at=1.6
meas dc vout_20 find v(V_AMP) at=2.0
let line_regulation = (vout_20 - vout_16) / 0.4
print line_regulation

quit
.endc
.end