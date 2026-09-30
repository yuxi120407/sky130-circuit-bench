* 3-Input CMOS NAND Gate Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

* Sizing parameters
.param W_xm1=1.0 L_xm1=0.15
.param W_xm2=1.0 L_xm2=0.15
.param W_xm3=1.0 L_xm3=0.15
.param W_xm4=1.0 L_xm4=0.15
.param W_xm5=1.0 L_xm5=0.15
.param W_xm6=1.0 L_xm6=0.15

* Power Supply
VDD VDD 0 1.8

* Circuit under test
xm4 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm1 P001 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 P002 Vin P001 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 Vout Vin P002 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm5 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm6 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
C1 Vout 0 5e-14

* Input Source: Pulse for Transient, Swept for DC
Vin Vin 0 pulse(0 1.8 0.5n 50p 50p 1n 2.5n)

.control
* === DC Analysis: VTC and Switching Point ===
dc Vin 0 1.8 0.002
let diff = v(Vout) - v(Vin)
meas dc switching_point_voltage when diff=0
meas dc output_high_voltage find v(Vout) at=0
meas dc output_low_voltage find v(Vout) at=1.8

* === Transient Analysis: Propagation Delays and Edge Times ===
tran 5p 3n
meas tran high_to_low_delay trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 fall=1
meas tran low_to_high_delay trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 rise=1
meas tran fall_time trig v(Vout) val=1.62 fall=1 targ v(Vout) val=0.18 fall=1
meas tran rise_time trig v(Vout) val=0.18 rise=1 targ v(Vout) val=1.62 rise=1

print switching_point_voltage output_high_voltage output_low_voltage
print high_to_low_delay low_to_high_delay fall_time rise_time
quit
.endc
.end
