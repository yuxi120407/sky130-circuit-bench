* Pelliconi Charge Pump Stage Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm0=5.0 L_xm0=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

.param C_pump=5p
.param C_load=10p
.param R_load=50000
.param f_clk=100Meg
.param t_per={1/f_clk}
.param t_pw={t_per/2 - 0.1n}

* DUT
XM0 N_TOP N_BOT VLOW VLOW sky130_fd_pr__nfet_01v8 l={L_xm0} w={W_xm0}
XM1 N_BOT N_TOP VLOW VLOW sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_TOP N_BOT VHIGH VHIGH sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_BOT N_TOP VHIGH VHIGH sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}

* Voltage Sources
V_VLOW VLOW 0 1.8
V_CLK CLK 0 PULSE(0 1.8 0 0.1n 0.1n t_pw t_per)
V_CLKB CLKB 0 PULSE(1.8 0 0 0.1n 0.1n t_pw t_per)

* Pumping Capacitors
C1 CLK N_TOP {C_pump}
C2 CLKB N_BOT {C_pump}

* Load Network
C3 VHIGH 0 {C_load}
R1 VHIGH 0 {R_load}

* Initial Conditions to speed up steady-state convergence
.ic v(VHIGH)=1.8 v(N_TOP)=1.8 v(N_BOT)=1.8

.control
tran 1n 3u

* Measure Output Voltage and Ripple
meas tran v_out_avg avg v(VHIGH) from=2.5u to=3.0u
meas tran v_out_max max v(VHIGH) from=2.5u to=3.0u
meas tran v_out_min min v(VHIGH) from=2.5u to=3.0u
let v_ripple = v_out_max - v_out_min
print v_out_avg
print v_ripple

* Measure Power and Efficiency
let p_in = -i(V_VLOW)*v(VLOW) - i(V_CLK)*v(CLK) - i(V_CLKB)*v(CLKB)
let p_out = v(VHIGH)*v(VHIGH)/50000
meas tran p_in_avg avg p_in from=2.5u to=3.0u
meas tran p_out_avg avg p_out from=2.5u to=3.0u
let efficiency = p_out_avg / p_in_avg * 100
print efficiency

quit
.endc
.end