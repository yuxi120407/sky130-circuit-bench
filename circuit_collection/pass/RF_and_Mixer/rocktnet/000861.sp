* LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_bias=0.5
.param L_xm1=0.5

.param W_xm1=50.0 L_xm1=0.15
.param W_bias=5.0 L_bias=0.15

* DUT (npn converted to sky130 NMOS for compatibility)
XM3 N5 N3 N6 GND sky130_fd_pr__nfet_01v8 W={W_bias} L={L_bias}
R1 N1 N4 10k
XM4 N3 N0 GND GND sky130_fd_pr__nfet_01v8 W={W_bias} L={L_bias}
XM1 N2 N4 GND GND sky130_fd_pr__nfet_01v8 W={W_xm1} L={L_xm1}
R3 VDD N5 1k
C2 N1 GND 10p
C1 N4 IN 1p
R5 VDD N3 1k
R2 N0 N1 10k
C4_OUT N2 OUT 1p
XM2 VDD N5 N1 GND sky130_fd_pr__nfet_01v8 W={W_bias} L={L_bias}
C4 N3 GND 10p
C3 N5 GND 10p
R4 N6 GND 200
L1 VDD N2 2n

* Tuning capacitor to set resonance near 5.2 GHz
C_tune N2 GND 0.4p

* Sources
VVDD VDD 0 1.8
VIN IN 0 DC 0 AC 1 SIN(0 0.01 5.2G 0 0)

* Load
RL OUT 0 50

.control
* DC Analysis
op
let power = -i(VVDD) * 1.8
print power

* AC Analysis
ac dec 50 1G 10G
let gain_db = vdb(OUT)
meas ac max_gain max gain_db
meas ac f_peak max_at gain_db
meas ac gain_5g2 find gain_db at=5.2G

* Transient Analysis
tran 10p 5n
meas tran vpp_out pp v(OUT)

quit
.endc
.end
