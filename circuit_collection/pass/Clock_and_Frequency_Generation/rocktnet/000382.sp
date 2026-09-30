* Edge Detector Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 OUT OUT VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT IN GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 IN GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUT N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT OUT VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

VVDD VDD 0 1.8
* 1MHz clock with 10ns rise/fall times
VIN IN 0 PULSE(0 1.8 100n 10n 10n 390n 1u)

.control
* DC Sweep to find static transfer characteristics
dc VIN 0 1.8 0.01
meas dc vout_dc_peak max v(out)
meas dc vout_dc_low find v(out) at=1.8

* Transient analysis for pulse characteristics
tran 0.1n 2u
meas tran vout_peak max v(out) from=90n to=130n
meas tran vout_low min v(out) from=0 to=90n

* Measure pulse width at ~0.45V (approximate half maximum)
meas tran pulse_width trig v(out) val=0.45 rise=1 targ v(out) val=0.45 fall=1

* Measure average power
meas tran pwr_avg avg i(VVDD)
let power_mw = -pwr_avg * 1.8 * 1000
print power_mw
quit
.endc
.end
