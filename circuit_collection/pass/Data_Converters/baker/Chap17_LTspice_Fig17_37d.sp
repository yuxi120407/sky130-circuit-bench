* Sky130 Testbench for Baker Fig 17.36 Delta-Sigma Sensing Circuit
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

* Parameter definitions for DUT sizing
.param W_xm1=1.0  L_xm1=0.15
.param W_xm2=1.0  L_xm2=0.15
.param W_xm3=5.0  L_xm3=1.5
.param W_xm4=1.0  L_xm4=0.15
.param W_xm5=1.0  L_xm5=0.15
.param W_xm6=1.0  L_xm6=0.15
.param W_xm7=1.0  L_xm7=1.5
.param W_xm8=1.0  L_xm8=0.15
.param W_xm9=1.0  L_xm9=0.15
.param W_xm10=1.0 L_xm10=0.15
.param W_xm11=5.0 L_xm11=1.5
.param W_xm12=1.0 L_xm12=1.5
.param W_xm13=50.0 L_xm13=1.5
.param W_xm14=50.0 L_xm14=1.5
.param W_xm15=2.0 L_xm15=0.15
.param W_xm16=2.0 L_xm16=0.15
.param W_xm17=2.0 L_xm17=0.15
.param W_xm18=2.0 L_xm18=0.15
.param W_xm19=2.0 L_xm19=0.15
.param W_xm20=2.0 L_xm20=0.15
.param W_xm21=1.0 L_xm21=0.15
.param W_xm22=1.0 L_xm22=0.15
.param W_xm23=1.0 L_xm23=0.15
.param W_xm24=1.0 L_xm24=0.15

* Power Supplies
VDD VDD 0 1.8
Vr Vr 0 DC 1.2
Vi Vi 0 DC 0.9

* Non-overlapping two-phase clock generator (100 MHz, T=10ns)
Vphi1 phi1 0 DC 1.8 PULSE(0 1.8 0.5n 0.1n 0.1n 3.8n 10n)
Vphi2 phi2 0 DC 0 PULSE(0 1.8 5.5n 0.1n 0.1n 3.8n 10n)

* DUT Instance
xm3 VDD N005 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm5 N006 phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm7 vbuck vbucki VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
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
  xm3 out B N001 VDD sky130_fd_pr__pfet_01v8 w=1.0 l=0.15
  xm8 N001 A VDD VDD sky130_fd_pr__pfet_01v8 w=1.0 l=0.15
  xm11 out B GND 0 sky130_fd_pr__nfet_01v8 w=0.5 l=0.15
  xm12 out A 0 0 sky130_fd_pr__nfet_01v8 w=0.5 l=0.15
.ends NOR_2

.control
* Run transient analysis
tran 0.1n 1500n uic

* Measure shifted voltages (DC effective values)
meas tran shifted_reference_voltage MAX v(N001) from=500n to=1500n
meas tran shifted_intensity_voltage MAX v(N002) from=500n to=1500n

* Measure average power
meas tran i_vdd_avg avg i(VDD) from=500n to=1500n
let average_sensing_power = -i_vdd_avg * 1.8

* Calculate converter resolution (N=10 based on capacitor ratio)
let converter_resolution = shifted_reference_voltage / 10

* Calculate theoretical capacitance of the hold capacitor (xm11: W=5.0, L=1.5)
* Cox for SKY130 1.8V device is approx 8.46 fF/um^2
let W_cap = 5.0
let L_cap = 1.5
let Cox = 8.46e-15
let C_calc = W_cap * L_cap * Cox

* Calculate thermal noise (kT/C)
let k_boltz = 1.380649e-23
let temp_k = 298.15
let thermal_noise_hold_cap = sqrt(k_boltz * temp_k / C_calc)

* Calculate equivalent resistance (1 / (f * C))
let f_clk = 100e6
let switched_capacitor_equivalent_resistance = 1 / (f_clk * C_calc)

* Print all metrics
print shifted_reference_voltage
print shifted_intensity_voltage
print converter_resolution
print thermal_noise_hold_cap
print switched_capacitor_equivalent_resistance
print average_sensing_power

quit
.endc
.end