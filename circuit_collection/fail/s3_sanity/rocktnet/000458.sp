* Testbench for Frequency Divider
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmn1=0.5
.param L_xmn2=0.5
.param L_xmn3=0.5
.param L_xmn4=0.5
.param L_xmn5=0.5
.param L_xmp1=0.5
.param L_xmp2=0.5

* DUT Parameters
.param W_xmn4=5.0 L_xmn4=0.5
.param W_xmp2=5.0 L_xmp2=0.5
.param W_xmn3=5.0 L_xmn3=0.5
.param W_xmp1=5.0 L_xmp1=0.5
.param W_xmn2=5.0 L_xmn2=0.5
.param W_xmn1=5.0 L_xmn1=0.5
.param W_xmn5=5.0 L_xmn5=0.5

* DUT Instantiation
XMN4 N4 LABEL_NET_0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xmn4} w={W_xmn4}
XMP2 N4 CLK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp2} w={W_xmp2}
XMN3 N1 LABEL_NET_1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xmn3} w={W_xmn3}
XMP1 N3 CLK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp1} w={W_xmp1}
XMN2 N4 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xmn2} w={W_xmn2}
XMN1 N3 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xmn1} w={W_xmn1}
XMN5 CLK BIAS N0 VDD sky130_fd_pr__pfet_01v8 l={L_xmn5} w={W_xmn5}

* Fix for likely extraction error (N1 should be connected to N3 to complete the cross-coupled pair)
Rfix N1 N3 0.001

* Voltage Sources
VVDD VDD 0 1.8
V0 LABEL_NET_0 0 1.8
V1 LABEL_NET_1 0 1.8
VBIAS BIAS 0 -1.8

* 200 MHz Clock Input
VCLK CLK 0 PULSE(0 1.8 0 20p 20p 2.48n 5.0n)

* Kickstart to break symmetry
Ikick 0 N4 PULSE(0 2m 0 10p 10p 100p 100n)

.control
* Run transient analysis for 100ns
tran 100p 100n

* Measure average power consumption
meas tran pwr_avg avg i(VVDD) from=50n to=100n
let power_consumption = -pwr_avg * 1.8
print power_consumption

* Measure output voltage swing
meas tran vmax max v(N4) from=50n to=100n
meas tran vmin min v(N4) from=50n to=100n
let output_swing = vmax - vmin
print output_swing

* Measure operating frequency (period between two rising edges)
meas tran t1 trig v(N4) val=0.9 rise=1 from=50n targ v(N4) val=0.9 rise=2 from=50n
let operating_frequency = 1 / t1
print operating_frequency

quit
.endc
.end