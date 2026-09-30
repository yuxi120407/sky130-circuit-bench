* Switch Driver Testbench
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

* DUT parameters
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5

* DUT
XM1 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 LABEL_NET_2 LABEL_NET_0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 LABEL_NET_4 LABEL_NET_3 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 LABEL_NET_5 VDD N2 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 LABEL_NET_6 VDD N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

* Fix for XM10 extraction error (extracted as PMOS with G=VDD, which is always off)
* Adding an NMOS pass gate in parallel to restore intended functionality (symmetric to XM9)
XM10_fix LABEL_NET_6 VDD N3 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Load capacitors to simulate driving the current switches
Cload0 N0 0 50f
Cload1 N1 0 50f

* Sources
VVDD VDD 0 1.8
* 1 GHz Clock
VCLK1 LABEL_NET_0 0 PULSE(0 1.8 0.5n 20p 20p 0.4n 1n)
VCLK2 LABEL_NET_4 0 PULSE(0 1.8 0.5n 20p 20p 0.4n 1n)
* Data inputs (transitioning 200ps before clock edge to allow pre-charging for asymmetric crossing)
VIN LABEL_NET_2 0 PULSE(0 1.8 0.3n 20p 20p 0.9n 2n)
VINB LABEL_NET_3 0 PULSE(1.8 0 0.3n 20p 20p 0.9n 2n)
VIN2 LABEL_NET_5 0 PULSE(0 1.8 0.3n 20p 20p 0.9n 2n)
VINB2 LABEL_NET_6 0 PULSE(1.8 0 0.3n 20p 20p 0.9n 2n)

* Analysis
.control
tran 5p 3n

* Power
let pwr = -i(VVDD)*1.8
meas tran avg_power avg pwr from=0 to=3n

* Delays
meas tran t_clk_rise1 when v(LABEL_NET_0)=0.9 rise=1
meas tran t_out_rise when v(N1)=0.9 rise=1 from=0.3n
let delay_rise = t_out_rise - t_clk_rise1

meas tran t_clk_rise2 when v(LABEL_NET_0)=0.9 rise=2
meas tran t_out_fall when v(N1)=0.9 fall=1 from=1.3n
let delay_fall = t_out_fall - t_clk_rise2

* Rise/Fall times
meas tran t_rise trig v(N1) val=0.36 rise=1 targ v(N1) val=1.44 rise=1
meas tran t_fall trig v(N1) val=1.44 fall=1 targ v(N1) val=0.36 fall=1

* Crossing point
let vdiff = v(N1) - v(N0)
meas tran cross_time when vdiff=0 cross=1 from=0.3n to=0.8n
meas tran cross_vol find v(N1) at=cross_time

print avg_power delay_rise delay_fall t_rise t_fall cross_vol
quit
.endc
.end
