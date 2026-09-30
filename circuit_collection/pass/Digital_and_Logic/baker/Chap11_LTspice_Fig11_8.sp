* CMOS Inverter Transfer Characteristics for Different Beta Ratios (Fig 11.8)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_dev=0.5
.param W_n=1.0
* KPn/KPp = 270/50 = 5.4 in Sky130
* For beta_n/beta_p = 1: Wp = 5.4 * Wn
.param W_p1=5.4
* For beta_n/beta_p = 3: Wp = (5.4 / 3) * Wn = 1.8
.param W_p3=1.8
* For beta_n/beta_p = 1/3: Wp = (5.4 * 3) * Wn = 16.2
.param W_p333=16.2

* Power Supplies
VDD VDD 0 DC 1.8
Vin Vin 0 DC 0.0

* DUT: Inverters with beta ratios 1, 3, and 1/3
xm1 Vout1 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_n} l={L_dev}
xm2 Vout1 Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_p1} l={L_dev}

xm3 Vout3 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_n} l={L_dev}
xm4 Vout3 Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_p3} l={L_dev}

xm5 Vout333 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_n} l={L_dev}
xm6 Vout333 Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_p333} l={L_dev}

.control
set savecurrents
save all @m.xm1.msky130_fd_pr__nfet_01v8[id]
dc Vin 0 1.8 0.001

* Switching points where Vout = Vin
let diff1 = v(Vout1) - v(Vin)
let diff3 = v(Vout3) - v(Vin)
let diff333 = v(Vout333) - v(Vin)

meas dc switching_point_beta1 when diff1=0
meas dc switching_point_beta3 when diff3=0
meas dc switching_point_beta_third when diff333=0

* Noise margins for symmetric inverter (beta1)
let dvout = deriv(v(Vout1))
meas dc vil when dvout=-1 fall=1
meas dc vih when dvout=-1 rise=1
meas dc noise_margin_low_beta1 param='vil'
meas dc noise_margin_high_beta1 param='1.8 - vih'

* Peak crossing current in the symmetric inverter
let icross1 = abs(@m.xm1.msky130_fd_pr__nfet_01v8[id])
meas dc peak_crossing_current_beta1 max icross1

print switching_point_beta1 switching_point_beta3 switching_point_beta_third
print noise_margin_low_beta1 noise_margin_high_beta1 peak_crossing_current_beta1
quit
.endc
.end