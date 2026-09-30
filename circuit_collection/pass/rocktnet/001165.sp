* Single NMOS Characterization Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmf=0.5

.param W_xmf=5.0 L_xmf=0.5

* DUT
XMF LABEL_NET_3 IIN N0 GND sky130_fd_pr__nfet_01v8 l={L_xmf} w={W_xmf}

* Voltage Sources
VVDD VDD 0 1.8
VIIN IIN 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)
VLABEL_NET_3 LABEL_NET_3 0 0.9
VN0 N0 0 0

.control
* DC Operating Point
op
let id_dc = -i(VLABEL_NET_3)
let power_dc = id_dc * 0.9
print id_dc
print power_dc

* AC Analysis for gm
ac dec 10 1k 100MEG
let gm_ac = mag(i(VLABEL_NET_3)) / mag(v(IIN))
meas ac gm_1M find gm_ac at=1MEG

* Transient Analysis
tran 10n 5u
meas tran id_max max i(VLABEL_NET_3)
meas tran id_min min i(VLABEL_NET_3)

quit
.endc
.end