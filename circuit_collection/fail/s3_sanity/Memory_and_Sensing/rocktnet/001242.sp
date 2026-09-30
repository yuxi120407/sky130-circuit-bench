* Dynamic Latch Testbench
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

VVDD VDD 0 1.8
* CLK at 900 MHz (1.111ns period)
VCLK CLK 0 PULSE(0 1.8 0.5n 20p 20p 500p 1.111n)
* D and DB toggle at 450 MHz to test both states
VD D 0 PULSE(0 1.8 0 20p 20p 1.111n 2.222n)
VDB DB 0 PULSE(1.8 0 0 20p 20p 1.111n 2.222n)

XM1 Q DB GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 QB Q GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 QB D GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 Q QB GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 Q CLK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 QB CLK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

* Load capacitance
C1 Q 0 10f
C2 QB 0 10f

.control
tran 5p 5n
* Measure delay for QB falling (first evaluation cycle)
meas tran delay_clk_qb_fall trig v(clk) val=0.9 rise=1 targ v(qb) val=0.9 fall=1
* Measure delay for Q falling (second evaluation cycle)
meas tran delay_clk_q_fall trig v(clk) val=0.9 rise=2 targ v(q) val=0.9 fall=1

* Measure voltage swing
meas tran v_max max v(q)
meas tran v_min min v(q)
let swing = v_max - v_min
print swing

* Measure average power
meas tran i_avg avg i(VVDD) from=0 to=5n
let pwr = -i_avg * 1.8
print pwr

quit
.endc
.end
