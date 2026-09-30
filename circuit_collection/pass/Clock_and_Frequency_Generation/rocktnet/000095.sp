* Frequency Doubler Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param W_xm1=5.0 L_xm1=0.5

XM1 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

Vdd VDD GND 1.8
Rload VDD N1 50

* Input signal: 1 GHz, 0.5V amplitude, 0.9V offset
Vin N0 GND dc 0.9 sin(0.9 0.5 1G)

.control
tran 1p 20n

* Calculate DC power
meas tran I_vdd avg i(Vdd) from=10n to=20n
let P_dc = -I_vdd * 1.8
let P_dc_mW = P_dc * 1000
print P_dc_mW

* 1st Harmonic (1 GHz)
let out_sin1f = v(N1) * sin(2 * 3.14159265359 * 1G * time)
let out_cos1f = v(N1) * cos(2 * 3.14159265359 * 1G * time)
meas tran a1 avg out_sin1f from=10n to=20n
meas tran b1 avg out_cos1f from=10n to=20n
let mag1f = 2 * sqrt(a1*a1 + b1*b1)
let Pout_1f_W = (mag1f * mag1f) / (2 * 50)
let Pout_1f_dBm = 10 * log10(Pout_1f_W * 1000 + 1e-20)
print Pout_1f_dBm

* 2nd Harmonic (2 GHz)
let out_sin2f = v(N1) * sin(2 * 3.14159265359 * 2G * time)
let out_cos2f = v(N1) * cos(2 * 3.14159265359 * 2G * time)
meas tran a2 avg out_sin2f from=10n to=20n
meas tran b2 avg out_cos2f from=10n to=20n
let mag2f = 2 * sqrt(a2*a2 + b2*b2)
let Pout_2f_W = (mag2f * mag2f) / (2 * 50)
let Pout_2f_dBm = 10 * log10(Pout_2f_W * 1000 + 1e-20)
print Pout_2f_dBm

* Conversion Gain
let Pin_W = (0.5 * 0.5) / (2 * 50)
let Pin_dBm = 10 * log10(Pin_W * 1000)
let CG_dB = Pout_2f_dBm - Pin_dBm
print CG_dB

* Efficiency
let eff = (Pout_2f_W / P_dc) * 100
print eff

* Fundamental Rejection (Fundamental power relative to 2nd harmonic)
let Fund_Rejection_dB = Pout_1f_dBm - Pout_2f_dBm
print Fund_Rejection_dB

quit
.endc
.end