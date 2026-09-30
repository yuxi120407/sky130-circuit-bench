* Testbench for Cascode Amplifier Branch
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N1 LABEL_NET_1 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

VVDD VDD 0 1.8
VGND GND 0 0

* Supply connections
V_LABEL_NET_0 LABEL_NET_0 0 1.8
V_N2 N2 0 0

* Bias voltages for PMOS cascode
V_LABEL_NET_1 LABEL_NET_1 0 1.0
V_LABEL_NET_2 LABEL_NET_2 0 0.5

* Input signal with DC feedback for self-biasing in high-gain region
Vac IN_AC 0 dc 0 ac 1
C1 IN_AC LABEL_NET_3 1
L1 N0 LABEL_NET_3 1G

* Load capacitance
CL N0 0 100f

.control
op
let power = -i(V_LABEL_NET_0) * 1.8
print power
print v(N0)

ac dec 100 1 10G
let gain_db = vdb(N0)
let phase = 180/PI * cph(v(N0))
meas ac dc_gain find gain_db at=10
meas ac ugf when gain_db=0 fall=1
meas ac phase_at_ugf find phase when gain_db=0 fall=1
quit
.endc
.end