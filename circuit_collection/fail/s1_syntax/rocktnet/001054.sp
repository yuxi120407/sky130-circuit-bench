* Testbench for Extracted Memory Cell
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmn0=0.5
.param L_xmn1=0.5
.param L_xmn2=0.5
.param L_xmn3=0.5
.param L_xmn4=0.5
.param L_xmn5=0.5
.param L_xmp0=0.5
.param L_xmp1=0.5
.param W_WL=5.0

.param W_xmp0=5.0 L_xmp0=0.5
.param W_xmn0=5.0 L_xmn0=0.5
.param W_xmp1=5.0 L_xmp1=0.5
.param W_xmn1=5.0 L_xmn1=0.5
.param W_xmn3=5.0 L_xmn3=0.5
.param W_xmn2=5.0 L_xmn2=0.5
.param W_xmn5=5.0 L_xmn5=0.5
.param W_xmn4=5.0 L_xmn4=0.5

VVDD VDD 0 1.8
VW_WL W_WL 0 0
VR_WL R_WL 0 PULSE(0 1.8 1n 50p 50p 5n 10n)

* Precharge circuit for R_BL_BAR
MPRE R_BL_BAR PRE_EN VDD VDD sky130_fd_pr__pfet_01v8 w=1.0 l=0.15
VPRE_EN PRE_EN 0 PULSE(0 1.8 0.5n 50p 50p 10n 20n)
CBL R_BL_BAR 0 10f

* DUT
XMP0 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp0} w={W_xmp0}
XMN0 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xmn0} w={W_xmn0}
XMP1 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp1} w={W_xmp1}
XMN1 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xmn1} w={W_xmn1}
XMN3 N2 W_WL N2 GND sky130_fd_pr__nfet_01v8 l={L_xmn3} w={W_xmn3}
XMN2 N2 W_WL N2 GND sky130_fd_pr__nfet_01v8 l={L_xmn2} w={W_xmn2}
XMN5 R_BL_BAR R_WL N2 GND sky130_fd_pr__nfet_01v8 l={L_xmn5} w={W_xmn5}
XMN4 N2 R_WL N2 GND sky130_fd_pr__nfet_01v8 l={L_xmn4} w={W_xmn4}

.control
op
let static_power = -i(VVDD) * 1.8
let v_n2 = v(N2)
print v_n2 static_power

tran 10p 10n
meas tran read_delay trig v(R_WL) val=0.9 rise=1 targ v(R_BL_BAR) val=1.4 fall=1
quit
.endc
.end
