* Sky130 2-Input NAND Gate Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param W_XMN1=5.0
.param W_XMN2=5.0
.param W_XMP1=5.0
.param W_XMP2=5.0
.global VDD GND
.temp 27

.param L_XMP1=0.15 W_XMP1=2.0
.param L_XMP2=0.15 W_XMP2=2.0
.param L_XMN1=0.15 W_XMN1=1.0
.param L_XMN2=0.15 W_XMN2=1.0

* DUT
XMP1 Y A VDD VDD sky130_fd_pr__pfet_01v8 l={L_XMP1} w={W_XMP1}
XMP2 Y B VDD VDD sky130_fd_pr__pfet_01v8 l={L_XMP2} w={W_XMP2}
XMN1 Y A N1 GND sky130_fd_pr__nfet_01v8 l={L_XMN1} w={W_XMN1}
XMN2 N1 B GND GND sky130_fd_pr__nfet_01v8 l={L_XMN2} w={W_XMN2}

* Load
CL Y GND 10e-15

* Supply and Input stimuli
VDD VDD GND DC 1.8
VB  B   GND DC 1.8
VA  A   GND DC 0 PULSE(0 1.8 1n 20p 20p 2n 4n)

.control
* 1. DC Operating Point & Static Power
op
let p_stat = -i(vdd) * 1.8
print p_stat

* 2. DC Sweep for Switching Threshold
dc VA 0 1.8 0.005
meas dc switching_threshold when v(Y)=v(A) cross=1

* 3. Transient Analysis for Delays and Transition Times
tran 1p 5n
* Propagation Delays (50% to 50%)
meas tran propagation_delay_hl trig v(A) val=0.9 rise=1 targ v(Y) val=0.9 fall=1
meas tran propagation_delay_lh trig v(A) val=0.9 fall=1 targ v(Y) val=0.9 rise=1

* Output Transition Times (10% to 90%)
meas tran fall_time trig v(Y) val=1.62 fall=1 targ v(Y) val=0.18 fall=1
meas tran rise_time trig v(Y) val=0.18 rise=1 targ v(Y) val=1.62 rise=1

print switching_threshold propagation_delay_hl propagation_delay_lh fall_time rise_time
quit
.endc
.end
