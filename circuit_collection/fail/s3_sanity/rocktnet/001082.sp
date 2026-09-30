* 900-MHz CMOS LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm2b=0.5
.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm2b=5.0

* DUT
XM1 N5 N2 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2B VDD VDD N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2b} w={W_xm2b}
XM2 RFOUT VDD N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Biasing and Supply
VVDD VDD 0 1.8
VBIAS N_BIAS 0 1.2
RBIAS N_BIAS N2 10k

* Dummy current source to prevent floating node N1
I_dummy N1 0 10u

* Source degeneration inductor
LS N6 0 1nH

* Load tank (10nH and 3pF -> ~918 MHz)
LD VDD RFOUT 10nH
CL RFOUT 0 3pF
RL RFOUT VDD 500

* RF Input with 50-ohm source
VAC IN_SRC 0 dc 0 ac 1
RS IN_SRC IN 50
CIN IN N2 10pF

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac dec 100 100MEG 5G
let gain_db = vdb(RFOUT) - vdb(IN)
meas ac voltage_gain MAX gain_db
let target_gain = $&voltage_gain - 0.001
meas ac center_frequency WHEN gain_db=$&target_gain FALL=1

let I_in = (v(IN_SRC) - v(IN))/50
let Zin = v(IN) / I_in
let S11 = (Zin - 50) / (Zin + 50)
let S11_mag = mag(S11)
let S11_db = 20 * log10(S11_mag)
meas ac input_return_loss FIND S11_db AT=$&center_frequency

noise v(RFOUT) VAC dec 100 100MEG 5G
setplot noise1
let NF_vec = 10 * log10( (inoise_spectrum^2) / 8.288e-19 )
meas noise noise_figure FIND NF_vec AT=$&center_frequency

print voltage_gain
print center_frequency
print input_return_loss
print noise_figure
.endc
.end