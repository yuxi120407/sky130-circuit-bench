* Single-to-Differential Converter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
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
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5

XM1 NBIAS N1 NBIAS GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 NBIAS N2 NBIAS GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 NBIAS N8 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 NBIAS N6 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 LABEL_NET_0 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 PBIAS PBIAS LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 PCAS PCAS PBIAS VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 PBIAS NBIAS N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 NBIAS N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 NBIAS LABEL_NET_2 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 NBIAS NBIAS N8 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N8 NBIAS LABEL_NET_3 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N2 PCAS N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 LABEL_NET_2 NBIAS LABEL_NET_4 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N1 N1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N6 NBIAS NBIAS NBIAS sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 NBIAS NBIAS N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm17} w={W_xm17}

* Sources
VVDD VDD 0 1.8
VIN LABEL_NET_0 0 dc 0.9 ac 1 sin(0.9 0.1 1Meg)
VLABEL_NET_2 LABEL_NET_2 0 1.8
VLABEL_NET_3 LABEL_NET_3 0 0
VLABEL_NET_4 LABEL_NET_4 0 1.8

* Biasing and Loads
IBIAS VDD NBIAS 10u
IPCAS PCAS 0 10u
R_N1 VDD N1 100k
R_N0 N0 0 1G

* Differential Output Calculation
E_diff DIFF_OUT 0 N1 N2 1.0

.control
* DC Operating Point & Power
dc VVDD 1.8 1.8 1
let pwr = -i(VVDD)*1.8
meas dc power_consumption find pwr at=1.8

* AC Analysis
ac dec 20 1 100G
meas ac conversion_gain max vdb(DIFF_OUT)
let target_gain = conversion_gain - 3
meas ac bandwidth when vdb(DIFF_OUT)="$&target_gain" fall=1

* Transient Analysis
tran 10n 5u
meas tran transient_swing pp v(DIFF_OUT)

print power_consumption
print conversion_gain
print bandwidth
print transient_swing
quit
.endc
.end