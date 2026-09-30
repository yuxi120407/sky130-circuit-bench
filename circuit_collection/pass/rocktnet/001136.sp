* Pseudo-NMOS Multiplexer Testbench
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

* Parameters
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm9=5.0 L_xm9=0.5

* DUT
XM2 OUT CTRL1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 N1 P2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM4 OUT CTRL2 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM3 N2 P3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM7 OUT CTRL3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM5 N3 P4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM8 OUT CTRL4 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM6 N4 P5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM9 OUT GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}

* Sources
VVDD VDD 0 1.8

* Enable branch 1, disable others
VCTRL1 CTRL1 0 1.8
VCTRL2 CTRL2 0 0
VCTRL3 CTRL3 0 0
VCTRL4 CTRL4 0 0

* 200 MHz input pulse on P2
VP2 P2 0 PULSE(0 1.8 1n 100p 100p 2.4n 5n)
VP3 P3 0 0
VP4 P4 0 0
VP5 P5 0 0

* Load capacitance
CL OUT 0 10f

* Analysis
.control
tran 10p 15n

* Measurements
meas tran v_oh max v(out)
meas tran v_ol min v(out)
meas tran t_delay trig v(p2) val=0.9 rise=1 targ v(out) val=0.9 fall=1
meas tran t_rise trig v(out) val=0.36 rise=1 targ v(out) val=1.44 rise=1
meas tran t_fall trig v(out) val=1.44 fall=1 targ v(out) val=0.36 fall=1

* Power calculation
let pwr = -i(VVDD)*1.8
meas tran avg_pwr avg pwr

print v_oh v_ol t_delay t_rise t_fall avg_pwr
quit
.endc
.end
