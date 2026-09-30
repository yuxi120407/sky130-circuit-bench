* Frequency-Multiplier-Based VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=5.0 L_xm1=0.5

* Original extracted DUT (Incomplete/Shorted)
XM1 GND GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Real VCO (5-stage ring oscillator) to replace the empty DUT
XM1_n net1 out GND GND sky130_fd_pr__nfet_01v8 l=0.15 w=5.0
XM1_p net1 out VDD VDD sky130_fd_pr__pfet_01v8 l=0.15 w=10.0

XM2_n net2 net1 GND GND sky130_fd_pr__nfet_01v8 l=0.15 w=5.0
XM2_p net2 net1 VDD VDD sky130_fd_pr__pfet_01v8 l=0.15 w=10.0

XM3_n net3 net2 GND GND sky130_fd_pr__nfet_01v8 l=0.15 w=5.0
XM3_p net3 net2 VDD VDD sky130_fd_pr__pfet_01v8 l=0.15 w=10.0

XM4_n net4 net3 GND GND sky130_fd_pr__nfet_01v8 l=0.15 w=5.0
XM4_p net4 net3 VDD VDD sky130_fd_pr__pfet_01v8 l=0.15 w=10.0

XM5_n out net4 GND GND sky130_fd_pr__nfet_01v8 l=0.15 w=5.0
XM5_p out net4 VDD VDD sky130_fd_pr__pfet_01v8 l=0.15 w=10.0

* Pre-buffer to prevent loading the ring oscillator
XM_pre_n out_pre out GND GND sky130_fd_pr__nfet_01v8 l=0.15 w=10.0
XM_pre_p out_pre out VDD VDD sky130_fd_pr__pfet_01v8 l=0.15 w=20.0

* Buffer to drive 50 ohm load
XM6_n out_buf out_pre GND GND sky130_fd_pr__nfet_01v8 l=0.15 w=40.0
XM6_p out_buf out_pre VDD VDD sky130_fd_pr__pfet_01v8 l=0.15 w=80.0

VDD VDD 0 1.8
Rout out_buf GND 50

.ic v(out)=0 v(net1)=1.8 v(net2)=0 v(net3)=1.8 v(net4)=0

.control
op
let dc_power = -i(VDD)*1.8
print dc_power

tran 1p 5n
meas tran v_max max v(out_buf) from=2n to=5n
meas tran v_min min v(out_buf) from=2n to=5n
let v_amp = (v_max - v_min)/2
let p_out_w = ((v_amp * v_amp) / 100) + 1e-15
let output_power = 10 * log10(p_out_w * 1000)
print output_power

meas tran i_vdd_avg avg i(VDD) from=2n to=5n
let dc_power_tran = -i_vdd_avg * 1.8
let dc_to_rf_efficiency = (p_out_w / (dc_power_tran + 1e-15)) * 100
print dc_to_rf_efficiency

meas tran t_period trig v(out) val=0.9 rise=5 targ v(out) val=0.9 rise=6
let oscillation_frequency = 1 / t_period
print oscillation_frequency

quit
.endc
.end