* Testbench for Ratioed Latch with Pseudo-PMOS Clock Buffer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 N1 N3 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 LABEL_NET_0 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 LABEL_NET_2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Power Supplies
VVDD VDD 0 1.8
VN4 N4 0 1.8
VN0 N0 0 0

* Bias for pseudo-PMOS (always ON)
Vbias1 LABEL_NET_0 0 0
Vbias2 LABEL_NET_3 0 0

* CLK: 1GHz, 50% duty cycle
VCLK LABEL_NET_2 0 PULSE(0 1.8 0 10p 10p 490p 1n)
* Data: 1GHz, shifted to test transparent and hold phases
VDATA LABEL_NET_1 0 PULSE(0 1.8 700p 10p 10p 490p 1n)

.control
tran 1p 4n

* Measure delay from Data rising to N1 falling (transparent phase)
meas tran delay_data_eval trig v(LABEL_NET_1) val=0.9 rise=1 targ v(N1) val=0.9 fall=1

* Measure delay from CLK falling to N1 rising (precharge phase)
meas tran delay_clk_precharge trig v(LABEL_NET_2) val=0.9 fall=2 targ v(N1) val=0.9 rise=1

* Measure average currents to calculate power
meas tran avg_i_vdd avg i(VVDD)
meas tran avg_i_n4 avg i(VN4)
let power_consumption = -1.8 * (avg_i_vdd + avg_i_n4)

* Print results
print delay_data_eval
print delay_clk_precharge
print power_consumption

quit
.endc
.end