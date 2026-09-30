* Testbench for Biomorphic Digital Image Sensor Latch
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
XM1 N2 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N0 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Supplies
VVDD VDD 0 1.8
VLABEL LABEL_NET_0 0 0.9

* Input Drive for DC Sweep (Disconnected during Tran)
VN0_src N0_src 0 1.8
.model sw_ideal sw vt=0.5 vh=0.1 ron=1 roff=1e12
S1 N0_src N0 sw_ctrl 0 sw_ideal
Vctrl sw_ctrl 0 dc 1 pwl(0 1 1n 1 2n 0)

* Transient Integration Components (Photodiode emulation)
CN0 N0 0 50f
IN0 N0 0 dc 100n
CN2 N2 0 10f

.control
* 1. DC Analysis
dc VN0_src 0.9 0 -0.001
let gain_mag = abs(deriv(v(N2)))
let gain_db = 20 * log10(gain_mag + 1e-15)
meas dc max_gain_db max gain_db
meas dc trip_voltage find v(N0) when v(N2)=0.45

* 2. Transient Analysis
tran 1n 2u
meas tran t_delay trig v(N2) val=0.09 rise=1 targ v(N2) val=0.81 rise=1

let pwr_label = -i(VLABEL) * 0.9
meas tran energy_spike integ pwr_label

meas tran pwr_stat find pwr_label at=0.5n

print max_gain_db trip_voltage t_delay energy_spike pwr_stat
quit
.endc
.end