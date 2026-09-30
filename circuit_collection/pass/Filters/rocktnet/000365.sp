* PLL Loop Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param C1_val=1p
.param C2_val=1p
.param C3_val=1p
.param R3_val=10k

* Component values for ~250kHz loop bandwidth
.param R1_val=6.3k C1_val=1n C2_val=25p R3_val=6.3k C3_val=25p

* DUT: Loop Filter
R1 IIN N1 {R1_val}
C1 N1 GND {C1_val}
C2 IIN GND {C2_val}
R3 IIN VOUT {R3_val}
C3 VOUT GND {C3_val}

* DC path to ground to prevent floating nodes during OP/AC
R_dc IIN 0 1T

* Input source: AC current for transimpedance, Pulse for transient
* Simulating a 100uA charge pump pulse
I_in 0 IIN DC 0 AC 1 PULSE(-25u 75u 1u 1n 1n 0.5u 2u)

.control
* AC Analysis
ac dec 100 1k 10Meg
let z_mag_db = db(v(VOUT))
let z_phase = 180/3.14159265359 * ph(v(VOUT))

meas ac Transimpedance_10kHz find z_mag_db at=10k
meas ac Transimpedance_250kHz find z_mag_db at=250k
meas ac Phase_250kHz find z_phase at=250k
print Transimpedance_10kHz Transimpedance_250kHz Phase_250kHz

* Transient Analysis
tran 10n 100u uic
meas tran vout_max max v(VOUT) from=98u to=100u
meas tran vout_min min v(VOUT) from=98u to=100u
let Transient_Ripple = vout_max - vout_min
print Transient_Ripple

quit
.endc
.end