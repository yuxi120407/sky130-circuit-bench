* High-Performance Very Low-Voltage Current Sense Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5

.param W_xm11=5.0 L_xm11=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm12=5.0 L_xm12=0.5

VVDD VDD 0 1.8
Iref VDD N1 DC 10u
* Voltage source to control the cell current (1V = 1uA)
Vcell_ctrl ctrl 0 DC 5 AC 1 PULSE(0 20 10n 1n 1n 40n 80n)
Gcell BL 0 ctrl 0 1u
Cbl BL 0 1p

XM11 N2 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM13 BL N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM10 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM1 BL BL GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM14 N1 BL GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM12 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

.control
* DC Analysis
dc Vcell_ctrl 0 20 0.1
meas dc bl_high find v(BL) at=0
meas dc bl_low find v(BL) at=20
meas dc n2_high max v(N2)
meas dc n2_low min v(N2)

* AC Analysis
ac dec 10 1k 1G
meas ac z_bl_db find vdb(BL) at=1k
meas ac z_n2_db find vdb(N2) at=1k

* Transient Analysis
tran 0.1n 100n
meas tran t_read_fall trig v(ctrl) val=10 rise=1 targ v(BL) val=0.24 fall=1
meas tran t_read_rise trig v(ctrl) val=10 fall=1 targ v(BL) val=0.24 rise=1
meas tran pwr_avg avg -i(VVDD)*1.8

quit
.endc
.end
