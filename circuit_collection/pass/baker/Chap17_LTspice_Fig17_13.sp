* Testbench for Switched-Capacitor Charge Injection (Baker Fig 17.9 / 17.10 / 17.12)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm3=2.0 L_xm3=0.15
.param W_xm1=2.0 L_xm1=0.15
.param W_xm2=2.0 L_xm2=0.15
.param W_xm4=5.0 L_xm4=0.15

* DUT
VDD VDD 0 1.8
xm3 N001 phi1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm1 N002 phi2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 N003 0 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
C1 N001 0 1e-13
xm4 vbit VREF N003 N003 sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
VREF VREF 0 500m

* Bitline voltage source (fixed at 0.4V within valid range < VREF + Vthp)
Vbit vbit 0 0.4

* Non-overlapping clocks: period = 10ns
* phi1 is low from 0.5ns to 4.5ns (precharge Ccup to VDD)
Vphi1 phi1 0 PULSE(1.8 0 0.5n 0.1n 0.1n 4.0n 10n)
* phi2 is low from 5.5ns to 9.5ns (dump charge into bit line)
Vphi2 phi2 0 PULSE(1.8 0 5.5n 0.1n 0.1n 4.0n 10n)

.tran 10p 50n 25n

.control
run

* Current into bit line is i(Vbit)
let ibit_mag = i(Vbit)

* Peak dumping current during a dump cycle (e.g., between 35ns and 40ns)
meas tran peak_current max ibit_mag from=35n to=40n

* Settling current right before phi2 shuts off at t=39.5ns
meas tran residual_settling_current find ibit_mag at=39.4n

* Integrated charge delivered in one period (from t=35ns to 45ns)
meas tran charge_per_packet integ ibit_mag from=35n to=45n

* Output limits check
let vbit_max_limit = 0.5 + 0.42
let vref_upper_bound = 1.8 - 0.42

print peak_current residual_settling_current charge_per_packet vbit_max_limit vref_upper_bound

quit
.endc
.end