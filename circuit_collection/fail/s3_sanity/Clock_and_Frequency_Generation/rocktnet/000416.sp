* Subpicosecond Jitter PLL VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xm10=5.0

XM1 TUNEP OUTQ TUNEP VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT OUTQ N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT OUTQ VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 TUNEP OUT TUNEP VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 BIAS BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUTQ OUT N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 OUTQ OUT VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 TUNEN OUTQ TUNEN VSS sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 TUNEN OUT TUNEN VSS sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Power and Bias Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
Ibias BIAS VSS 200u
VTUNEP TUNEP 0 0.9
VTUNEN TUNEN 0 0.9

* Tank Inductor and Capacitor (added to enable oscillation)
L1 OUT OUTQ 5n
C1 OUT OUTQ 100f

* AC source for noise analysis
Iac OUT OUTQ dc 0 ac 1

* VCVS to create a single-ended differential voltage node for easy measurement
E1 VDIFF 0 OUT OUTQ 1

* Kickstart current pulse to initiate oscillation without breaking DC operating point
Ikick OUT OUTQ PWL(0 0 100p 1m 200p 0)

.control
  tran 10p 50n
  
  * Measure oscillation frequency
  meas tran t1 trig v(VDIFF) val=0 rise=20 targ v(VDIFF) val=0 rise=30
  let oscillation_frequency = 10 / t1
  print oscillation_frequency
  
  * Measure power consumption
  meas tran pwr_avg avg i(VVDD) from=30n to=50n
  let power_consumption = -pwr_avg * 1.8
  print power_consumption
  
  * Measure output voltage swing (differential peak-to-peak)
  meas tran vmax max v(VDIFF) from=30n to=50n
  meas tran vmin min v(VDIFF) from=30n to=50n
  let voltage_swing = vmax - vmin
  print voltage_swing
  
  * Measure phase noise
  let f_noise = oscillation_frequency + 1Meg
  noise v(VDIFF) Iac lin 1 $&f_noise $&f_noise
  setplot noise1
  let onoise_v = onoise_spectrum[0]
  let vswing = tran1.voltage_swing
  let carrier_amp = vswing / 2
  let carrier_pwr = (carrier_amp * carrier_amp) / 2
  let phase_noise = 10 * log10((onoise_v * onoise_v) / carrier_pwr)
  print phase_noise
  
  quit
.endc
.end