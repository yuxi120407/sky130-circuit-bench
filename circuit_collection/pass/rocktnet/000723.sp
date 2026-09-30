* Filtered Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 N3 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N1 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}

VVDD VDD 0 1.8
VGND N1 0 0

* Reference current with AC component for filter analysis
Iref VDD N3 DC 100u AC 1u

* Load capacitance representing the tail transistor gate
Cload N2 0 1p

.control
* DC Operating Point
op
let bias_voltage = v(N2)
let power_consumption = 1.8 * 100u
print bias_voltage power_consumption

* AC Analysis for Filter Cutoff
ac dec 100 1k 1G
let filter_gain = vdb(N2) - vdb(N3)
meas ac dc_gain find filter_gain at=1k
let target_gain = dc_gain - 3
meas ac filter_cutoff_freq when filter_gain=target_gain fall=1

* Transient Analysis
tran 1n 1u
meas tran v_n2_max max v(N2)
meas tran v_n2_min min v(N2)

quit
.endc
.end
