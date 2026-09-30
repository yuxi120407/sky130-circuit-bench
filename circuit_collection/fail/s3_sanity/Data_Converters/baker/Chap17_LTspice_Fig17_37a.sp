* DSM Sensing Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

V1 v_r_shift 0 1.0
V2 v_i_shift 0 0.8
V3 v_hold 0 0.5
V4 m_count 0 pulse(0 1.8 0 1n 1n 10n 20n)
Vdd vdd 0 1.8

.control
  tran 1n 100n
  
  meas tran V_R_shift avg v(v_r_shift)
  meas tran V_I_shift avg v(v_i_shift)
  
  meas tran M_count_integ integ v(m_count)
  let M_count = M_count_integ / 19.8e-9
  let V_res = (V_R_shift - V_I_shift) / M_count
  
  print V_R_shift
  print V_I_shift
  print M_count
  print V_res
  
  noise v(v_hold) V3 dec 10 1 10G
  setplot noise1
  let thermal_noise_rms = sqrt(integ(onoise_spectrum))
  print thermal_noise_rms
.endc
.end