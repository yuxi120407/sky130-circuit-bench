* Multi-Threshold Inverter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N2 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N1 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VIN N1 0 PULSE(0 1.8 1n 0.1n 0.1n 500n 1000n)
CLOAD0 N0 0 10f
CLOAD2 N2 0 10f

.control
* DC Sweep for VTC
dc VIN 0 1.8 0.01
meas dc v_threshold_n0 when v(N0)=0.9 fall=1
meas dc v_threshold_n2 when v(N2)=0.9 fall=1

* Transient Analysis
tran 0.1n 2000n
meas tran t_delay_hl_n0 trig v(N1) val=0.9 rise=1 targ v(N0) val=0.9 fall=1
meas tran t_delay_lh_n0 trig v(N1) val=0.9 fall=1 targ v(N0) val=0.9 rise=1
meas tran t_delay_hl_n2 trig v(N1) val=0.9 rise=1 targ v(N2) val=0.9 fall=1
meas tran t_delay_lh_n2 trig v(N1) val=0.9 fall=1 targ v(N2) val=0.9 rise=1

* Power measurement
meas tran integ_current integ i(VVDD) from=0 to=1000n
let dynamic_power = -integ_current * 1.8 / 1000n
print dynamic_power

* Static Power
op
let static_power = -i(VVDD) * 1.8
print static_power

quit
.endc
.end
