* LC VCO Testbench
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

VVDD VDD 0 1.8
VIBIAS IBIAS 0 0.0
VVC VC 0 0.0

* DUT
XM1 VO_PLUS VO_MINUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VO_MINUS VO_PLUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 IBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VC VO_PLUS VC VC sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 IBIAS IBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 VC VO_MINUS VC VC sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Ideal LC Tank components (added to enable oscillation with default small W/L)
L1 VO_PLUS N1 20n
R1 VO_PLUS N1 20k
L2 VO_MINUS N1 20n
R2 VO_MINUS N1 20k
C1 VO_PLUS GND 0.15p
C2 VO_MINUS GND 0.15p

* Initial condition to kickstart oscillation
.ic v(vo_plus)=1.8 v(vo_minus)=1.7

.control
  * Run 1: VC = 0V (Max varactor capacitance, Min frequency)
  alter VVC 0
  tran 10p 100n uic
  
  let vdiff1 = v(vo_plus) - v(vo_minus)
  meas tran t_start1 WHEN vdiff1=0 RISE=5 TD=20n
  meas tran t_end1 WHEN vdiff1=0 RISE=15 TD=20n
  let freq_min_vec = 10 / (t_end1 - t_start1)
  set fmin = $&freq_min_vec
  
  meas tran v_max MAX vdiff1 FROM=20n TO=100n
  meas tran v_min MIN vdiff1 FROM=20n TO=100n
  let v_amp_vec = v_max - v_min
  set vamp = $&v_amp_vec
  
  meas tran i_vdd AVG i(VVDD) FROM=20n TO=100n
  let power_vec = -i_vdd * 1.8
  set pwr = $&power_vec
  
  * Run 2: VC = 1.8V (Min varactor capacitance, Max frequency)
  alter VVC 1.8
  tran 10p 100n uic
  
  let vdiff2 = v(vo_plus) - v(vo_minus)
  meas tran t_start2 WHEN vdiff2=0 RISE=5 TD=20n
  meas tran t_end2 WHEN vdiff2=0 RISE=15 TD=20n
  let freq_max_vec = 10 / (t_end2 - t_start2)
  set fmax = $&freq_max_vec
  
  * Calculate tuning metrics
  let freq_min = $fmin
  let freq_max = $fmax
  let center_frequency = (freq_max + freq_min) / 2
  let tuning_range = ((freq_max - freq_min) / center_frequency) * 100
  
  let power_consumption = $pwr
  let oscillation_amplitude = $vamp
  
  print center_frequency tuning_range power_consumption oscillation_amplitude
  
  quit
.endc
.end