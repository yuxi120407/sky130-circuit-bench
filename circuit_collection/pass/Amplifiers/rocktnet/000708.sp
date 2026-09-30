* Active Feedback Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm5_prime=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm5_prime=5.0 L_xm5_prime=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5

VVDD VDD 0 1.8
VIN IN 0 DC 0.65 AC 1 PULSE(0.6 0.7 0.1n 50p 50p 400p 1n)

* Short N4 to N5 to close the feedback loop
Vshort N4 N5 0

* Bias currents (ideal sources for testing)
I_tail N1 0 40u
I_N3 N3 0 20u
I_OUT OUT 0 20u

* Load capacitance
Cload OUT 0 50f

* DUT
XM1 N2 IN N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM5 VDD N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM5_PRIME VDD N4 OUT GND sky130_fd_pr__nfet_01v8 l={L_xm5_prime} w={W_xm5_prime}
XM3 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM2 N5 N3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM4 N5 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 20 1Meg 10G
let gain_db = db(v(OUT))
meas ac dc_gain find gain_db at=1Meg
meas ac bw_3db when gain_db=-3 fall=1

tran 10p 3n
meas tran trise trig v(OUT) val=0.61 rise=1 targ v(OUT) val=0.69 rise=1
meas tran delay trig v(IN) val=0.65 rise=1 targ v(OUT) val=0.65 rise=1

quit
.endc
.end