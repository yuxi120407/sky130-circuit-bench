* Frame Buffer Pixel Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 DATA WRITE N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 READ N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Load Capacitors (from paper: 200fF buffer, 400fF pixel)
C1 N1 GND 200f
C0 N0 GND 400f

* Voltage Sources
VDD VDD GND 1.8
VDATA DATA GND 1.0

* Control Signals
* WRITE: High from 1us to 2us
VWRITE WRITE GND PULSE(0 1.8 1u 1n 1n 1u 10u)
* READ: High from 4us to 5us
VREAD READ GND PULSE(0 1.8 4u 1n 1n 1u 10u)

.control
tran 1n 6u

* Measure Write Rise Time (10% to 90% of 1.0V)
meas tran t_write_rise trig v(N1) val=0.1 rise=1 targ v(N1) val=0.9 rise=1

* Measure Write Charge Injection (Voltage drop when WRITE turns off)
meas tran v_n1_before_off find v(N1) at=1.99u
meas tran v_n1_after_off find v(N1) at=2.01u
let write_charge_inj = v_n1_before_off - v_n1_after_off
print write_charge_inj

* Measure Hold Voltage Drop (from 2.1us to 3.9us)
meas tran v_n1_hold_start find v(N1) at=2.1u
meas tran v_n1_hold_end find v(N1) at=3.9u
let hold_voltage_drop = v_n1_hold_start - v_n1_hold_end
print hold_voltage_drop

* Measure Read Rise Time (10% to 90% of expected 0.33V due to charge sharing between 200fF and 400fF)
meas tran t_read_rise trig v(N0) val=0.033 rise=1 targ v(N0) val=0.30 rise=1

quit
.endc
.end