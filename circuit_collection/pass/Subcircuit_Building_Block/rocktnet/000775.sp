* Analog Switch Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

VVDD VDD 0 1.8

* Inputs
VN2 N2 0 0.9
VL2 LABEL_NET_2 0 0.9
VN1 N1 0 0.9

* Controls (PWL for TRAN, altered for DC)
VP1 P1 0 dc 0 pwl(0 0 10n 0 10.1n 1.8 20n 1.8 20.1n 0)
VP1B P1_BAR 0 dc 1.8 pwl(0 1.8 10n 1.8 10.1n 0 20n 0 20.1n 1.8)

VP2 P2 0 dc 0 pwl(0 0 30n 0 30.1n 1.8 40n 1.8 40.1n 0)
VP2B P2_BAR 0 dc 1.8 pwl(0 1.8 30n 1.8 30.1n 0 40n 0 40.1n 1.8)

VP3 P3 0 dc 0 pwl(0 0 50n 0 50.1n 1.8 60n 1.8 60.1n 0)
VP3B P3_BAR 0 dc 0 pwl(0 0 70n 0 70.1n 1.8 80n 1.8 80.1n 0)

* Load
I_meas N0 0 0
Cload N0 0 1p
.ic v(N0)=0.9

* DUT
XM1 N1 P3_BAR N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 P1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 P2 LABEL_NET_2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 P1_BAR N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 P2_BAR N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 P3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

.control
* 1. Transient for charge injection
tran 0.1n 90n
meas tran v_hold1 find v(N0) at=25n
let q_inj1 = (v_hold1 - 0.9) * 1p
meas tran v_hold2 find v(N0) at=45n
let q_inj2 = (v_hold2 - 0.9) * 1p
meas tran v_hold3 find v(N0) at=65n
let q_inj3 = (v_hold3 - 0.9) * 1p
meas tran v_hold4 find v(N0) at=85n
let q_inj4 = (v_hold4 - 0.9) * 1p
print q_inj1 q_inj2 q_inj3 q_inj4

* 2. DC sweeps for Ron
alter I_meas = 10u

* Path 1 (CMOS TG)
alter VP1 = 1.8
alter VP1B = 0
alter VP2 = 0
alter VP2B = 1.8
alter VP3 = 0
alter VP3B = 0
dc VN2 0 1.8 0.01
meas dc v_n0_1 find v(N0) at=0.9
let ron1_mid = (0.9 - v_n0_1) / 10u
print ron1_mid

* Path 2 (NMOS with Dummy)
alter VP1 = 0
alter VP1B = 1.8
alter VP2 = 1.8
alter VP2B = 0
dc VL2 0 1.8 0.01
meas dc v_n0_2 find v(N0) at=0.9
let ron2_mid = (0.9 - v_n0_2) / 10u
print ron2_mid

* Path 3a (NMOS XM6)
alter VP2 = 0
alter VP2B = 1.8
alter VP3 = 1.8
alter VP3B = 0
dc VN1 0 1.8 0.01
meas dc v_n0_3a find v(N0) at=0.9
let ron3a_mid = (0.9 - v_n0_3a) / 10u
print ron3a_mid

* Path 3b (NMOS XM1)
alter VP3 = 0
alter VP3B = 1.8
dc VN1 0 1.8 0.01
meas dc v_n0_3b find v(N0) at=0.9
let ron3b_mid = (0.9 - v_n0_3b) / 10u
print ron3b_mid

quit
.endc
.end