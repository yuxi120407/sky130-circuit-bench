* VDD/2 Voltage Reference Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmn0=0.5
.param L_xmn1=0.5
.param L_xmn2=0.5
.param L_xmn3=0.5
.param L_xmp0=0.5
.param L_xmp1=0.5

.param W_xmn1=5.0 L_xmn1=0.5
.param W_xmn0=5.0 L_xmn0=0.5
.param W_xmp0=5.0 L_xmp0=0.5
.param W_xmp1=5.0 L_xmp1=0.5
.param W_xmn2=5.0 L_xmn2=0.5
.param W_xmn3=5.0 L_xmn3=0.5

VVDD VDD 0 1.8
I_load N0 0 DC 0 AC 1

XMN1 N0 N0 0 0 sky130_fd_pr__nfet_01v8 l={L_xmn1} w={W_xmn1}
XMN0 N0 N0 0 0 sky130_fd_pr__nfet_01v8 l={L_xmn0} w={W_xmn0}
XMP0 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp0} w={W_xmp0}
XMP1 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp1} w={W_xmp1}
XMN2 N0 VDD N0 0 sky130_fd_pr__nfet_01v8 l={L_xmn2} w={W_xmn2}
XMN3 VDD VDD N0 0 sky130_fd_pr__nfet_01v8 l={L_xmn3} w={W_xmn3}

.control
* 1. DC Operating Point
op
let v_ref = v(N0)
let power = -i(VVDD) * 1.8
print v_ref power

* 2. AC Analysis for Output Impedance
ac dec 10 1 1G
let z_out_db = vdb(N0)
meas ac r_out_db find z_out_db at=1k

* 3. DC Sweep for Line Regulation
dc VVDD 0 1.8 0.01
meas dc v_ref_18 find v(N0) at=1.8
meas dc v_ref_17 find v(N0) at=1.7
let line_reg = (v_ref_18 - v_ref_17) / 0.1
print line_reg

quit
.endc
.end