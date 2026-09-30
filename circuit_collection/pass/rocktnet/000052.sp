* Switched-Current Amplifier Sub-circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=15.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=15.0

XM1 N0 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VN2 N2 0 DC 0.9 AC 1 SIN(0.9 0.1 1Meg)
RLOAD N0 0 500k

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac dec 100 1k 10G
let gain_db = db(v(N0))
meas ac voltage_gain find gain_db at=10k
meas ac bandwidth when gain_db=0 fall=1
print voltage_gain
print bandwidth

tran 1n 2u
meas tran v_max max v(N0)
meas tran v_min min v(N0)
print v_max v_min

quit
.endc
.end