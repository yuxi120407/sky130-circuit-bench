* Schmitt Trigger Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

XM1 n2 vin gnd gnd sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM2 vout vin n2 gnd sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM3 vdd vout n2 gnd sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM4 n1 vin vdd vdd sky130_fd_pr__pfet_01v8 w=20.0 l=0.15
XM5 vout vin n1 vdd sky130_fd_pr__pfet_01v8 w=20.0 l=0.15
XM6 gnd vout n1 vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.15

VDD vdd 0 1.8
Vin vin 0 PWL(0 0 20n 1.8 40n 1.8 60n 0 70n 0 70.1n 1.8 80n 1.8 80.1n 0 100n 0)
Cload vout 0 10f

.control
tran 0.1n 100n
meas tran upper_switching_point_VSPH find v(vin) when v(vout)=0.9 fall=1
meas tran lower_switching_point_VSPL find v(vin) when v(vout)=0.9 rise=1
meas tran propagation_delay_tpHL trig v(vin) val=0.9 rise=2 targ v(vout) val=0.9 fall=2
meas tran propagation_delay_tpLH trig v(vin) val=0.9 fall=2 targ v(vout) val=0.9 rise=2

dc vin 0 1.8 0.01
let m2_sizing_rule = 1.0

print tran1.upper_switching_point_VSPH tran1.lower_switching_point_VSPL tran1.propagation_delay_tpHL tran1.propagation_delay_tpLH m2_sizing_rule
.endc
.end