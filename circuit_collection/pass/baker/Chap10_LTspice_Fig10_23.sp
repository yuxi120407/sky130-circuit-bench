* NMOS Pass-Gate Chain Testbench (SKY130)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=1.0 L_xm1=0.15
.param W_xm2=1.0 L_xm2=0.15
.param W_xm3=1.0 L_xm3=0.15
.param W_xm4=1.0 L_xm4=0.15
.param W_xm5=1.0 L_xm5=0.15
.param W_xm6=1.0 L_xm6=0.15
.param W_xm7=1.0 L_xm7=0.15
.param W_xm8=1.0 L_xm8=0.15
.param W_xm9=1.0 L_xm9=0.15
.param W_xm10=1.0 L_xm10=0.15

* Power supply and input signal
VDD VDD 0 DC 1.8
Vin Vin 0 PULSE(0 1.8 1n 50p 50p 6n 14n)

* DUT (NMOS Pass-Gate Chain)
xm1 N001 VDD Vin 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N002 VDD N001 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 N003 VDD N002 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 N004 VDD N003 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 N005 VDD N004 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N006 VDD N005 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 N007 VDD N006 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 N008 VDD N007 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 N009 VDD N008 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 Vout VDD N009 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
C1 Vout 0 5e-14

.control
tran 10p 16n

* Measure output voltage levels
meas tran output_high_voltage max v(Vout) from=5n to=7n
meas tran output_low_voltage min v(Vout) from=13n to=15n
let threshold_voltage_drop = 1.8 - output_high_voltage

* 50% points for delay measurements
let v_mid_out = (output_high_voltage + output_low_voltage) / 2

meas tran propagation_delay_low_to_high trig v(Vin) val=0.9 rise=1 targ v(Vout) val=$&v_mid_out rise=1
meas tran propagation_delay_high_to_low trig v(Vin) val=0.9 fall=1 targ v(Vout) val=$&v_mid_out fall=1

* 10% to 90% transition levels based on output swing
let v_10 = output_low_voltage + 0.1 * (output_high_voltage - output_low_voltage)
let v_90 = output_low_voltage + 0.9 * (output_high_voltage - output_low_voltage)

meas tran rise_time trig v(Vout) val=$&v_10 rise=1 targ v(Vout) val=$&v_90 rise=1
meas tran fall_time trig v(Vout) val=$&v_90 fall=1 targ v(Vout) val=$&v_10 fall=1

print output_high_voltage output_low_voltage threshold_voltage_drop propagation_delay_low_to_high propagation_delay_high_to_low rise_time fall_time
quit
.endc
.end