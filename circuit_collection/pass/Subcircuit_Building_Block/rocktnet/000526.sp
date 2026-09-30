* NMOS Array Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM1 N1 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUTY N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUTX N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Power Supply
VVDD VDD 0 1.8

* Input Signals (DC bias = 0.9V, AC = 1V for Bode plot, Tran = 10mV amplitude)
VINX N6 0 DC 0.9 AC 1 SIN(0.9 0.01 1MEG 0 0)
VINY N7 0 DC 0.9 AC 1 SIN(0.9 0.01 1MEG 0 0)
VIN8 N8 0 DC 0.9
VIN2 N2 0 DC 0.9

* Load Resistors to make the circuit functional as amplifiers
R1 OUTX VDD 2k
R2 OUTY VDD 2k
R3 N1 VDD 2k
R4 N0 VDD 2k

.control
* 1. DC Operating Point & Power
op
let total_power = -i(VVDD) * 1.8
print total_power
print v(OUTX) v(OUTY)

* 2. AC Analysis for Gain and Bandwidth
ac dec 20 1k 100G
let gain_db = vdb(OUTX)
meas ac midband_gain find gain_db at=10k
meas ac bw_3db when gain_db=(midband_gain-3) fall=1

* 3. Transient Analysis
tran 1n 5u
meas tran vout_max max v(OUTX)
meas tran vout_min min v(OUTX)
let vout_pp = vout_max - vout_min
print vout_pp

quit
.endc
.end