* D-FF Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.subckt inv in out VDD GND
XM1 out in GND GND sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
XM2 out in VDD VDD sky130_fd_pr__pfet_01v8 w=2.0 l=0.15
.ends

.subckt tg in out en en_b VDD GND
XM1 in en out GND sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
XM2 in en_b out VDD sky130_fd_pr__pfet_01v8 w=2.0 l=0.15
.ends

.subckt dff d clk clk_b q VDD GND
Xtg1 d n1 clk_b clk VDD GND tg
Xinv1 n1 n2 VDD GND inv
Xinv2 n2 n3 VDD GND inv
Xtg2 n3 n1 clk clk_b VDD GND tg

Xtg3 n2 n4 clk clk_b VDD GND tg
Xinv3 n4 q VDD GND inv
Xinv4 q n5 VDD GND inv
Xtg4 n5 n4 clk_b clk VDD GND tg
.ends

VDD VDD 0 1.8
VD D 0 PWL(0 0.9 10n 0.9 10.1n 1.8 18n 1.8 18.1n 0 34.8n 0 34.9n 1.8 35.2n 1.8 35.3n 0)
Vclk_src clk_src 0 PULSE(0 1.8 5n 0.1n 0.1n 4.9n 10n)
Vmeas_clk clk_src clk 0
Xinv_clk clk clk_b VDD 0 inv
Xdff D clk clk_b Q VDD 0 dff

Bvalid valid 0 V = (v(Q) > 1.6) + (v(Q) < 0.2)

Xinv_test in_test out_test VDD 0 inv
Vtest in_test 0 0

.ic v(Q)=0.9 v(Xdff.n4)=0.9 v(Xdff.n5)=0.9

.control
dc Vtest 0 1.8 0.01
meas dc switching_point_voltage find v(in_test) when v(in_test)=v(out_test)
print switching_point_voltage

tran 0.01n 40n
meas tran metastability_delay trig v(clk) val=0.9 rise=1 targ v(valid) val=0.5 rise=1 from=4n to=10n
meas tran clock_to_q_delay trig v(clk) val=0.9 rise=1 targ v(Q) val=0.9 fall=1 from=24n to=30n
meas tran setup_time trig v(D) val=0.9 rise=1 targ v(clk) val=0.9 rise=1 from=34n to=36n
meas tran hold_time trig v(clk) val=0.9 rise=1 targ v(D) val=0.9 fall=1 from=34n to=36n
meas tran propagation_delay trig v(Xdff.n1) val=0.9 rise=1 targ v(Xdff.n2) val=0.9 fall=1 from=34n to=36n

meas tran q_in integ i(Vmeas_clk) from=34.9n to=35.2n
let input_capacitance = q_in / 1.8
print input_capacitance

print metastability_delay clock_to_q_delay setup_time hold_time propagation_delay
.endc
.end