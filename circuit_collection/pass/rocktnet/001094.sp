* Testbench for CMOS Amplifier
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

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5

XM1 N1 VBIAS1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 VBIAS1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 VBIAS VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 VBIAS VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VBIAS N2 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 VBIAS2 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 INp N5 VSS sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 INn N5 VSS sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

* Voltage Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
VVBIAS1 VBIAS1 0 0.99
VVBIAS VBIAS 0 1.8
VVBIAS2 VBIAS2 0 0.6
VINp INp 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)
VINn INn 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)

.control
* Find optimal VBIAS1 for output DC = 0.9V
dc VVBIAS1 0 1.8 0.001
meas dc vbias1_opt when v(N4)=0.9
alter VVBIAS1 $&vbias1_opt

* DC Operating Point & Power
op
let Power_Consumption = -i(VVDD) * 1.8
print Power_Consumption

* AC Analysis for Gain and Bandwidth
ac dec 100 1 100G
let gain_db = db(v(N4))
meas ac DC_Gain max gain_db
let target_gain = $&DC_Gain - 3
meas ac Bandwidth when gain_db=$&target_gain fall=1
print DC_Gain
print Bandwidth

* Transient Analysis for Output Swing
tran 1n 5u
meas tran vout_max max v(N4) from=2u to=5u
meas tran vout_min min v(N4) from=2u to=5u
let Output_Swing = $&vout_max - $&vout_min
print Output_Swing

quit
.endc
.end