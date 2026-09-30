* Compensated Bias Current Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm_n1=0.5
.param L_xm_n2=0.5
.param L_xm_n3=0.5
.param L_xm_p1=0.5

.param W_xm_n3=5.0 L_xm_n3=0.5
.param W_xm_n2=5.0 L_xm_n2=0.5
.param W_xm_n1=5.0 L_xm_n1=0.5
.param W_xm_p1=5.0 L_xm_p1=0.5

XM_N3 V_B V_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm_n3} w={W_xm_n3}
XM_N2 V_B V_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm_n2} w={W_xm_n2}
XM_N1 V_2 V_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm_n1} w={W_xm_n1}
XM_P1 V_B V_B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm_p1} w={W_xm_p1}

* Power Supply
VVDD VDD 0 1.8

* Input Stimulus
V3 V_3 0 0.6
V2_drv V_2_drv 0 0.6
R2 V_2_drv V_2 10k
V1 V_1 0 pwl(0 0 1u 0 1.01u 1.8 2u 1.8)

.control
tran 10n 2u

* Measure at t=0.5u (Compensation Active, V1=0V)
meas tran I_vdd_active find i(VVDD) at=0.5u
meas tran V_B_active find v(V_B) at=0.5u
meas tran V_2_active find v(V_2) at=0.5u

* Measure at t=1.5u (Compensation Disabled, V1=1.8V)
meas tran I_vdd_base find i(VVDD) at=1.5u
meas tran V_B_base find v(V_B) at=1.5u
meas tran V_2_disabled find v(V_2) at=1.5u

quit
.endc
.end