* Testbench for Harmonic Sampler / Mixer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0

XM1 VDD LABEL_NET_0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD LABEL_NET_1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VDD LABEL_NET_2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VDD LABEL_NET_3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 VDD N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* DC and AC Sources
VVDD VDD 0 1.8
* RF Input at 2GHz
VLABEL_NET_0 LABEL_NET_0 0 dc 0.9 sin(0.9 0.1 2G)
VLABEL_NET_1 LABEL_NET_1 0 dc 0.9
VLABEL_NET_2 LABEL_NET_2 0 dc 0.9
VLABEL_NET_3 LABEL_NET_3 0 dc 0.9
* Baseband/LO Input at 1.8GHz
VN3 N3 0 dc 0.9 sin(0.9 0.9 1.8G)

* Load resistors to provide DC path and simulate next stage
R1 N1 0 100k
R2 N0 0 100k
R3 N2 0 100k

.control
* 1. Transient Analysis
tran 10p 100n

* Measure operating frequency from RF input
meas tran t_rf1 WHEN v(LABEL_NET_0)=0.9 rise=2
meas tran t_rf2 WHEN v(LABEL_NET_0)=0.9 rise=3
let operating_frequency = 1 / (t_rf2 - t_rf1)
print operating_frequency

* Measure baseband frequency from LO input
meas tran t_lo1 WHEN v(N3)=0.9 rise=2
meas tran t_lo2 WHEN v(N3)=0.9 rise=3
let baseband_frequency = 1 / (t_lo2 - t_lo1)
print baseband_frequency

* Measure supply voltage
meas tran supply_voltage avg v(VDD)
print supply_voltage

* Measure DC power
meas tran avg_Ivdd avg i(VVDD)
let P_dc = -avg_Ivdd * 1.8

* FFT for IF component
linearize v(N2)
set specwindow = rectangular
fft v(N2)
let mag_vN2 = mag(v(N2))
* IF is at 200MHz (2GHz - 1.8GHz)
meas ac v_if_val max mag_vN2 from=190Meg to=210Meg

* Calculate metrics using scalars
let if_amp = 2 * v_if_val
let gain = 20 * log10((if_amp / 0.1) + 1e-20)
print gain

let P_out = (if_amp * if_amp / 2) / 100000
let output_power = 10 * log10(P_out * 1000 + 1e-20)
print output_power

let efficiency = (P_out / (P_dc + 1e-20)) * 100
print efficiency

* 2. DC Sweep for Compression Voltage
alter VN3 dc = 1.8
dc VLABEL_NET_0 0.9 1.8 0.01
let diff_vout = deriv(v(N2))
meas dc max_diff MAX diff_vout
let comp_level = max_diff * 0.89125
meas dc comp_v1 WHEN diff_vout=$&comp_level fall=1
let compression_voltage = comp_v1 - 0.9
print compression_voltage

quit
.endc
.end