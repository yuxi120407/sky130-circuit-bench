* 3-input NAND gate characterization testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

XM1 vout vin vdd vdd sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM2 vout vin vdd vdd sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM3 vout vin vdd vdd sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM4 vout vin n1 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM5 n1 vin n2 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM6 n2 vin 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15

VDD vdd 0 1.8
Vin vin 0 DC 0 PULSE(0 1.8 1n 0.05n 0.05n 2n 4n)
Cload vout 0 10f

.control
dc Vin 0 1.8 0.01
meas dc switching_point_voltage when v(vout)=v(vin)

tran 10p 10n
meas tran propagation_delay_hl trig v(vin) val=0.9 rise=1 targ v(vout) val=0.9 fall=1
meas tran propagation_delay_lh trig v(vin) val=0.9 fall=1 targ v(vout) val=0.9 rise=1

print switching_point_voltage
print propagation_delay_hl
print propagation_delay_lh
.endc
.end