* SER-Tolerant Latch Baseline (6T Latch)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 X0 X1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 X1 X0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 X0 X1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 X1 X0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 X0 CK D GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 D_PRIME CK X1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

VVDD VDD 0 1.8
VGND GND 0 0

* Stimuli
VD D 0 PWL(0 1.8 4.9n 1.8 5n 0 10n 0)
VD_PRIME D_PRIME 0 PWL(0 0 4.9n 0 5n 1.8 10n 1.8)
VCK CK 0 PWL(0 0 0.9n 0 1n 1.8 3n 1.8 3.1n 0 5.9n 0 6n 1.8 8n 1.8 8.1n 0 10n 0)

* Initialize nodes to avoid metastability
.ic v(X0)=0 v(X1)=1.8

.control
tran 10p 10n

* Measure write 1 delay (CK rise to X0 rise)
meas tran delay_write_1 trig v(CK) val=0.9 rise=1 targ v(X0) val=0.9 rise=1

* Measure write 0 delay (CK rise to X0 fall)
meas tran delay_write_0 trig v(CK) val=0.9 rise=2 targ v(X0) val=0.9 fall=1

* Measure average power
let power = -i(VVDD)*1.8
meas tran avg_power avg power from=0 to=10n

print delay_write_1 delay_write_0 avg_power
quit
.endc
.end
