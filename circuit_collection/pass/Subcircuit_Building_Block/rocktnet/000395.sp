* PMOS Transistor Characterization Testbench
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5

XM2 V_A I_A VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM1 V_D QC_COLL VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}

* Supply and Bias Sources
VVDD VDD 0 1.8
V_IA I_A 0 0.9
V_VA V_A 0 0.9
V_QC QC_COLL 0 0.9
V_VD V_D 0 0.9

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.control
* 1. DC Operating Point
op
let id_m2 = i(V_VA)
let id_m1 = i(V_VD)
print id_m2 id_m1

* 2. DC Sweep for Threshold Voltage
dc V_IA 1.8 0 -0.01
* Measure gate voltage when drain current reaches 1uA (threshold definition)
meas dc vth_m2 find v(I_A) when i(V_VA)=1u

quit
.endc
.end