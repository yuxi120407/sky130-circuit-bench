* Testbench for Burst-Mode Receiver Buffer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm5_prime=0.5
.param L_xm6=0.5

.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm5_prime=5.0 L_xm5_prime=0.5
.param W_xm3=5.0 L_xm3=0.5

* DUT
XM5 VDD N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 RESET GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM1 N3 IN N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM4 N4 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM2 N4 N1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM5_PRIME VDD N0 OUT GND sky130_fd_pr__nfet_01v8 l={L_xm5_prime} w={W_xm5_prime}
XM3 N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}

* Missing connections and biasing
R_short N4 N0 1m
I_tail N5 GND 50u
I_load1 N1 GND 30u
R_load OUT GND 10k
C_load OUT GND 250f

* Sources
VVDD VDD 0 1.8
VIN IN 0 DC 0.3 AC 1 PULSE(0.2 0.4 1n 0.1n 0.1n 20n 40n)
VRESET RESET 0 PULSE(0 1.8 10n 0.1n 0.1n 10n 40n)

.control
  * DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * AC Analysis
  ac dec 50 1Meg 10G
  let gain_db = vdb(OUT)
  meas ac dc_gain find gain_db at=1Meg
  meas ac bandwidth when gain_db=-3 fall=1
  print dc_gain bandwidth

  * Transient Analysis
  tran 10p 25n
  meas tran delay_rise trig v(IN) val=0.3 rise=1 targ v(OUT) val=0.3 rise=1
  meas tran reset_time trig v(RESET) val=0.9 rise=1 targ v(OUT) val=0.1 fall=1
  print delay_rise reset_time
  
  quit
.endc
.end