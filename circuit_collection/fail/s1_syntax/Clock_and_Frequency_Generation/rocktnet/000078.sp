* VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM1 N0 N1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 N1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 N3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Biases and Supplies
VLABEL_NET_0 LABEL_NET_0 0 0.9
VDD VDD 0 1.8
Vtune N0 0 1.8 ac 1
Vtune_b N2 0 0

* Tail connections (Grounding the common sources)
Vtail1 N4 0 0
Vtail2 N5 0 0

* LC Tank (Added to enable oscillation)
L1 VDD N1 2n
L2 VDD N3 2n
R1 N1 VDD 250
R2 N3 VDD 250
C1 N1 N3 1.5p

* Initial conditions to kickstart oscillation
.ic v(N1)=1.8 v(N3)=1.7

.control
  * DC Analysis for Power
  op
  let power_consumption = -i(VDD) * 1.8
  print power_consumption

  * Transient Analysis for Oscillation
  tran 10p 20n
  
  * Measure amplitude
  meas tran vmax max v(N1) from=10n to=20n
  meas tran vmin min v(N1) from=10n to=20n
  let output_amplitude = vmax - vmin
  print output_amplitude

  * Measure frequency
  meas tran t_start trig v(N1) val=1.8 rise=1 from=10n
  meas tran t_end trig v(N1) val=1.8 rise=5 from=10n
  let period = (t_end - t_start)/4
  let oscillation_frequency = 1/period
  print oscillation_frequency
  
  * Tuning range
  alter Vtune = 0
  tran 10p 20n
  meas tran t_start2 trig v(N1) val=1.8 rise=1 from=10n
  meas tran t_end2 trig v(N1) val=1.8 rise=5 from=10n
  let period2 = (t_end2 - t_start2)/4
  let freq2 = 1/period2
  let tuning_range = abs(oscillation_frequency - freq2)
  print tuning_range

  * AC Analysis for Gain
  alter Vtune = 1.8
  ac dec 10 1Meg 10Gig
  let v1_db = db(v(N1))
  meas ac gain max v1_db
  print gain

  * Noise Analysis for Phase Noise
  noise v(N1, N3) Vtune dec 10 1Meg 100Meg
  setplot noise1
  meas noise phase_noise_val find onoise_spectrum at=3Meg
  let phase_noise = 10 * log10(phase_noise_val)
  print phase_noise

  quit
.endc
.end