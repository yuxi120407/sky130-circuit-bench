* Differential Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5

* DUT
XM2 OUTN INP N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 OUTP INN N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM3 N0 NBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Loads (Added to complete the circuit)
R1 VDD OUTP 2k
R2 VDD OUTN 2k
C1 OUTP 0 40f
C2 OUTN 0 40f

* Sources
VVDD VDD 0 1.8
VNBIAS NBIAS 0 0.7

* Differential AC/Tran source
VINP INP 0 DC 0.9 AC 0.5 SIN(0.9 0.1 100MEG)
VINN INN 0 DC 0.9 AC -0.5 SIN(0.9 -0.1 100MEG)

* VCVS to compute differential output
E1 OUT_DIFF 0 OUTN OUTP 1

.control
* DC Operating Point
op
let power = -i(VVDD)*1.8
print power

* AC Analysis
ac dec 100 1k 100G
let gain_db = vdb(OUT_DIFF)
meas ac max_gain MAX gain_db
let gain_3db = max_gain - 3
meas ac bw_3db when gain_db=gain_3db fall=1

* Transient Analysis
tran 10p 20n
meas tran vpp_out_diff pp v(OUT_DIFF)

quit
.endc
.end
