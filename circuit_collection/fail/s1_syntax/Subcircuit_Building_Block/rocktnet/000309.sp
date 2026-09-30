* Staircase Ramp Generator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM3 N3 N3 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM7 VOUT RESET VSS GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM6 N2 STEP VSS GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM2 N5 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM5 N3 N2 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM4 VOUT N3 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VVSS VSS 0 0

* Bias and Control
VVCTRL VCTRL 0 0.5
R1 VCTRL N2 10k

* Load Capacitor
C1 VOUT VSS 10pF

* Stimulus
* RESET: High initially to discharge C1, then low to allow charging
VRESET RESET 0 PULSE(1.8 0 1u 1n 1n 100u 200u)
* STEP: Clock signal to pulse the current (1us period, 0.1us active low)
VSTEP STEP 0 PULSE(1.8 0 1.1u 1n 1n 0.1u 1u)

.control
tran 10n 20u

* Measure ramp slope between 5us and 15us
meas tran v_5u find v(VOUT) at=5u
meas tran v_10u find v(VOUT) at=10u
meas tran v_15u find v(VOUT) at=15u

let ramp_slope = (v_15u - v_5u) / 10e-6
print ramp_slope

* Calculate linearity error (difference in slope between two halves)
let slope1 = (v_10u - v_5u) / 5e-6
let slope2 = (v_15u - v_10u) / 5e-6
let slope_diff = slope1 - slope2
let linearity_error = abs(100 * (slope_diff / ramp_slope))
print linearity_error

* Measure step size (one cycle from 5.05u to 6.05u)
meas tran v_step_start find v(VOUT) at=5.05u
meas tran v_step_end find v(VOUT) at=6.05u
let step_size = v_step_end - v_step_start
print step_size

* Measure power
meas tran avg_current avg i(VVDD) from=2u to=18u
let power_consumption = -avg_current * 1.8
print power_consumption

quit
.endc
.end