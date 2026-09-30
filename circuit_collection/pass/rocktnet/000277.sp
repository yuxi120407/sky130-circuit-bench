* Ultralow-Power OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0

XM1 N0 VI1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 VO N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VO VI2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 VB N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 VDD VG1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VDD VG2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

VVDD VDD 0 1.8
VVB VB 0 0.5
VVG1 VG1 0 1.8
VVG2 VG2 0 1.8

* Input source: DC bias, AC signal, and Transient step
VIN VI1 0 dc 0.3 ac 1 pulse(0.2 0.4 10u 10n 10n 25m 50m)

* Feedback network: Acts as open-loop for AC, closed-loop for DC
E_fb VI2_buf 0 VO 0 1
R_fb VI2_buf VI2 1G
C_fb VI2 0 1G
CL VO 0 1p

.options gmin=1e-15 abstol=1e-15

.control
* 1. Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* 2. AC Analysis (Open Loop)
ac dec 10 0.1 10Meg
let gain_db = db(v(VO))
let phase = 180/PI * cph(v(VO))
let pm_vec = 180 + phase
meas ac dc_gain MAX gain_db
meas ac ugf when gain_db=0 fall=1
meas ac phase_margin find pm_vec when gain_db=0 fall=1
print dc_gain ugf phase_margin

* Reconfigure feedback network for Transient Analysis (Unity Gain Buffer)
alter R_fb 1m
alter C_fb 1f

* 3. Transient Analysis (Step Response)
tran 10u 50m
meas tran t1 when v(VO)=0.25 rise=1
meas tran t2 when v(VO)=0.35 rise=1
let slew_rate = 0.1 / (t2 - t1) / 1e6
print slew_rate

quit
.endc
.end