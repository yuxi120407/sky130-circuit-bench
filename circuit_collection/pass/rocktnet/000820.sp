* Differential to Single-Ended Clock Buffer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_bias=0.5
.param L_dp=0.5
.param L_invn=0.5
.param L_invp=0.5
.param L_pm=0.5
.param L_tail=0.5

.param W_bias=2.0 L_bias=0.15
.param W_tail=10.0 L_tail=0.15
.param W_dp=10.0 L_dp=0.15
.param W_pm=10.0 L_pm=0.15
.param W_invp=10.0 L_invp=0.15
.param W_invn=5.0 L_invn=0.15

I1 VDD N0 100u
XM2 N4 N4 VDD VDD sky130_fd_pr__pfet_01v8 w={W_pm} l={L_pm}
XM8 clk N1 GND GND sky130_fd_pr__nfet_01v8 w={W_invn} l={L_invn}
XM3 N1 N4 VDD VDD sky130_fd_pr__pfet_01v8 w={W_pm} l={L_pm}
XM7 clk N1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_invp} l={L_invp}
XM4 N4 clk_inN N3 GND sky130_fd_pr__nfet_01v8 w={W_dp} l={L_dp}
XM1 N0 N0 GND GND sky130_fd_pr__nfet_01v8 w={W_bias} l={L_bias}
XM6 N3 N0 GND GND sky130_fd_pr__nfet_01v8 w={W_tail} l={L_tail}
XM5 N1 clk_inP N3 GND sky130_fd_pr__nfet_01v8 w={W_dp} l={L_dp}

Cload clk GND 10f

VVDD VDD 0 1.8
VclkP clk_inP 0 DC 0.9 SINE(0.9 0.4 1G 0 0 0) AC 1
VclkN clk_inN 0 DC 0.9 SINE(0.9 0.4 1G 0 0 180)

.control
tran 1p 10n

meas tran t_in_r5 WHEN v(clk_inP)=0.9 rise=1 TD=3.9n
meas tran t_out_r5 WHEN v(clk)=0.9 rise=1 TD=3.9n
let propagation_delay = t_out_r5 - t_in_r5

meas tran t_out_r6 WHEN v(clk)=0.9 rise=2 TD=3.9n
let t_period = t_out_r6 - t_out_r5

meas tran t_out_f5 WHEN v(clk)=0.9 fall=1 TD=3.9n
let t_high = t_out_f5 - t_out_r5
let duty_cycle = (t_high / t_period) * 100

meas tran t_r20 WHEN v(clk)=0.36 rise=1 TD=3.9n
meas tran t_r80 WHEN v(clk)=1.44 rise=1 TD=3.9n
let rise_time = t_r80 - t_r20

meas tran t_f80 WHEN v(clk)=1.44 fall=1 TD=3.9n
meas tran t_f20 WHEN v(clk)=0.36 fall=1 TD=3.9n
let fall_time = t_f20 - t_f80

meas tran pwr_avg avg i(VVDD) from=4n to=9n
let power_consumption = -pwr_avg * 1.8

meas tran t_slew1 WHEN v(clk)=0.8 rise=1 TD=3.9n
meas tran t_slew2 WHEN v(clk)=1.0 rise=1 TD=3.9n
let slew_rate = 0.2 / (t_slew2 - t_slew1)

noise v(clk) VclkP dec 10 1k 10G

setplot tran1
print propagation_delay
print rise_time
print fall_time
print duty_cycle
print power_consumption

setplot noise2
let clock_jitter = onoise_total / tran1.slew_rate
print clock_jitter

quit
.endc
.end