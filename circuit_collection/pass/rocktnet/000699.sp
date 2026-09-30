* Analog Summing Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm5=5.0 L_xm5=0.5

XM2 VOUT IN1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT IN2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT IN3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 VOUT IN4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM5 VDD VDD VOUT GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

VVDD VDD 0 1.8
VIN1 IN1 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)
VIN2 IN2 0 DC 0.9 AC 0
VIN3 IN3 0 DC 0.9 AC 0
VIN4 IN4 0 DC 0.9 AC 0

Cload VOUT 0 50f

.control
* Operating Point
op
print v(VOUT)
let pwr = -i(VVDD) * 1.8
print pwr

* AC Analysis
ac dec 10 1k 100G
let gain_db = vdb(VOUT)
meas ac midband_gain find gain_db at=100k
meas ac gain_10G find gain_db at=10G

* Transient Analysis for THD
tran 10n 5u
meas tran vout_pk2pk pp v(VOUT)
fourier 1MEG v(VOUT)

quit
.endc
.end