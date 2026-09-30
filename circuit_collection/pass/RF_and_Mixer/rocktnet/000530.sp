* QFG Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmb=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xmb=5.0 L_xmb=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5

XM1 GND VCLKN VG GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT VG VIN GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 LABEL_NET_1 VG GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N0 VIN GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VIN N3 VIN GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XMB N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmb} w={W_xmb}
XM7 VG LABEL_NET_1 LABEL_NET_1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 GND GND GND sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 VG VCLK LABEL_NET_1 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

* DC Sources
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8

* LO Signals (10 MHz)
VCLK VCLK 0 PULSE(0 1.8 0 100p 100p 49.9n 100n)
VCLKN VCLKN 0 PULSE(1.8 0 0 100p 100p 49.9n 100n)

* RF Signal (1 MHz)
VVIN VIN 0 DC 0.4 SIN(0.4 0.1 1MEG 0 0)

* Load
CLOAD VOUT 0 1p
RLOAD VOUT 0 10k

* Prevent floating nodes for SPICE convergence
R_N0 N0 0 1G
R_N2 N2 0 1G

.control
  * DC Operating Point for Power
  op
  let power_consumption = abs(i(VVDD) + i(VLABEL_NET_1)) * 1.8
  print power_consumption

  * Transient Analysis for Conversion Gain
  * Coherent sampling: 16us window, 16384 points -> 0.9765625ns step
  * Start saving at 16us to avoid startup transients
  tran 0.9765625n 32u 16u
  
  * Linearize to get uniform time steps for FFT
  linearize v(vout) v(vin)
  
  * Perform FFT
  fft v(vout) v(vin)
  
  * Measure magnitudes at RF (1MHz) and IF (9MHz)
  let vout_mag = mag(v(vout))
  let vin_mag = mag(v(vin))
  
  meas sp vout_9mhz MAX vout_mag from=8.5MEG to=9.5MEG
  meas sp vin_1mhz MAX vin_mag from=0.5MEG to=1.5MEG
  
  * Calculate Conversion Gain in dB
  let conversion_gain = 20 * log10((vout_9mhz + 1e-20) / (vin_1mhz + 1e-20))
  print conversion_gain
  
  quit
.endc
.end