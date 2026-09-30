* LC Tank with Substrate Parasitics Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_val=0.0012 Cp_val=2.5p Cox_val=100f Rsub_val=50

* DUT
Cp N1 N2 Cp_val
L N1 N2 {L_val}
Cox_L N1 Vi_L Cox_val
Cox_R N2 Vi_R Cox_val
Rsub_L Vi_L GND Rsub_val
Rsub_R Vi_R GND Rsub_val

* DC bias to prevent floating nodes
Rdc1 N1 GND 1G
Rdc2 N2 GND 1G

* AC Current Source for impedance measurement
I1 N2 N1 AC 1

.control
ac lin 10000 1G 5G
let vdiff = v(N1) - v(N2)
let zmag = mag(vdiff)
let phase = 180/PI * cph(vdiff)

meas ac zmax max zmag
meas ac fres when phase=0 fall=1
meas ac f_low when phase=45 fall=1
meas ac f_high when phase=-45 fall=1

let q_factor = fres / (f_high - f_low)
print fres zmax q_factor
quit
.endc
.end
