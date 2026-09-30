* 5-stage CMOS Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

XM1_1 v1 vin 0 0 sky130_fd_pr__nfet_01v8 w=1.0 l=0.15 m=1
XM2_1 v1 vin vdd vdd sky130_fd_pr__pfet_01v8 w=1.0 l=0.15 m=2

XM1_2 v2 v1 0 0 sky130_fd_pr__nfet_01v8 w=1.0 l=0.15 m=8
XM2_2 v2 v1 vdd vdd sky130_fd_pr__pfet_01v8 w=1.0 l=0.15 m=16

XM1_3 v3 v2 0 0 sky130_fd_pr__nfet_01v8 w=1.0 l=0.15 m=64
XM2_3 v3 v2 vdd vdd sky130_fd_pr__pfet_01v8 w=1.0 l=0.15 m=128

XM1_4 v4 v3 0 0 sky130_fd_pr__nfet_01v8 w=1.0 l=0.15 m=512
XM2_4 v4 v3 vdd vdd sky130_fd_pr__pfet_01v8 w=1.0 l=0.15 m=1024

XM1_5 vout v4 0 0 sky130_fd_pr__nfet_01v8 w=1.0 l=0.15 m=4096
XM2_5 vout v4 vdd vdd sky130_fd_pr__pfet_01v8 w=1.0 l=0.15 m=8192

Cload vout 0 20p

VDD vdd 0 1.8
Vin vin 0 PULSE(0 1.8 1n 0.1n 0.1n 4n 10n)

.tran 10p 10n
.dc Vin 0 1.8 0.1

.control
run

setplot tran1
meas tran tplh trig v(vin) val=0.9 fall=1 targ v(vout) val=0.9 rise=1
meas tran tphl trig v(vin) val=0.9 rise=1 targ v(vout) val=0.9 fall=1
let total_propagation_delay = (tplh + tphl) / 2
print total_propagation_delay

meas tran pwr_avg avg i(VDD) from=0 to=10n
let power_delay_product = -pwr_avg * 1.8 * total_propagation_delay
print power_delay_product

meas tran Q_in integ i(Vin) from=0.9n to=2n
let C_in = abs(Q_in) / 1.8

let optimal_number_of_stages = ln(20e-12 / C_in)
print optimal_number_of_stages

let stage_scaling_factor = 8
print stage_scaling_factor

meas tran tplh_dist trig v(vin) val=0.9 rise=1 targ v(v4) val=0.9 rise=1
meas tran tphl_dist trig v(vin) val=0.9 fall=1 targ v(v4) val=0.9 fall=1
let distributed_driver_delay = (tplh_dist + tphl_dist) / 2
print distributed_driver_delay

meas tran tplh_rc trig v(v4) val=0.9 fall=1 targ v(vout) val=0.9 rise=1
meas tran tphl_rc trig v(v4) val=0.9 rise=1 targ v(vout) val=0.9 fall=1
let rc_line_delay = (tplh_rc + tphl_rc) / 2
print rc_line_delay

.endc
.end