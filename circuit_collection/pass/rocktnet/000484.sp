* Dynamic Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5

XM1 N1 LATCH VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 INP N1 VSS sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 VREFN N1 VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 VREFP N1 VSS sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 INN N1 VSS sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VOUT_MINUS VOUT_PLUS N2 VSS sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VOUT_PLUS VOUT_MINUS N3 VSS sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 LATCH VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 VOUT_MINUS LATCH VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 VOUT_MINUS VOUT_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 VOUT_PLUS VOUT_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 VOUT_PLUS LATCH VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N3 LATCH VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}

VVDD VDD 0 1.8
VVSS VSS 0 0
VLATCH LATCH 0 PULSE(0 1.8 2n 100p 100p 4n 10n)
VVREFP VREFP 0 1.0
VVREFN VREFN 0 0.8
VINP INP 0 PWL(0 1.05 15n 1.05 15.1n 0.95 30n 0.95)
VINN INN 0 PWL(0 0.75 15n 0.75 15.1n 0.85 30n 0.85)

C1 VOUT_PLUS 0 10f
C2 VOUT_MINUS 0 10f

.control
tran 10p 30n
meas tran delay_state1 trig v(LATCH) val=0.9 rise=1 targ v(VOUT_MINUS) val=0.9 fall=1
meas tran delay_state2 trig v(LATCH) val=0.9 rise=3 targ v(VOUT_PLUS) val=0.9 fall=1
meas tran avg_current avg i(VVDD) from=0 to=30n
let avg_power = -avg_current * 1.8
print delay_state1 delay_state2 avg_power
quit
.endc
.end
