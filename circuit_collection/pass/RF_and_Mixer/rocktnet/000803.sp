* Testbench for Passive Mixer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

VVDD VDD 0 1.8

* RF input (5.01 GHz, 10mV peak)
V_RF N2 0 dc 0 sin(0 10m 5.01G)

* LO inputs (5 GHz, 0.6V peak, 0.6V DC bias)
* LOCP and LOCN have a slightly shifted DC bias to emulate the bias-shifting network
V_LOP LOP 0 sin(0.6 0.6 5G 0 0 0)
V_LOCN LOCN 0 sin(0.65 0.6 5G 0 0 0)
V_LON LON 0 sin(0.6 0.6 5G 0 0 180)
V_LOCP LOCP 0 sin(0.65 0.6 5G 0 0 180)

* IF Load (10k || 0.1pF)
C1 N0 0 0.1p
R1 N0 0 10k
C2 N1 0 0.1p
R2 N1 0 10k

* DUT
XM1 N0 LON N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LOP N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LOCN N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LOCP N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Differential output and ideal low-pass filter for measurement (Pole ~ 159 MHz)
E_diff Ndiff 0 vol='v(N0)-v(N1)'
R_flt Ndiff Ndiff_flt 1k
C_flt Ndiff_flt 0 1p

.control
* Simulate for 200ns to capture two full 10MHz IF cycles
tran 10p 200n

* Measure peak-to-peak of the filtered IF signal in the second cycle
meas tran max_vd max v(Ndiff_flt) from=100n to=200n
meas tran min_vd min v(Ndiff_flt) from=100n to=200n

* Calculate Voltage Conversion Gain (VCG)
let vd_amp = (max_vd - min_vd)/2
let vcg = vd_amp / 10m
let vcg_db = 20 * log10(vcg)

print vcg_db
quit
.endc
.end
