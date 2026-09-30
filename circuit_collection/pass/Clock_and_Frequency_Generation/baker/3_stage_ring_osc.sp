* 3-Stage Ring Oscillator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param W_XMN0=5.0
.param W_XMN1=5.0
.param W_XMN2=5.0
.param W_XMP0=5.0
.param W_XMP1=5.0
.param W_XMP2=5.0

* Define parameters for the parameterized netlist
.param L_XMP0=0.15 W_XMP0=2.0
.param L_XMN0=0.15 W_XMN0=1.0
.param L_XMP1=0.15 W_XMP1=2.0
.param L_XMN1=0.15 W_XMN1=1.0
.param L_XMP2=0.15 W_XMP2=2.0
.param L_XMN2=0.15 W_XMN2=1.0

* DUT Netlist
XMP0 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_XMP0} w={W_XMP0}
XMN0 N1 N0 0 0 sky130_fd_pr__nfet_01v8 l={L_XMN0} w={W_XMN0}

XMP1 N2 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_XMP1} w={W_XMP1}
XMN1 N2 N1 0 0 sky130_fd_pr__nfet_01v8 l={L_XMN1} w={W_XMN1}

XMP2 N0 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_XMP2} w={W_XMP2}
XMN2 N0 N2 0 0 sky130_fd_pr__nfet_01v8 l={L_XMN2} w={W_XMN2}

CL N0 0 10f
VDD VDD 0 DC 1.8

* Initial conditions to kickstart oscillation
.ic v(N0)=0 v(N1)=1.8 v(N2)=0

.options savecurrents

.control
* Run transient analysis for 20ns to allow settling
tran 10p 20n

* Measure Oscillation Frequency
meas tran t_period trig v(N0) val=0.9 rise=10 targ v(N0) val=0.9 rise=11
let f_osc = 1 / t_period
print f_osc

* Measure Average Power Consumption (integrate current from 10ns to 20ns)
meas tran pwr_integ integ i(VDD) from=10n to=20n
let pwr_avg = - (pwr_integ / 10n) * 1.8
print pwr_avg

* Measure Output Swing
meas tran vmax max v(N0) from=10n to=20n
meas tran vmin min v(N0) from=10n to=20n
let vswing = vmax - vmin
print vswing

quit
.endc
.end