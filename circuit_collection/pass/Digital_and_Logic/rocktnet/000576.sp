* DAC Switch Driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm5=5.0 L_xm5=0.5

XM3 IN_L N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 IN_L N2 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM2 N2 IN N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM1 N2 IN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM6 IN_R IN_L N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM5 IN_R IN_L GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

* Power Supplies
VVDD VDD 0 1.8
VN3 N3 0 1.8

* Input Signal (250 MHz -> 4ns period)
VIN IN 0 PULSE(0 1.8 1n 100p 100p 1.9n 4n)

.control
tran 10p 20n

* Measure Delays
meas tran delay_in_inl trig v(IN) val=0.9 rise=2 targ v(IN_L) val=0.9 rise=2
meas tran delay_in_inr trig v(IN) val=0.9 rise=2 targ v(IN_R) val=0.9 fall=2

* Measure Rise and Fall Times
meas tran trise_inl trig v(IN_L) val=0.36 rise=2 targ v(IN_L) val=1.44 rise=2
meas tran tfall_inl trig v(IN_L) val=1.44 fall=2 targ v(IN_L) val=0.36 fall=2
meas tran trise_inr trig v(IN_R) val=0.36 rise=2 targ v(IN_R) val=1.44 rise=2
meas tran tfall_inr trig v(IN_R) val=1.44 fall=2 targ v(IN_R) val=0.36 fall=2

* Measure Crossing Point
let vdiff = v(IN_L) - v(IN_R)
meas tran t_cross when vdiff=0 cross=3
meas tran v_cross find v(IN_L) at=t_cross

* Measure Average Power
let pwr = - (i(VVDD) + i(VN3)) * 1.8
meas tran avg_pwr avg pwr from=4n to=16n

print delay_in_inl delay_in_inr trise_inl tfall_inl trise_inr tfall_inr v_cross avg_pwr
quit
.endc
.end
