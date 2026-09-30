* DSM Sensing Circuit Testbench (Baker Fig. 17.36)
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
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Transistor dimensions (scale factor = 0.15um)
.param scale=0.15
.param W_xm1={10*scale}   L_xm1={1*scale}
.param W_xm2={10*scale}   L_xm2={1*scale}
.param W_xm3={50*scale}   L_xm3={10*scale}
.param W_xm4={10*scale}   L_xm4={1*scale}
.param W_xm5={10*scale}   L_xm5={1*scale}
.param W_xm6={10*scale}   L_xm6={1*scale}
.param W_xm7={10*scale}   L_xm7={10*scale}
.param W_xm8={10*scale}   L_xm8={1*scale}
.param W_xm9={10*scale}   L_xm9={1*scale}
.param W_xm10={10*scale}  L_xm10={1*scale}
.param W_xm11={50*scale}  L_xm11={10*scale}
.param W_xm12={10*scale}  L_xm12={10*scale}
.param W_xm13={500*scale} L_xm13={10*scale}
.param W_xm14={500*scale} L_xm14={10*scale}
.param W_xm15={20*scale}  L_xm15={1*scale}
.param W_xm16={20*scale}  L_xm16={1*scale}
.param W_xm17={20*scale}  L_xm17={1*scale}
.param W_xm18={20*scale}  L_xm18={1*scale}
.param W_xm19={20*scale}  L_xm19={1*scale}
.param W_xm20={20*scale}  L_xm20={1*scale}
.param W_xm21={10*scale}  L_xm21={1*scale}
.param W_xm22={10*scale}  L_xm22={1*scale}
.param W_xm23={10*scale}  L_xm23={1*scale}
.param W_xm24={10*scale}  L_xm24={1*scale}

* DUT Circuit
VDD VDD 0 1.8
xm3 VDD N005 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm5 N006 phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm7 vbuck vbucki VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
Vr Vr 0 650m
Vi Vi 0 600m
xm1 N005 phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N004 phi1 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm4 N003 phi1 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm6 N002 VDD N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm8 N001 Q N003 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 vbuck Vi N002 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 vbucki Vr N001 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 VDD N006 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 vbucki vbucki VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 0 vbuck 0 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm14 0 vbucki 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 n1 vbuck VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
xm16 n2 vbucki VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
xm17 n3 Out n1 VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
xm18 n4 Outi n2 VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
xm19 Outi phi2 n3 VDD sky130_fd_pr__pfet_01v8 w={W_xm19} l={L_xm19}
xm20 Out phi2 n4 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
xm21 Out Outi 0 0 sky130_fd_pr__nfet_01v8 w={W_xm21} l={L_xm21}
xm22 Outi Out 0 0 sky130_fd_pr__nfet_01v8 w={W_xm22} l={L_xm22}
xm23 Outi phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 Out phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
X_U1 Out Qi Q VDD 0 NOR_2
X_U2 Q Outi Qi VDD 0 NOR_2

.subckt NOR_2 A B Out VDD GND
.param W_xm3=1.5 L_xm3=0.15
.param W_xm8=1.5 L_xm8=0.15
.param W_xm11=1.5 L_xm11=0.15
.param W_xm12=1.5 L_xm12=0.15
  xm3 out B N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm8 N001 A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm11 out B GND 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 out A 0 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
.ends NOR_2

* Non-overlapping two-phase clocks (period = 10ns, 100MHz)
Vphi1 phi1 0 PULSE(0 1.8 0.5n 0.2n 0.2n 3.5n 10n)
Vphi2 phi2 0 PULSE(0 1.8 5.5n 0.2n 0.2n 3.5n 10n)

.control
tran 0.1n 20000n uic

* Average feedback voltages during 10000ns to 20000ns sensing window (1000 cycles)
meas tran v_q_avg avg v(Q) from=10000n to=20000n
meas tran v_qi_avg avg v(Qi) from=10000n to=20000n

* Target metrics
meas tran shifted_reference_voltage avg v(N001) from=10000n to=20000n
meas tran shifted_signal_voltage avg v(N002) from=10000n to=20000n

let voltage_resolution = shifted_reference_voltage / 1000

let f_clk = 100e6
let C_cup = 7.5 * 1.5 * 8.42e-15
let switched_cap_resistance = 1 / (C_cup * f_clk)

let modulator_output_duty_cycle = v_q_avg / 1.8

let p_inst = -i(VDD) * 1.8
meas tran average_power avg p_inst from=10000n to=20000n

print shifted_reference_voltage
print shifted_signal_voltage
print voltage_resolution
print switched_cap_resistance
print modulator_output_duty_cycle
print average_power

quit
.endc
.end