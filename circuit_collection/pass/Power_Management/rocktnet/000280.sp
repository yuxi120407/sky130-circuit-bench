* SIDO Boost Converter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param VDD=1.8
.param RLOAD_A=50
.param RLOAD_B=50

* DUT
Vg N3 GND {VDD}
Rob Vob GND {RLOAD_B}
Roa Voa GND {RLOAD_A}

* Switches replaced with SKY130 NMOS devices
X1 N2 ctrl_S1 GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15 m=200
Xa N2 ctrl_Sa Voa GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15 m=200
Xb N2 ctrl_Sb Vob GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15 m=200

Cob Vob GND 10u
L N2 N3 1u
Coa Voa GND 10u

* Dead-time catch diode clamped to 5V to prevent spikes and eliminate cross-conduction
VCLAMP V_CLAMP 0 5V
Xc N2 N2 V_CLAMP GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15 m=200

* Control signals (1MHz, Time-multiplexed)
* Sub-period A: 0 to 0.5us. S1 ON: 0-0.2us, Sa ON: 0.2-0.5us
* Sub-period B: 0.5 to 1.0us. S1 ON: 0.5-0.75us, Sb ON: 0.75-1.0us
Vp1 p1 0 PULSE(0 1.8 0 1n 1n 0.198u 1.0u)
Vp2 p2 0 PULSE(0 1.8 0.5u 1n 1n 0.248u 1.0u)
B_S1 ctrl_S1 0 V=V(p1) + V(p2)

Vctrl_Sa ctrl_Sa 0 PULSE(0 5 0.200u 1n 1n 0.298u 1.0u)
Vctrl_Sb ctrl_Sb 0 PULSE(0 5 0.750u 1n 1n 0.248u 1.0u)

.control
tran 10n 4m
meas tran Voa_avg avg v(Voa) from=3.8m to=4.0m
meas tran Vob_avg avg v(Vob) from=3.8m to=4.0m

let Pin = -i(Vg) * 1.8
let Pout = (v(Voa)*v(Voa)/50) + (v(Vob)*v(Vob)/50)
meas tran Pin_avg avg Pin from=3.8m to=4.0m
meas tran Total_Power avg Pout from=3.8m to=4.0m

let Efficiency = (Total_Power / Pin_avg) * 100
print Voa_avg Vob_avg Efficiency Total_Power
quit
.endc
.end