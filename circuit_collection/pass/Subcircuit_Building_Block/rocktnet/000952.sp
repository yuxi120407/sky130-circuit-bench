* Switchable Bias/Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmn1=0.5
.param L_xmn2=0.5
.param L_xmp1=0.5

.param W_xmn1=5.0 L_xmn1=0.5
.param W_xmn2=5.0 L_xmn2=0.5
.param W_xmp1=5.0 L_xmp1=0.5

XMN1 N2 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xmn1} w={W_xmn1}
XMN2 VB N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xmn2} w={W_xmn2}
XMP1 VB VB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp1} w={W_xmp1}

VVDD VDD 0 1.8
VN2_src N2_src 0 dc 0.9 ac 1
R1 N2_src N2 10k
VN1 N1 0 dc 0 pulse(0 1.8 10n 1n 1n 40n 100n)
Cload VB 0 10f

.control
* 1. Operating Point & Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* 2. AC Analysis
ac dec 100 10 10G
let gain_db = vdb(VB) - vdb(N2)
meas ac dc_gain find gain_db at=10
meas ac bandwidth when gain_db='dc_gain-3' fall=1
print dc_gain bandwidth

* 3. Transient Analysis
tran 0.1n 100n
meas tran turn_off_time trig v(N1) val=0.9 rise=1 targ v(VB) val=0.9 rise=1
print turn_off_time

quit
.endc
.end