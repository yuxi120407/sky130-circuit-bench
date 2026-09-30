* RF Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 TX ON GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 TX OFF AN GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* 50-ohm RF Source at TX (2V AC with 50 ohm divider gives 0dB reference at matched load)
Vac TX_src GND dc 0 ac 2
Rsrc TX_src TX 50

* 50-ohm Load at AN
Rload AN GND 50

* Control Voltages
Von ON GND dc 0
Voff OFF GND dc 1.8

.control
* State 1: Pass Mode (TX to AN)
* XM2 (series) is ON, XM1 (shunt) is OFF
alter Von 0
alter Voff 1.8
op
ac dec 50 100Meg 10Gig
let il_db = vdb(AN)
meas ac IL_2_4G find il_db at=2.4G
meas ac IL_5G find il_db at=5G

* State 2: Isolation Mode
* XM2 (series) is OFF, XM1 (shunt) is ON
alter Von 1.8
alter Voff 0
op
ac dec 50 100Meg 10Gig
let iso_db = vdb(AN)
meas ac ISO_2_4G find iso_db at=2.4G
meas ac ISO_5G find iso_db at=5G

print IL_2_4G IL_5G ISO_2_4G ISO_5G
quit
.endc
.end