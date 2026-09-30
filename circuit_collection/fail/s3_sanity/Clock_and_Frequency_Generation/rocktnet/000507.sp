* CMOS Self-Regulating VCO Testbench
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

XM1 B F GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 A E VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 C A VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 E C VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 F D E GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 D B D GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 B V_CTRL_BAR A VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 D E C VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 E V_CTRL_BAR E VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 A V_CTRL B GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

VVDD VDD 0 1.8
VCTRL V_CTRL 0 0.9
VCTRLB V_CTRL_BAR 0 0.9

* Initial conditions to kickstart oscillation
.ic v(A)=0 v(C)=1.8 v(E)=0 v(B)=0 v(D)=1.8 v(F)=0

.control
  setplot const
  let t1 = 0
  let t2 = -1
  let t3 = 0
  let t4 = -1
  let t5 = 0
  let t6 = -1

  * 1. Nominal Frequency and Power
  tran 10p 2u uic
  meas tran vmin MIN v(A) from=1u to=2u
  meas tran vmax MAX v(A) from=1u to=2u
  meas tran pwr_avg AVG i(VVDD) from=1u to=2u
  
  meas tran t1 WHEN v(A)=0.9 rise=5
  meas tran t2 WHEN v(A)=0.9 rise=15
  
  let vpp1 = vmax - vmin
  let period1 = t2 - t1
  let is_valid1 = (vpp1 > 0.5) * (period1 > 0)
  let osc_freq = is_valid1 * 10 / (period1 + 1e-20)
  let pwr = -1.8 * pwr_avg

  * 2. Supply Sensitivity (1% VDD increase)
  alter VVDD 1.818
  tran 10p 2u uic
  meas tran vmin2 MIN v(A) from=1u to=2u
  meas tran vmax2 MAX v(A) from=1u to=2u
  
  meas tran t3 WHEN v(A)=0.9 rise=5
  meas tran t4 WHEN v(A)=0.9 rise=15
  
  let vpp2 = vmax2 - vmin2
  let period2 = t4 - t3
  let is_valid2 = (vpp2 > 0.5) * (period2 > 0)
  let osc_freq2 = is_valid2 * 10 / (period2 + 1e-20)
  
  let sens = tran1.is_valid1 * ((osc_freq2 - tran1.osc_freq) / (tran1.osc_freq + 1e-20)) / 0.01

  * 3. Tuning Range (KVCO)
  alter VVDD 1.8
  alter VCTRL 1.2
  alter VCTRLB 0.6
  tran 10p 2u uic
  meas tran vmin3 MIN v(A) from=1u to=2u
  meas tran vmax3 MAX v(A) from=1u to=2u
  
  meas tran t5 WHEN v(A)=0.9 rise=5
  meas tran t6 WHEN v(A)=0.9 rise=15
  
  let vpp3 = vmax3 - vmin3
  let period3 = t6 - t5
  let is_valid3 = (vpp3 > 0.5) * (period3 > 0)
  let osc_freq3 = is_valid3 * 10 / (period3 + 1e-20)
  
  let kvco_val = tran1.is_valid1 * (osc_freq3 - tran1.osc_freq) / 0.3

  setplot const
  let oscillation_frequency = tran1.osc_freq
  let supply_sensitivity = tran2.sens
  let kvco = tran3.kvco_val
  let power_consumption = tran1.pwr
  let phase_noise = 0

  print oscillation_frequency supply_sensitivity kvco power_consumption phase_noise
  quit
.endc
.end