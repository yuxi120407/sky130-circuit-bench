* 20-GHz LNA with Active Balun Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic NPN model for simulation since SKY130 parasitic NPNs are too slow for 20GHz
.model npn NPN(IS=1e-16 BF=100 VAF=50 CJC=10f CJE=20f TF=5p)

* DUT (with added component values for simulation)
Q2 Vout_plus Vin N_EMIT npn
Q3 Vout_minus VIN2 N_EMIT npn
Ce2 N_EMIT GND 100f
Lc2 VDD Vout_plus 1n
Lc3 VDD Vout_minus 1n
V1 Vout_plus VOUT_P 0
Le2 N_EMIT GND 0.5n
V2 VOUT_N Vout_minus 0

* Load Capacitors
Cload1 VOUT_P GND 50f
Cload2 VOUT_N GND 50f

* Biasing and Sources
VVDD VDD 0 1.8
* Vin is the RF input, VIN2 is AC grounded for active balun operation
VVIN VIN 0 DC 0.8 AC 1
VVIN2 VIN2 0 DC 0.8 AC 0

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac lin 5000 10G 30G
let vout_diff = v(VOUT_P) - v(VOUT_N)
let gain_db = 20*log10(mag(vout_diff))
let amp_imb_db = 20*log10(mag(v(VOUT_P)) / mag(v(VOUT_N)))
let phase_diff = 180/3.141592653589793 * (ph(v(VOUT_P)) - ph(v(VOUT_N)))

meas ac voltage_gain MAX gain_db
let target_gain = voltage_gain - 1e-4
meas ac center_frequency WHEN gain_db=target_gain CROSS=LAST

meas ac amplitude_imbalance find amp_imb_db at=$&center_frequency
meas ac phase_difference find phase_diff at=$&center_frequency

noise v(VOUT_P, VOUT_N) VVIN lin 1000 10G 30G
setplot noise1
let k = 1.380649e-23
let T = 298.15
let Rs = 50
let nf_val = 10 * log10(1 + (inoise_spectrum * inoise_spectrum) / (4 * k * T * Rs))
meas noise noise_figure find nf_val at=$&center_frequency

print voltage_gain center_frequency amplitude_imbalance phase_difference noise_figure
quit
.endc
.end