* Dickson Charge Pump Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Define missing parameters for the parameterized netlist
.param W_xm1=5 L_xm1=0.15
.param W_xm2=5 L_xm2=0.15
.param W_xm3=5 L_xm3=0.15
.param W_xm4=5 L_xm4=0.15
.param W_xm5=5 L_xm5=0.15
.param W_xm6=5 L_xm6=0.15
.param W_xm7=5 L_xm7=0.15
.param W_xm8=20 L_xm8=2
.param W_xm9=20 L_xm9=2
.param W_xm10=20 L_xm10=2
.param W_xm11=20 L_xm11=2
.param W_xm12=20 L_xm12=2
.param W_xm13=20 L_xm13=2
.param W_xm14=2 L_xm14=0.15
.param W_xm15=4 L_xm15=0.15
.param W_xm16=2 L_xm16=0.15
.param W_xm17=4 L_xm17=0.15
.param W_xm18=4 L_xm18=0.15
.param W_xm19=2 L_xm19=0.15

* --- DUT --- 
xm19 N007 clk 0 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
VDD VDD 0 1.8
xm18 N007 clk VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
xm1 VDD VDD N001 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N002 N001 N001 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 N003 N002 N002 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 N004 N003 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 N005 N004 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N006 N005 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 Vpump N006 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
C1 Vpump 0 1e-12
xm8 N007 N001 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 N009 N002 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N007 N003 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 N009 N004 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm12 N007 N005 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 N009 N006 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm14 N008 clk 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N008 clk VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
xm16 N009 N008 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 N009 N008 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
* -----------

* Stimulus: 10 MHz clock
Vclk clk 0 PULSE(0 1.8 0 1n 1n 49n 100n)

* Initial conditions to speed up startup
.ic v(Vpump)=0 v(N001)=0 v(N002)=0 v(N003)=0 v(N004)=0 v(N005)=0 v(N006)=0

.control
* Run for 10us (100 clock cycles) to reach steady state
tran 10n 10u

* Measure the swing of the last pumped node (N006)
meas tran v_n006_max max v(N006) from=9u to=10u
meas tran v_n006_min min v(N006) from=9u to=10u

* Measure the final DC output voltage
meas tran v_pump_dc avg v(Vpump) from=9u to=10u

print v_n006_max v_n006_min v_pump_dc
quit
.endc
.end