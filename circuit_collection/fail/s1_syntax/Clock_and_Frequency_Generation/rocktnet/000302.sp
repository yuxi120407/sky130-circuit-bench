* VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.model npn_model npn (is=1e-16 bf=100)
.model d_model D (is=1e-14)

Vvdd N0 0 1.8
Vtune LABEL_NET_0 0 0.9 trnoise(1m 10p 0 0)

* DUT with added default values for R and C to allow compilation
D1 N3 N0 d_model
R1 N6 N12 1k
R2 N1 N4 1k
D2 N9 N13 d_model
R3 N14 0 1k
R4 N6 N8 1k
R5 N5 0 1k
R6 N6 N7 1k
R7 N15 0 1k
Q1 N2 N2 N11 npn_model
Q2 N4 N2 N10 npn_model
D3 N7 N9 d_model
R8 N14 0 1k
R9 N6 0 1k
R10 N11 N13 1k
R11 N10 N13 1k
R12 N0 N15 1k
R13 N0 N13 1k
R14 N3 N4 1k
R15 N3 LABEL_NET_0 1k
R16 N1 N6 1k
R17 N2 0 1k
C1 N5 0 1p
Q3 N5 N12 N6 npn_model
Q4 N14 N8 LABEL_NET_0 npn_model
C2 N14 0 1p
D4 N1 N0 d_model
R18 N14 0 1k

.control
op
let power_consumption = -i(Vvdd)*1.8
print power_consumption

tran 10p 2u
meas tran v_max max v(N5)
meas tran v_min min v(N5)
let voltage_swing = v_max - v_min
print voltage_swing

linearize v(N5)
fft v(N5)
let v_mag = mag(v(N5))
meas sp f_carrier max_at v_mag from=1Meg to=40G
meas sp pwr_carrier max v_mag from=1Meg to=40G
let oscillation_frequency = f_carrier
print oscillation_frequency

let f_offset = f_carrier + 1e6
meas sp pwr_noise find v_mag at="$&f_offset"
let RBW = 1 / 2e-6
let phase_noise = 20 * log10((pwr_noise + 1e-20) / (pwr_carrier + 1e-20)) - 10 * log10(RBW)
print phase_noise

alter Vtune 0
tran 10p 2u
linearize v(N5)
fft v(N5)
let v_mag_0 = mag(v(N5))
meas sp f_0 max_at v_mag_0 from=1Meg to=40G

alter Vtune 1.8
tran 10p 2u
linearize v(N5)
fft v(N5)
let v_mag_18 = mag(v(N5))
meas sp f_18 max_at v_mag_18 from=1Meg to=40G

let tuning_range = abs(f_18 - f_0) / (f_0 + 1e-9) * 100
print tuning_range

quit
.endc
.end