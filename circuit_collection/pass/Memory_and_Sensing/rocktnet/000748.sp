* Sense Amplifier Small-Signal Model Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R12=100Meg
.param Icell=500u
.param Iref=250u
.param gds=10u
.param R34=100Meg
.param Rd=10k
.param Cd=20f
.param Cs=2p
.param IM3=0
.param IM2=0
.param IM1=0
.param IM4=0

Vdd VDD GND DC 1.8

* DUT
R12 V1 V2 R12
Icell GND V3 {Icell}
Iref GND V4 {Iref}
R2 V3 GND {1/gds}
R34 V3 V4 R34
R4 V1 GND Rd
C1 V2 GND Cd
R5 V4 GND {1/gds}
R6 V2 GND Rd
C2 V3 GND Cs
C3 V1 GND Cd
C4 V4 GND Cs
IM3 V1 V3 {IM3}
IM2 V2 GND {IM2}
IM1 V1 GND {IM1}
IM4 V2 V4 {IM4}

.control
tran 0.01n 10n uic
meas tran t_sense WHEN v(V3)=0.5 CROSS=1
meas tran v_bitline_max MAX v(V3)
print t_sense v_bitline_max
quit
.endc
.end