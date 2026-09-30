* CMOS Inverter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 Q D GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 Q D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}

VVDD VDD 0 1.8
VGND GND 0 0
* 1 GHz input pulse for high-speed testing
VIN D 0 PULSE(0 1.8 0.2n 20p 20p 0.4n 1n)
* 50fF load capacitor to simulate fan-out/wiring
CL Q 0 50f

.control
* DC Analysis for Switching Threshold
dc VIN 0 1.8 0.01
meas dc v_th find v(D) when v(Q)=0.9

* Transient Analysis for Timing and Power
tran 2p 3n
meas tran t_pd_fall trig v(D) val=0.9 rise=1 targ v(Q) val=0.9 fall=1
meas tran t_pd_rise trig v(D) val=0.9 fall=1 targ v(Q) val=0.9 rise=1
meas tran t_fall trig v(Q) val=1.44 fall=1 targ v(Q) val=0.36 fall=1
meas tran t_rise trig v(Q) val=0.36 rise=1 targ v(Q) val=1.44 rise=1

* Average Power Calculation
meas tran i_avg avg i(VVDD) from=0 to=3n
let power_avg = -i_avg * 1.8
print power_avg

quit
.endc
.end