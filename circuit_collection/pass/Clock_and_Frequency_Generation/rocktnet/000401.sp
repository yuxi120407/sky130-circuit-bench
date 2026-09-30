* LC-VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0

XM1 QX Q VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 Q QX VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 Q QX VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 QX Q VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VVSS VSS 0 0

* LC Tank (Added to complete the VCO for testing)
L1 Q QX 4.5n
C1 Q QX 3.3p
R1 Q QX 5000

* Startup kick to initiate oscillation
I_kick Q QX pulse(0 2m 1n 10p 10p 1n 200n)

.control
tran 1p 200n

let v_diff = v(Q) - v(QX)

* Measure frequency
meas tran t_start WHEN v_diff=0 CROSS=2 td=100n
meas tran t_end WHEN v_diff=0 CROSS=22 td=100n
let f_osc = 10 / (t_end - t_start)
print f_osc

* Measure peak-to-peak voltage swing (differential)
meas tran v_max max v_diff from=100n to=200n
meas tran v_min min v_diff from=100n to=200n
let v_swing = v_max - v_min
print v_swing

* Measure DC power consumption
meas tran i_vdd avg i(VVDD) from=100n to=200n
let power_consumption = -i_vdd * 1.8
print power_consumption

* Calculate phase noise using Leeson's equation
let P_sig = (v_swing * v_swing) / 40000
let f_offset = 1e6
let Q_tank = 135.4
let kT = 4.14e-21
let F_noise = 2
let ratio = f_osc / (2 * Q_tank * f_offset)
let phase_noise = 10 * log10( (2 * F_noise * kT / P_sig) * (1 + ratio * ratio) )
print phase_noise

quit
.endc
.end