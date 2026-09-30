* Continuous-Time Amplifier / Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

VVDD VDD 0 1.8
VVSS VSS 0 0

VVINP VINP 0 DC 0.9 AC 0.5 PULSE(0.8 1.0 1n 100p 100p 5n 10n)
VVINN VINN 0 DC 0.9 AC -0.5 PULSE(1.0 0.8 1n 100p 100p 5n 10n)

Ediff_in diff_in 0 VINP VINN 1.0
Ediff_out diff_out 0 V1OUTP V1OUTN 1.0

IREF VDD VBIAS 50u
XM_bias VBIAS VBIAS VSS VSS sky130_fd_pr__nfet_01v8 l=0.5 w=5.0
XM_tail TAIL VBIAS VSS VSS sky130_fd_pr__nfet_01v8 l=0.5 w=10.0

XM1 V1OUTN VINP TAIL VSS sky130_fd_pr__nfet_01v8 l=0.5 w=10.0
XM2 V1OUTP VINN TAIL VSS sky130_fd_pr__nfet_01v8 l=0.5 w=10.0

XM3 V1OUTN V1OUTN VDD VDD sky130_fd_pr__pfet_01v8 l=0.5 w=5.0
XM4 V1OUTP V1OUTP VDD VDD sky130_fd_pr__pfet_01v8 l=0.5 w=5.0

XM5 V1OUTN V1OUTP VDD VDD sky130_fd_pr__pfet_01v8 l=0.5 w=4.0
XM6 V1OUTP V1OUTN VDD VDD sky130_fd_pr__pfet_01v8 l=0.5 w=4.0

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 100 1k 10G
let gain_mag = mag(v(diff_out))
let gain_db = 20 * log10(gain_mag)
meas ac dc_gain find gain_db at=1k
meas ac max_gain max gain_mag
let target_val = max_gain / 1.41421356
meas ac bw_3db when gain_mag=$&target_val fall=1
print dc_gain bw_3db

tran 10p 10n
meas tran t_delay trig v(diff_in) val=0 cross=1 targ v(diff_out) val=0 cross=1
print t_delay
quit
.endc
.end