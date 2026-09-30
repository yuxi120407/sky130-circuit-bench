* Differential Voltage-Controlled Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0

VVDD VDD 0 1.8
VVC VC 0 0.0

* Differential inputs (100 MHz for full swing)
* Period = 10ns, Pulse width = 4.95ns
VVIP VIP 0 PULSE(0 1.8 100p 50p 50p 4.95n 10n)
VVIN VIN 0 PULSE(1.8 0 100p 50p 50p 4.95n 10n)

* DUT
XM1 VON VOP GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOP VON GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VON VC VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VON VIP GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VOP VIN GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VOP VC VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

* Load capacitance (10fF from paper)
C1 VON 0 10f
C2 VOP 0 10f

.control
tran 10p 30n

let vdiff_in = v(vip) - v(vin)
let vdiff_out = v(vop) - v(von)

* Measure delays
meas tran propagation_delay trig vdiff_in val=0 rise=2 targ vdiff_out val=0 rise=2

* Measure rise and fall times (20% to 80% of 1.8V)
meas tran rise_fall_time trig v(vop) val=0.36 rise=2 targ v(vop) val=1.44 rise=2

* Measure voltage swing
meas tran v_max max v(vop) from=10n to=30n
meas tran v_min min v(vop) from=10n to=30n
let voltage_swing = v_max - v_min

* Measure average power
let power = -i(VVDD)*1.8
meas tran average_power avg power from=10n to=30n

print propagation_delay rise_fall_time voltage_swing average_power
quit
.endc
.end