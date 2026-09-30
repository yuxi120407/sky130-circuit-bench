* Dynamic Preamplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

VVDD VDD 0 1.8
VBIAS BIAS 0 1.2
VVREF VREF 0 1.2
VINP INP 0 1.25
VCLK CLK 0 PULSE(0 1.8 0.1n 20p 20p 0.4n 1n)
VCLKB CLK_B 0 PULSE(0 1.8 0.1n 20p 20p 0.4n 1n)

C1 OUTP 0 20f
C2 OUTM 0 20f

XM5 OUTP CLK_B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUTM CLK_B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM3 TAIL CLK N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 TAIL CLK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUTP OUTM CLK_B VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM7 OUTP VREF TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 OUTM INP TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

.control
tran 1p 3n

* Measure evaluation delay (time for OUTM to drop to 1.5V)
meas tran evaluation_delay trig v(clk) val=0.9 rise=1 targ v(outm) val=1.5 fall=1

* Measure voltages at 0.51ns (just before CLK falls)
meas tran v_outm_eval find v(outm) at=0.51n
meas tran v_outp_eval find v(outp) at=0.51n

* Calculate gain
let vdiff_out = v_outp_eval - v_outm_eval
let gain = vdiff_out / 0.05
let voltage_gain = 20 * log10(abs(gain))
print voltage_gain

* Measure precharge time
meas tran precharge_time trig v(clk) val=0.9 fall=1 targ v(outm) val=1.7 rise=1

* Measure average power
let power = -i(VVDD) * 1.8
meas tran average_power avg power from=0 to=2n

quit
.endc
.end