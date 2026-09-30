* Fully Integrated SONET OC-48 Transceiver - VCO Core
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

* DUT
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM3 QP QN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 QN QP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM1 QP QN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 QN QP GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Testbench components
VVDD VDD 0 1.8
L1 QP QN 2nH
C1 QP QN 2pF

* Kickstart current pulse for Tran (single pulse), AC source for AC analysis
Ikick QP QN PULSE(0 1m 0 100p 100p 100p 100n) AC 1

.control
* 1. AC Analysis for Negative Resistance
ac dec 100 1G 10G
let v_diff_ac = v(QP) - v(QN)
let z_mag = mag(v_diff_ac)
meas ac z_max max z_mag
let neg_res = -z_max
print neg_res

* 2. Transient Analysis for Oscillation
tran 10p 50n
* Measure frequency (using cycles near the end of simulation to ensure steady-state)
meas tran t1 trig v(QP) val=0.9 rise=1 from=40n to=50n
meas tran t2 trig v(QP) val=0.9 rise=2 from=40n to=50n
let osc_freq = 1 / (t2 - t1)
print osc_freq

* Measure amplitude
meas tran vqp_max max v(QP) from=40n to=50n
meas tran vqp_min min v(QP) from=40n to=50n
let vqp_pp = vqp_max - vqp_min
print vqp_pp

* Measure power
meas tran pwr_avg avg i(VVDD) from=40n to=50n
let power_mW = -pwr_avg * 1.8 * 1000
print power_mW

quit
.endc
.end