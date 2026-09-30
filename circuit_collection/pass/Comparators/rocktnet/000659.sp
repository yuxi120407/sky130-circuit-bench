* CML Latch Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

* Supply and CML Load Resistors
VVDD VDD 0 1.8
R1 VDD OUTP 1k
R2 VDD OUTM 1k

* Bias Voltages
VLABEL_NET_3 LABEL_NET_3 0 0.9
VLABEL_NET_4 LABEL_NET_4 0 0.9

* Differential Input (Toggles at 1 GHz, offset to change during hold phase)
VINP INP 0 PULSE(0.7 1.1 400p 50p 50p 400p 1000p)
VINM INM 0 PULSE(1.1 0.7 400p 50p 50p 400p 1000p)

* Differential Clock (2 GHz)
VCLK CLK 0 PULSE(0 1.8 0 50p 50p 200p 500p)
VCLKB CLKB 0 PULSE(1.8 0 0 50p 50p 200p 500p)

* DUT
XM1 OUTP OUTM N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUTP INM N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUTM OUTP N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUTM INP N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 CLKB N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 LABEL_NET_4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 CLK N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.control
tran 2p 3n

* Calculate differential output
let vdiff = v(outp) - v(outm)

* Measure CLK-to-Q delay
meas tran clk_to_q_delay trig v(clk) val=0.9 rise=1 td=450p targ vdiff val=0 rise=1 td=450p
print clk_to_q_delay

* Measure single-ended output swing
meas tran out_max max v(outp) from=1n to=3n
meas tran out_min min v(outp) from=1n to=3n
let output_swing = out_max - out_min
print output_swing

* Measure average power consumption
meas tran pwr_avg avg i(VVDD) from=1n to=3n
let power_consumption = -pwr_avg * 1.8
print power_consumption

* Operating frequency
let operating_frequency = 2e9
print operating_frequency

quit
.endc
.end