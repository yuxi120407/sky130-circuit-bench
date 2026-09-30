* Digital Clock Multiplier Injection Multiplexer Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameters
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
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5

* DUT
XM1 N8 SEL_BAR GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT_BAR REF N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT_BAR VCO N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT REF_BAR N7 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUT VCO N8 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 SEL_BAR GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 SEL GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N7 SEL GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N5 SEL_BAR VCTRL VCTRL sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 SEL VCTRL VCTRL sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 OUT VCO N6 VCTRL sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 OUT_BAR REF N1 VCTRL sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 OUT_BAR VCO N2 VCTRL sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N1 SEL_BAR VCTRL VCTRL sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N2 SEL VCTRL VCTRL sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 OUT REF_BAR N5 VCTRL sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}

* Sources
VVCTRL VCTRL 0 1.8

* SEL=1 (REF selected) for 0-50ns, SEL=0 (VCO selected) for 50-100ns
VSEL SEL 0 pwl(0 1.8 50n 1.8 50.01n 0)
VSEL_BAR SEL_BAR 0 pwl(0 0 50n 0 50.01n 1.8)

* 100MHz Clocks (10ns period) - scaled to 2.5GHz for power measurement
VREF REF 0 pulse(0 1.8 0 20p 20p 4.98n 10n)
VREF_BAR REF_BAR 0 pulse(1.8 0 0 20p 20p 4.98n 10n)
VVCO VCO 0 pulse(0 1.8 2.5n 20p 20p 4.98n 10n)

* Load Capacitance
Cout OUT 0 10f
Cout_bar OUT_BAR 0 10f

.control
tran 20p 100n

* Measure delay from REF to OUT (during SEL=1 window)
meas tran delay_ref_rise trig v(ref) val=0.9 rise=1 td=12n targ v(out) val=0.9 rise=1 td=12n
meas tran delay_ref_fall trig v(ref) val=0.9 fall=1 td=12n targ v(out) val=0.9 fall=1 td=12n
let delay_ref = (delay_ref_rise + delay_ref_fall) / 2

* Measure delay from VCO to OUT (during SEL=0 window, OUT = NOT(VCO))
meas tran delay_vco_rise trig v(vco) val=0.9 fall=1 td=60n targ v(out) val=0.9 rise=1 td=60n
meas tran delay_vco_fall trig v(vco) val=0.9 rise=1 td=60n targ v(out) val=0.9 fall=1 td=60n
let delay_vco = (delay_vco_rise + delay_vco_fall) / 2

* Measure Average Power (scaled by 25x to represent 2.5GHz operation)
meas tran ivctrl_avg AVG i(VVCTRL) from=0 to=100n
let power_dyn = -ivctrl_avg * 1.8 * 25

print delay_ref delay_vco power_dyn

quit
.endc
.end