* Dynamic Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0

VVDD VDD 0 1.8

* DUT
XM1 V_DN_2_MINUS V_UP_2_PLUS N5 0 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 PHI_COMP 0 0 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 V_DN_2_PLUS V_UP_2_MINUS N5 0 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 V_UP_2_PLUS V_DN_2_MINUS N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 V_UP_2_MINUS V_DN_2_PLUS N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 PHI_COMP_B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

* Load capacitors
C1 V_UP_2_PLUS 0 10f
C2 V_UP_2_MINUS 0 10f
C3 V_DN_2_PLUS 0 10f
C4 V_DN_2_MINUS 0 10f

* Precharge circuitry
.model sw_mod sw vt=0.9 ron=100 roff=1G
S1 V_UP_2_PLUS VPRE_P PRECHARGE 0 sw_mod
S2 V_DN_2_MINUS VPRE_N PRECHARGE 0 sw_mod
S3 V_UP_2_MINUS VPRE_N PRECHARGE 0 sw_mod
S4 V_DN_2_PLUS VPRE_P PRECHARGE 0 sw_mod
S5 N4 VDD PRECHARGE 0 sw_mod
S6 N5 0 PRECHARGE 0 sw_mod

VPRE_P VPRE_P 0 0.905
VPRE_N VPRE_N 0 0.895
VPRECHARGE PRECHARGE 0 PWL(0 1.8 0.5n 1.8 0.51n 0)

* Clocks
VPHI_COMP PHI_COMP 0 PWL(0 0 0.6n 0 0.61n 1.8)
VPHI_COMP_B PHI_COMP_B 0 PWL(0 1.8 0.6n 1.8 0.61n 0)

.control
tran 1p 3n
meas tran t_clk WHEN v(PHI_COMP)=0.9 RISE=1
meas tran t_out WHEN v(V_UP_2_PLUS)=1.62 RISE=1
let latch_delay = t_out - t_clk
print latch_delay

meas tran q_vdd INTEG i(VVDD) FROM=0.6n TO=3n
let energy_per_conversion = -q_vdd * 1.8
print energy_per_conversion
quit
.endc
.end