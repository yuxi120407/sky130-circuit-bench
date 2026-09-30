* NMOS Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5

XM1 N1 IN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

VVDD VDD 0 1.8
RL VDD N1_R 1k
VID N1_R N1_L 0
LL N1_L N1 1u
VIN IN 0 DC 0 PULSE(0 1.8 1n 0.1n 0.1n 10n 20n)

.control
* 1. OP for leakage current
op
let Ileak = i(VID)
print Ileak

* 2. DC Sweep for Vth and Ron
dc VIN 0 1.8 0.01
let ron_vec = v(N1) / i(VID)
meas dc Ron find ron_vec at=1.8
meas dc Vth when i(VID)=1uA
print Ron
print Vth

* 3. Transient for switching times, overshoot, efficiency, power
tran 0.01n 40n
meas tran t_turn_on trig v(IN) val=0.9 rise=1 targ v(N1) val=1.3 fall=1
print t_turn_on

* Inductive_Overshoot
meas tran max_v_n1 max v(N1)
let Inductive_Overshoot = max_v_n1 - 1.8
print Inductive_Overshoot

* Power Dissipation and Efficiency
let p_in_inst = -1.8 * i(VVDD)
let p_load_inst = (v(VDD) - v(N1)) * i(VID)
meas tran E_in integ p_in_inst from=0 to=40n
meas tran E_load integ p_load_inst from=0 to=40n
let Power_Dissipation = E_in / 40n
let Efficiency = (E_load / E_in) * 100
print Power_Dissipation
print Efficiency

quit
.endc

.end