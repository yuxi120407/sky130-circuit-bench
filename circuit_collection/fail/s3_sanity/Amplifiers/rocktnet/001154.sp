* Testbench for Comparator Preamplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xmsw=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xmsw=5.0 L_xmsw=0.5

VVDD VDD 0 1.8
VBIAS BIAS 0 0.7
VVREF_PLUS VREF_PLUS 0 0.9
VVREF_MINUS VREF_MINUS 0 0.9
VVIN_PLUS VIN_PLUS 0 DC 0.9 AC 1
VVIN_MINUS VIN_MINUS 0 DC 0.9 AC 0
VCLK CLK 0 DC 0 PULSE(0 1.8 0 10p 10p 400p 1n)

XM1 VOUT_MINUS VREF_PLUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT_MINUS VOUT_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT_MINUS VIN_PLUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT_MINUS VOUT_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 VOUT_MINUS VIN_MINUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VOUT_MINUS VREF_MINUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XMSW VOUT_MINUS CLK VOUT_MINUS GND sky130_fd_pr__nfet_01v8 l={L_xmsw} w={W_xmsw}

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac dec 10 1 100G
meas ac dc_gain find vdb(VOUT_MINUS) at=1
let gain_3db = dc_gain - 3
meas ac bandwidth when vdb(VOUT_MINUS)=gain_3db fall=1
print dc_gain
print bandwidth
.endc
.end