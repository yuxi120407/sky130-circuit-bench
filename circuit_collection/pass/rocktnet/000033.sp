* Charge Pump Sub-circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

* Supply and Inputs
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 PULSE(0 1.8 0 100p 100p 5n 10n)
VLABEL_NET_4 LABEL_NET_4 0 PULSE(0 1.8 2.5n 100p 100p 5n 10n)
VLABEL_NET_5 LABEL_NET_5 0 PULSE(0 1.8 5n 100p 100p 5n 10n)
VLABEL_NET_6 LABEL_NET_6 0 PULSE(0 1.8 7.5n 100p 100p 5n 10n)

* DUT
XM1 VDD LABEL_NET_0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 N2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VDD N5 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_4 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 LABEL_NET_5 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 LABEL_NET_6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

* Load Capacitors to aid convergence and simulate parasitic load
C1 N5 0 10f
C2 N0 0 10f
C3 VDD 0 10f
C4 N2 0 10f
C5 N3 0 10f

.control
tran 100p 40n

* Measure Voltage Swings
meas tran v_max_n0 max v(N0) from=20n to=40n
meas tran v_min_n0 min v(N0) from=20n to=40n
meas tran v_max_n5 max v(N5) from=20n to=40n
meas tran v_min_n5 min v(N5) from=20n to=40n
meas tran voltage_swing pp v(N0) from=20n to=40n

* Measure Power Consumption
meas tran avg_current avg i(VVDD) from=20n to=40n
let power_consumption = -avg_current * 1.8

print voltage_swing
print power_consumption

quit
.endc
.end