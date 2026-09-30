* Testbench for CS/Push-Pull Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Circuit Netlist
XM1 vout nmos_g 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM2 vout pmos_g vdd vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.15
R1 vout nmos_g 100MEG
R2 vout pmos_g 100MEG
C1 vin nmos_g 10u
C2 vin pmos_g 10u

* Stimuli
VDD vdd 0 1.8
Vin vin 0 dc 0 ac 1
Iout 0 vout dc 0 ac 0

.control
op

* First run: Measure gain, input capacitance, dominant pole, and zero frequency
ac dec 20 1 1000G

let vout_mag = mag(v(vout))
meas ac low_frequency_gain find vout_mag at=10

let omega = 2*pi*frequency
let cin_vec = imag(-i(Vin)) / omega
meas ac input_capacitance find cin_vec at=1MEG

meas ac max_gain max vout_mag
let gain_3db = max_gain / 1.41421356
meas ac dominant_pole when vout_mag=gain_3db fall=1

let phase_deg = 180/pi * cph(v(vout))
meas ac dc_phase find phase_deg at=10
let phase_target = dc_phase - 135
meas ac zero_frequency when phase_deg=phase_target fall=1

* Second run: Measure output capacitance
alter @Vin[acmag]=0
alter @Iout[acmag]=1
ac dec 20 1 1000G

let omega2 = 2*pi*frequency
let cout_vec = imag(1/v(vout)) / omega2
meas ac output_capacitance find cout_vec at=1MEG

print low_frequency_gain input_capacitance dominant_pole zero_frequency output_capacitance
.endc
.end