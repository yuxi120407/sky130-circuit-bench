* Multiple-Input Boost Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 VO VO GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VO V1 VO VO sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VO V2 VO VO sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VO V3 VO VO sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* 1 GHz input pulses
V1 V1 GND PULSE(0 1.8 0 50p 50p 450p 1n)
V2 V2 GND PULSE(0 1.8 0 50p 50p 450p 1n)
V3 V3 GND PULSE(0 1.8 0 50p 50p 450p 1n)

.control
tran 10p 20n

* Measure min and max output voltages in steady state
meas tran v_out_min min v(VO) from=10n to=20n
meas tran v_out_max max v(VO) from=10n to=20n

* Calculate dynamic power consumption
let pwr1 = -i(V1)*v(V1)
let pwr2 = -i(V2)*v(V2)
let pwr3 = -i(V3)*v(V3)
let pwr_total = pwr1 + pwr2 + pwr3
meas tran avg_power avg pwr_total from=10n to=20n

print v_out_min v_out_max avg_power
quit
.endc
.end
