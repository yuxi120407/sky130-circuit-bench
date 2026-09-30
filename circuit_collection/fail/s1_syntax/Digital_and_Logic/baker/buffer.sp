* CMOS Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_XM0=0.5
.param L_XM1=0.5
.param L_XM2=0.5
.param L_XM3=0.5
.param W_XM2=5.0
.param W_XM3=5.0
.option scale=1e-6

* Define parameters for the parameterized netlist
.param W_XM0=1 L_XM0=0.15 W_XM2=2 L_XM2=0.15
.param W_XM1=4 L_XM1=0.15 W_XM3=8 L_XM3=0.15

* Circuit Analysis
.subckt BUFFER IN OUT VSS VDD
* First stage inverter
XM0 OUT1 IN VSS VSS sky130_fd_pr__nfet_01v8 w={W_XM0} l={L_XM0}
XM2 OUT1 IN VDD VDD sky130_fd_pr__pfet_01v8 w={W_XM2} l={L_XM2}
* Second stage inverter  
XM1 OUT OUT1 VSS VSS sky130_fd_pr__nfet_01v8 w={W_XM1} l={L_XM1}
XM3 OUT OUT1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_XM3} l={L_XM3}
.ends BUFFER

* Test circuit
Vdd VDD 0 DC 1.8
Vss VSS 0 DC 0
Xcircuit IN OUT VSS VDD BUFFER
Cout OUT 0 10e-15

* Input Sources
Vin IN 0 DC 0 PULSE(0 1.8 1n 50p 50p 4n 10n)

.control
* === DC Sweep for Switching Threshold ===
dc Vin 0 1.8 0.01
meas dc vsp_stage1 find v(out1) when v(out1)=v(in)
meas dc vsp_buffer find v(in) when v(out)=0.9

* === Transient for Power and Delay ===
tran 10p 20n

* Rise and Fall Times (10% to 90% of 1.8V)
meas tran t_rise trig v(out) val=0.18 rise=1 targ v(out) val=1.62 rise=1
meas tran t_fall trig v(out) val=1.62 fall=1 targ v(out) val=0.18 fall=1

* Propagation Delay (50% to 50%)
meas tran t_delay_rise trig v(in) val=0.9 rise=1 targ v(out) val=0.9 rise=1
meas tran t_delay_fall trig v(in) val=0.9 fall=1 targ v(out) val=0.9 fall=1
meas tran t_pd param = '(t_delay_rise + t_delay_fall)/2'

* Dynamic Power
meas tran i_avg avg i(Vdd)
let power = -i_avg * 1.8
print power

quit
.endc
.end