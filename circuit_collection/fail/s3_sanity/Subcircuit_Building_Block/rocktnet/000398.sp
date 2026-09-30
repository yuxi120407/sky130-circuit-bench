* Switched-Capacitor Switch Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N3 N6 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N10 CONTROL N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 CONTROL IN_MINUS GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Voltage Sources
V_IN_MINUS IN_MINUS 0 DC 0.9 AC 1 SIN(0.9 0.1 1Meg)
V_N4 N4 0 DC 0.8
V_CONTROL CONTROL 0 DC 1.8

V_N10 N10 0 DC 0.9
V_N1 N1 0 DC 0.8
V_N6 N6 0 DC 0 PULSE(0 1.8 50n 0.1n 0.1n 49.8n 100n)
V_N3 N3 0 DC 0.9

V_VDD VDD 0 DC 1.8

.control
* 1. AC Analysis for Bandwidth
ac dec 10 1Meg 10000G
meas ac i_low_freq find mag(i(V_N4)) at=1Meg
let i_3db_vec = i_low_freq * 1.414213
meas ac frequency when mag(i(V_N4))=$&i_3db_vec
print frequency

* 2. Transient Analysis for Power, Ron, Ioff, SFDR
tran 1n 10000n

* Supply voltage
meas tran supply_voltage avg v(VDD) from=0 to=10000n
print supply_voltage

* Power consumption
let p_inst = -(i(V_N6)*v(N6) + i(V_VDD)*v(VDD) + i(V_CONTROL)*v(CONTROL) + i(V_IN_MINUS)*v(IN_MINUS) + i(V_N4)*v(N4) + i(V_N10)*v(N10) + i(V_N1)*v(N1) + i(V_N3)*v(N3))
meas tran power_consumption avg p_inst from=0 to=10000n
print power_consumption

* ON Resistance (Ron)
meas tran v_in_minus_val find v(IN_MINUS) at=25n
meas tran v_n4_val find v(N4) at=25n
meas tran I_XM3_ON find i(V_N4) at=25n
let ron = abs(v_in_minus_val - v_n4_val) / (abs(I_XM3_ON) + 1e-20)
print ron

* OFF Leakage Current (Ioff)
meas tran I_XM1_OFF find i(V_N3) at=25n
let ioff = abs(I_XM1_OFF)
print ioff

* SFDR
let i_n4_tran = i(V_N4)
linearize i_n4_tran
set specwindow = blackman
fft i_n4_tran
meas ac fund MAX mag(i_n4_tran) from=0.8Meg to=1.2Meg
meas ac spur1 MAX mag(i_n4_tran) from=0.1Meg to=0.5Meg
meas ac spur2 MAX mag(i_n4_tran) from=1.5Meg to=50Meg
let max_spur = spur1 + (spur2 > spur1) * (spur2 - spur1)
let max_spur_safe = max_spur + 1e-20
let sfdr = 20 * log10(fund / max_spur_safe)
print sfdr

quit
.endc
.end