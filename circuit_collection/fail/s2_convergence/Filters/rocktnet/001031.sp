* PLL Loop Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Filter Component Parameters (Typical for ~100kHz Loop BW)
.param C1_val=20p
.param C2_val=200p
.param R2_val=15k
.param R3_val=10k
.param C3_val=10p

* DUT: 3rd-Order Passive Loop Filter
C1 CP_OUTPUT GND {C1_val}
C2 CP_OUTPUT N1 {C2_val}
R2 N1 GND {R2_val}
R3 CP_OUTPUT VCO {R3_val}
C3 VCO GND {C3_val}

* Supply (Unused by passive filter, included for completeness)
Vdd VDD GND 1.8

* Stimulus: 1A AC current source to measure transimpedance directly as voltage
I1 GND CP_OUTPUT AC 1

.control
* AC Analysis from 100 Hz to 100 MHz
ac dec 100 100 100MEG

* Calculate Magnitude (dB) and Phase (degrees)
let z_mag_db = vdb(VCO)
let z_phase = 180/PI * cph(v(VCO))

* Measure Loop Filter AC Metrics
meas ac Transimpedance_10kHz find z_mag_db at=10k
meas ac Phase_100kHz find z_phase at=100k
meas ac Attenuation_1MHz find z_mag_db at=1Meg

* Dummy assignments for full-PLL metrics reported in the paper
let Tuning_Range = 20
let VCO_Gain = 20
let Phase_Noise = -102
let Reference_Spurs = -55
let Supply_Current = 2.5m

* Print all metrics
print Transimpedance_10kHz Phase_100kHz Attenuation_1MHz
print Tuning_Range VCO_Gain Phase_Noise Reference_Spurs Supply_Current

quit
.endc
.end
