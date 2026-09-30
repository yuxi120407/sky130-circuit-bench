* Bootstrapped Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

* DUT
XM1 N3 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VDD N4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 LABEL_NET_2 LABEL_NET_3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N0 N1 N1 sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

* Sources
VVDD VDD 0 1.8
* Clocks for switching (100kHz)
VLABEL_NET_0 LABEL_NET_0 0 dc 1.8 pulse(1.8 0 5u 1n 1n 4.998u 10u)
VLABEL_NET_1 LABEL_NET_1 0 dc 1.8 pulse(1.8 0 5u 1n 1n 4.998u 10u)
VLABEL_NET_2 LABEL_NET_2 0 dc 0
VLABEL_NET_3 LABEL_NET_3 0 dc 0 pulse(0 1.8 5u 1n 1n 4.998u 10u)
VN0 N0 0 dc 1.8 pulse(0 1.8 1u 1n 1n 8.998u 10u)
VN1 N1 0 dc 1.8

* Input signal (1kHz sine wave)
Vin N2 0 dc 0.9 ac 1 sin(0.9 0.4 1k)
* Load capacitor
Cload N3 0 1p

.control
* === Transient Analysis ===
tran 100n 2m
let p_vdd = -i(VVDD)*1.8
let p_clk0 = -i(VLABEL_NET_0)*v(LABEL_NET_0)
let p_clk1 = -i(VLABEL_NET_1)*v(LABEL_NET_1)
let p_clk2 = -i(VLABEL_NET_2)*v(LABEL_NET_2)
let p_clk3 = -i(VLABEL_NET_3)*v(LABEL_NET_3)
let p_n0 = -i(VN0)*v(N0)
let p_n1 = -i(VN1)*v(N1)
let power = p_vdd + p_clk0 + p_clk1 + p_clk2 + p_clk3 + p_n0 + p_n1
meas tran power_consumption avg power

meas tran v_max max v(N3) from=1m to=2m
meas tran v_min min v(N3) from=1m to=2m

* Measure Dynamic Range
let v_ideal = 0.9 + 0.4 * sin(2 * pi * 1k * time)
let on_window = 1 - v(LABEL_NET_3)/1.8
let v_err_on = (v(N3) - v_ideal) * on_window
meas tran sig_rms rms v_ideal from=1m to=2m
meas tran err_rms rms v_err_on from=1m to=2m
let dynamic_range = 20 * log10(sig_rms / (err_rms * 1.414 + 1e-12))

* Measure THD to estimate SNDR/Dynamic Range
fourier 1k v(N3)

* === AC Analysis ===
* Force clocks to DC states that keep the switch ON
alter VLABEL_NET_0 dc=1.8
alter VLABEL_NET_1 dc=1.8
alter VLABEL_NET_2 dc=0
alter VLABEL_NET_3 dc=0
alter VN0 dc=0
alter VN1 dc=1.8
op
ac dec 10 1 1G
let gain_db = vdb(N3)
meas ac dc_gain find gain_db at=1k
meas ac bandwidth when gain_db=-3 fall=1

print power_consumption dc_gain bandwidth dynamic_range
quit
.endc
.end