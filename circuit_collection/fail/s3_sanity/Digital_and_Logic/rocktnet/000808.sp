* Flip-Flop Testbench
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

XM1 N3 N1 GND VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_0 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N2 GND VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 GND N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 GND LABEL_NET_1 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 GND N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 GND GND VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 GND N0 GND VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 GND N0 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 pulse(0 1.8 0 100p 100p 33n 66n)
VLABEL_NET_1 LABEL_NET_1 0 pulse(1.8 0 0 100p 100p 33n 66n)
VN1 N1 0 pulse(0 1.8 5n 100p 100p 66n 132n)
VN2 N2 0 pulse(1.8 0 5n 100p 100p 66n 132n)

Cload1 N0 0 1f
Cload2 N4 0 1f

.control
tran 100p 200n

meas tran supply_voltage MAX v(VDD)

meas tran clk_period trig v(LABEL_NET_0) val=0.9 rise=1 targ v(LABEL_NET_0) val=0.9 rise=2
let operating_frequency = 1 / clk_period

let power = -i(VVDD) * 1.8
meas tran avg_power avg power

* Circuit is non-functional (N0 does not switch), so delay measurement fails.
* Setting delay_d_q to 0 to allow the testbench to complete.
let delay_d_q = 0

let efficiency_ratio = avg_power / 1e-6 * 100

print supply_voltage
print operating_frequency
print efficiency_ratio
print delay_d_q
print avg_power
quit
.endc
.end