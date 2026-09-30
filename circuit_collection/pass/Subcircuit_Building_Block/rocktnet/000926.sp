* Class-AB Output Stage Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_bias=0.5
.param L_bias_s=0.5
.param L_xmn=0.5
.param L_xmns=0.5
.param L_xmp=0.5
.param L_xmps=0.5

.param W_xmps=5.0 L_xmps=0.5
.param W_xmp=5.0 L_xmp=0.5
.param W_xmn=5.0 L_xmn=0.5
.param W_xmns=5.0 L_xmns=0.5

XMPS VOS N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmps} w={W_xmps}
XMP VO N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp} w={W_xmp}
XMN VO N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xmn} w={W_xmn}
XMNS VOS N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xmns} w={W_xmns}

VVDD VDD 0 1.8

* Biasing for Class-AB operation
* DC feedback loop to set VO=0.9V and balance currents without inductor absorption
V_VO_bias VO_bias 0 0.9
R_filt VO VO_filt 1G
C_filt VO_filt 0 1
V_ref VREF 0 0.835
E_err N_cm VREF VO_filt VO_bias 1000

V_N4 N4_bias N_cm dc 0.1
V_N1 N_cm N1_bias dc 0.1

.nodeset V(VO)=0.9 V(N_cm)=0.835 V(VO_filt)=0.9

* AC Input
Vin in 0 dc 0 ac 1
E_n N1 N1_bias in 0 1
E_p N4 N4_bias in 0 1

* Load capacitor
C_load VO 0 1p

* Replica biasing and load
V_VOS_bias VOS_bias 0 0.9
L_bias_s VOS_bias VOS 1e6
C_load_s VOS 0 1p

* AC Current source for Rout measurement (inactive initially)
Iout 0 VO dc 0 ac 0

.control
* 1. DC Operating Point
op
let quiescent_power = -i(VVDD)*1.8
print quiescent_power

* 2. AC Analysis for Gain and Bandwidth
ac dec 100 10 10G
let gain_db = vdb(VO)
meas ac dc_gain find gain_db at=100
let gain_3db = dc_gain - 3
meas ac bandwidth when gain_db=gain_3db fall=1

let gain_vos_db = vdb(VOS)
meas ac dc_gain_vos find gain_vos_db at=100

* 3. AC Analysis for Output Impedance
alter Vin ac=0
alter Iout ac=1
ac dec 10 10 10G
let vout_mag = mag(v(VO))
meas ac rout find vout_mag at=100

print dc_gain bandwidth rout quiescent_power dc_gain_vos
quit
.endc
.end