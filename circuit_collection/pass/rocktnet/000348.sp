* SSCG Loop Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param C1_val=1p
.param C2_val=1p
.param R2_val=10k

.param R1_val=10k R2_val=2k C1_val=100p C2_val=10p

* DUT
R2 Vctrl I2 {R2_val}
R1 I2 N1 {R1_val}
C1 N1 GND {C1_val}
C2 Vctrl GND {C2_val}

* Stimulus
Iin 0 I2 DC 0 AC 1 PULSE(0 10u 1n 1n 1n 10u 20u)

.control
* AC Analysis
ac dec 100 100 100Meg
let z_db = vdb(Vctrl)
let phase = 180/PI * cph(v(Vctrl))

meas ac z_1kHz find z_db at=1k
meas ac max_phase max phase
meas ac f_max_phase find frequency when phase=max_phase

* Transient Analysis
tran 10n 20u
meas tran v_at_10us find v(Vctrl) at=10u
quit
.endc
.end