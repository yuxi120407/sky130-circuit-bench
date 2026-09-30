* Bootstrapped Switch Driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 N3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_2 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VDD LABEL_NET_3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

VVDD VDD 0 1.8
VGND N2 0 0
VN3 N3 0 1.8

* Inputs: IN and IN_bar
VIN LABEL_NET_1 0 DC 0.9 SIN(0.9 0.9 1Meg 0 0 0) AC 1
VIN_BAR LABEL_NET_2 0 DC 0.9 SIN(0.9 0.9 1Meg 0 0 180) AC 0
VPRE LABEL_NET_3 0 DC 0.9 SIN(0.9 0.9 1Meg 0 0 180) AC 0

Cload N1 0 10f

.control
* 1. Transient Analysis
tran 1n 9.999u
meas tran propagation_delay trig v(LABEL_NET_1) val=0.9 rise=2 targ v(N1) val=0.9 rise=2
meas tran v_max max v(N1)
meas tran v_min min v(N1)
meas tran pwr_avg avg i(VVDD) from=0 to=9.999u
meas tran total_power param='-pwr_avg * 1.8'

meas tran v_n1_rms rms v(N1)
meas tran v_n1_dc avg v(N1)
meas tran total_ac_pwr param='v_n1_rms * v_n1_rms - v_n1_dc * v_n1_dc'

* 2. FFT for SNDR
linearize v(N1)
set specwindow = rectangular
fft v(N1)
let mag_v = mag(v(N1))
let fund_mag = mag_v[10]
let fund_pwr = 0.5 * fund_mag * fund_mag
let noise_dist_pwr = abs($&total_ac_pwr - fund_pwr) + 1e-20
let peak_sndr_val = 10 * log10(fund_pwr / noise_dist_pwr)
meas tran peak_sndr param='peak_sndr_val'

* 3. AC Analysis for Bandwidth
ac dec 10 1k 100Gig
let v_mag = mag(v(N1))
meas ac max_gain max v_mag
let bw_thresh = max_gain / 1.4142
meas ac signal_bandwidth when v_mag=bw_thresh fall=1

* 4. Noise Analysis for SNR and Dynamic Range
noise v(N1) VIN dec 10 1k 100Gig
let noise_sq = onoise_spectrum * onoise_spectrum
meas noise total_noise_sq integ noise_sq
let peak_snr_val = 10 * log10(0.405 / (total_noise_sq + 1e-20))
meas tran peak_snr param='peak_snr_val'
meas tran dynamic_range param='peak_snr_val'

print propagation_delay v_max v_min total_power dynamic_range peak_snr peak_sndr signal_bandwidth
quit
.endc
.end