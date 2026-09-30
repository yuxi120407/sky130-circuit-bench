* Quadrature Ring VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm5=5.0 L_xm5=0.5

.param I_latch=1m
.param I_inject=1m
.param R_load=500
.param C_load=100f

VVDD VDD 0 1.8 ac 1

* Loads
R1 0_DEG VDD {R_load}
R2 180_DEG VDD {R_load}
R3 90_DEG VDD {R_load}
R4 270_DEG VDD {R_load}

* Parasitic/Tuning Capacitors
C1 0_DEG 0 {C_load}
C2 180_DEG 0 {C_load}
C3 90_DEG 0 {C_load}
C4 270_DEG 0 {C_load}

* Tail Current Sources for Tuning
I_A A 0 {I_latch}
I_B B 0 {I_latch}
I_C C 0 {I_inject}
I_D D 0 {I_inject}

* DUT
XM1 0_DEG 180_DEG A GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 180_DEG 0_DEG A GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 270_DEG 90_DEG B GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM7 270_DEG 180_DEG D GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM4 90_DEG 270_DEG B GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM6 180_DEG 90_DEG C GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM8 90_DEG 0_DEG D GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM5 0_DEG 270_DEG C GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

* Initial conditions to kickstart oscillation
.ic v(0_DEG)=1.8 v(180_DEG)=0 v(90_DEG)=0.9 v(270_DEG)=0.9

.control
tran 10p 50n

* Measure frequency
meas tran t1 trig v(0_DEG) val=1.3 rise=10 targ v(0_DEG) val=1.3 rise=11
let oscillation_frequency = 1 / t1
print oscillation_frequency

* Measure amplitude
meas tran vmax max v(0_DEG) from=20n to=50n
meas tran vmin min v(0_DEG) from=20n to=50n
let output_amplitude = vmax - vmin
print output_amplitude

* Measure phase difference (should be 90 degrees)
meas tran t_90 trig v(0_DEG) val=1.3 rise=10 targ v(90_DEG) val=1.3 rise=10
let phase_diff = (abs(t_90) / t1) * 360
let phase_error = phase_diff - 90
print phase_error

* Measure power consumption
meas tran pwr avg i(VVDD) from=20n to=50n
let power_consumption = -pwr * 1.8
print power_consumption

* Phase noise (small-signal noise approximation)
noise v(0_DEG, 180_DEG) VVDD dec 10 100k 10Meg
setplot noise1
meas noise onoise_600k find onoise_spectrum at=600k
let phase_noise = 20 * log10(onoise_600k)
print phase_noise

quit
.endc
.end