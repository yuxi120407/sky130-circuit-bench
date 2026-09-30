* Telescopic OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_XMN_BIAS=0.5
.param L_XMN_BIASC=0.5
.param L_XMP_BIAS=0.5
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameter definitions for the parameterized netlist
.param W_xm1=5 L_xm1=0.5
.param W_xm2=10 L_xm2=0.5
.param W_xm3=20 L_xm3=0.5
.param W_xm4=20 L_xm4=0.5
.param W_xm5=20 L_xm5=0.5
.param W_xm6=20 L_xm6=0.5
.param W_xm7=20 L_xm7=0.5
.param W_xm8=20 L_xm8=0.5
.param W_xm9=10 L_xm9=0.5
.param W_xm10=10 L_xm10=0.5
.param W_XMN_BIAS=5 L_XMN_BIAS=0.5
.param W_XMP_BIAS=10 L_XMP_BIAS=0.5
.param W_XMN_BIASC=1 L_XMN_BIASC=0.5

* --- DUT Netlist ---
.subckt TELESCOPIC_OTA VBIASN VBIASNC VBIASP1 VBIASP2 VINN VINP VOUTN VOUTP VDD 0
xm1 ID   VBIASN  0   0  sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 NET10 VBIASN 0   0  sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 NET8   VINP NET10 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 NET014 VINN NET10 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 VOUTN VBIASNC NET8   0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5} 
xm6 VOUTP VBIASNC NET014 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 VOUTN VBIASP1 NET06 VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 VOUTP VBIASP1 NET012 VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9  NET06 VBIASP2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 NET012 VBIASP2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
.ends TELESCOPIC_OTA

VDD VDD 0 DC 1.8
IBIAS_N VDD VBIASN DC 10e-6
XMN_BIAS VBIASN VBIASN 0 0 sky130_fd_pr__nfet_01v8 w={W_XMN_BIAS} l={L_XMN_BIAS}
IBIAS_P VBIASP2 0 DC 10e-6
XMP_BIAS VBIASP2 VBIASP2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_XMP_BIAS} l={L_XMP_BIAS}
VBIASP1 VBIASP1 0 DC=1.15
IBIAS_NC VDD VBIASNC DC 10e-6
XMN_BIASC VBIASNC VBIASNC 0 0 sky130_fd_pr__nfet_01v8 w={W_XMN_BIASC} l={L_XMN_BIASC}

XOTA VBIASN VBIASNC VBIASP1 VBIASP2 VINN VINP VOUTN VOUTP VDD 0 TELESCOPIC_OTA
CLOADP VOUTP 0 1e-12
CLOADN VOUTN 0 1e-12
* --- End DUT Netlist ---

* Ideal Common-Mode Feedback (CMFB) to hold output CM at 0.9V
B_cmfb_p VOUTP 0 I=1e-3 * ( (V(VOUTP)+V(VOUTN))/2 - 0.9 )
B_cmfb_n VOUTN 0 I=1e-3 * ( (V(VOUTP)+V(VOUTN))/2 - 0.9 )

* Stimulus
V_IN_CM V_CM 0 DC 0.9
V_IN_DIFF V_DIFF 0 DC 0 AC 1 PULSE(-0.5 0.5 10n 100p 100p 100n 200n)

B_INP VINP 0 V=V(V_CM) + 0.5*V(V_DIFF)
B_INN VINN 0 V=V(V_CM) - 0.5*V(V_DIFF)

* Differential Output Node for easy measurement
B_OUT_DIFF VOUT_DIFF 0 V=V(VOUTP) - V(VOUTN)

.control
* 1. DC Operating Point & Power
op
let power = -i(VDD) * 1.8
print power

* 2. AC Analysis
ac dec 100 1 1G
let gain_db = vdb(VOUT_DIFF)
let phase = 180/PI * cph(v(VOUT_DIFF))
meas ac dc_gain find gain_db at=10
meas ac f_ug when gain_db=0 fall=1
meas ac phase_at_ug find phase when gain_db=0 fall=1
let pm = 180 + phase_at_ug
print pm

* 3. Transient Analysis (Slew Rate)
tran 100p 200n
* Measure time to slew 1V (from -0.5V to +0.5V)
meas tran t_rise trig v(VOUT_DIFF) val=-0.5 rise=1 targ v(VOUT_DIFF) val=0.5 rise=1
let sr_rise = 1.0 / t_rise
print sr_rise

quit
.endc
.end