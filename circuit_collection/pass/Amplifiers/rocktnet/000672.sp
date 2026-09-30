* Interpolating Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 VOUT_N VIN_0_N N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT_P VIN_0_P N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT_P VIN_1_P N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT_N VIN_1_N N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Power supply
VVDD VDD 0 1.8

* Input signals (AC for gain/BW, SIN for transient)
VVIN_0_P VIN_0_P 0 DC 0.9 AC 0.5 SIN(0.9 0.1 100MEG 0 0)
VVIN_0_N VIN_0_N 0 DC 0.9 AC -0.5 SIN(0.9 -0.1 100MEG 0 0)
VVIN_1_P VIN_1_P 0 DC 0.9 AC 0 SIN(0.9 0 100MEG 0 0)
VVIN_1_N VIN_1_N 0 DC 0.9 AC 0 SIN(0.9 0 100MEG 0 0)

* Loads and Biasing
RL1 VDD VOUT_P 10k
RL2 VDD VOUT_N 10k
I1 N1 0 100u
I2 N2 0 100u
CL1 VOUT_P 0 50f
CL2 VOUT_N 0 50f

* Differential output voltage for easy measurement
E_diff VOUT_DIFF 0 VOUT_N VOUT_P 1.0

.control
* 1. DC Operating Point & Power
op
let total_power = -i(VVDD) * 1.8
print total_power

* 2. AC Analysis for Gain and Bandwidth
ac dec 100 1Meg 10G
let gain_db = vdb(VOUT_DIFF)
meas ac dc_gain find gain_db at=1Meg
let gain_3db = dc_gain - 3
meas ac bw_3db when gain_db=gain_3db fall=1

* 3. Transient Analysis
tran 10p 20n
meas tran vout_diff_max max v(VOUT_DIFF)
meas tran vout_diff_min min v(VOUT_DIFF)
quit
.endc
.end
