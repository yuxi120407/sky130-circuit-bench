* Testbench for Fig. 18.40b NMOS Clock Driver
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmc1=0.5
.param L_xmc2=0.5

* Parameter definitions based on Baker Fig. 18.40b (all unlabeled 10/1, output 40/1, capacitors 10/10)
.param scale=1.0
.param W_xm1={10*scale}   L_xm1={1*scale}
.param W_xm2={10*scale}   L_xm2={1*scale}
.param W_xm3={10*scale}   L_xm3={1*scale}
.param W_xm4={10*scale}   L_xm4={1*scale}
.param W_xm5={10*scale}   L_xm5={1*scale}
.param W_xm6={10*scale}   L_xm6={1*scale}
.param W_xm7={10*scale}   L_xm7={1*scale}
.param W_xm8={10*scale}   L_xm8={1*scale}
.param W_xm9={10*scale}   L_xm9={1*scale}
.param W_xm10={10*scale}  L_xm10={1*scale}
.param W_xm11={40*scale}  L_xm11={1*scale}
.param W_xm12={10*scale}  L_xm12={1*scale}
.param W_xm13={40*scale}  L_xm13={1*scale}
.param W_xm14={10*scale}  L_xm14={1*scale}
.param W_xm15={10*scale}  L_xm15={1*scale}
.param W_xmc1={10*scale}  L_xmc1={10*scale}
.param W_xmc2={10*scale}  L_xmc2={10*scale}

* DUT Netlist
xm1 N003 R 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xmc1 S A S 0 sky130_fd_pr__nfet_01v8 w={W_xmc1} l={L_xmc1}
xm2 VDD S N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 N004 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 VDD R N004 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 VDD R A 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 B A S 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 A S N004 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 N002 R 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 B VDD N002 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N001 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xmc2 N001 B N001 0 sky130_fd_pr__nfet_01v8 w={W_xmc2} l={L_xmc2}
xm12 VDD B N001 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 VDD B out 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm11 out N005 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
Cload out 0 1e-13
xm14 N005 S 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 VDD R N005 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}

* Complementary non-overlapping clock inputs S (Set) and R (Reset) at 100 MHz
VS S 0 PULSE(0 1.8 2.5n 0.1n 0.1n 4.4n 10n)
VR R 0 PULSE(1.8 0 2.0n 0.1n 0.1n 5.4n 10n)

.ic v(out)=0
.tran 0.01n 30n

.control
run

* Output High and Low levels
meas tran output_high_voltage max v(out) from=13n to=16n
meas tran output_low_voltage min v(out) from=18n to=21n
let output_voltage_swing = output_high_voltage - output_low_voltage

* Boot node B peak voltage
meas tran boot_node_b_peak_voltage max v(B) from=10n to=20n

* Calculate 10%, 50%, 90% levels
let v90 = output_low_voltage + 0.9 * output_voltage_swing
let v50 = output_low_voltage + 0.5 * output_voltage_swing
let v10 = output_low_voltage + 0.1 * output_voltage_swing

* Output Rise and Fall times
meas tran rise_time trig v(out) val=$&v10 rise=1 td=10n targ v(out) val=$&v90 rise=1 td=10n
meas tran fall_time trig v(out) val=$&v90 fall=1 td=10n targ v(out) val=$&v10 fall=1 td=10n

* Propagation Delays
meas tran propagation_delay_low_to_high trig v(S) val=0.9 rise=1 td=10n targ v(out) val=$&v50 rise=1 td=10n
meas tran propagation_delay_high_to_low trig v(R) val=0.9 rise=1 td=10n targ v(out) val=$&v50 fall=1 td=10n

* Average Power Consumption
meas tran i_avg avg i(VDD) from=10n to=30n
let average_power = -i_avg * 1.8

print output_high_voltage output_low_voltage output_voltage_swing boot_node_b_peak_voltage rise_time fall_time propagation_delay_low_to_high propagation_delay_high_to_low average_power

quit
.endc
.end