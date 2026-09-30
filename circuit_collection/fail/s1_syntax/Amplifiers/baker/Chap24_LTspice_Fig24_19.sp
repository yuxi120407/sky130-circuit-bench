* Testbench for Op-Amp Chap24_LTspice_Fig24_19
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Power Supplies
Vdd vdd 0 dc 1.8
Vss vss 0 dc 0

* Switches for Testbench Configuration (Fixing S1 syntax for NgSPICE)
.model sw_mod sw vt=0.5 vh=0.1 ron=1 roff=1G
S1 vout vinn switch_ctrl 0 sw_mod
S2 ac_node vinn switch_ac 0 sw_mod

* Switch Controls
Vctrl switch_ctrl 0 dc 0
Vac_ctrl switch_ac 0 dc 1

* Stimuli
C1 ac_in ac_node 1T
Vac ac_in 0 dc 0 ac 1
Vinp vinp 0 dc 0.9 ac 0 pulse(0.4 1.4 10n 1n 1n 40n 100n)
Cload vout 0 1p

.control
  * 1. AC Analysis (Open-Loop via Closed-Loop to fix floating gate DC bias)
  alter Vctrl dc = 1
  alter Vac_ctrl dc = 0
  alter Vac ac = 0
  alter Vinp ac = 1
  ac dec 10 1 1G
  set p_ac1 = $curplot
  
  let Ad = v(vout) / (v(vinp) - v(vinn))
  let gain_db = db(Ad)
  let phase = ph(Ad) * 180 / pi
  
  meas ac open_loop_gain find gain_db at=1
  meas ac unity_gain_frequency when gain_db=0
  
  meas ac dc_phase find phase at=1
  let target_phase_p2_val = dc_phase - 135
  meas ac second_pole when phase=$&target_phase_p2_val fall=1
  meas ac lhp_zero when phase=$&target_phase_p2_val rise=1
  
  * 2. CMRR (via dual-driven vinn in closed-loop)
  alter Vctrl dc = 1
  alter Vac_ctrl dc = 1
  alter Vac ac = 1
  alter Vinp ac = 1
  ac dec 10 1 1G
  set p_ac2 = $curplot
  
  let Vd = v(vinp) - v(vinn)
  let Vcm = (v(vinp) + v(vinn)) / 2
  let Ad_prev = {$p_ac1}.Ad
  let Acm = (v(vout) - Ad_prev * Vd) / Vcm
  let cmrr_vec = Ad_prev / Acm
  let cmrr_db = db(cmrr_vec)
  meas ac adm_cmrr_dc find cmrr_db at=1
  
  * 3. PSRR+ (via closed-loop)
  alter Vctrl dc = 1
  alter Vac_ctrl dc = 0
  alter Vac ac = 0
  alter Vinp ac = 0
  alter Vdd ac = 1
  ac dec 10 1 1G
  set p_ac3 = $curplot
  
  let Vd3 = v(vinp) - v(vinn)
  let Ad_prev3 = {$p_ac1}.Ad
  let A_psrr = (v(vout) - Ad_prev3 * Vd3) / v(vdd)
  let psrr_vec = Ad_prev3 / A_psrr
  let psrr_db = db(psrr_vec)
  meas ac adm_psrr_dc find psrr_db at=1
  
  * 4. Transient (Slew Rate)
  alter Vctrl dc = 1
  alter Vac_ctrl dc = 0
  alter Vdd ac = 0
  alter Vinp ac = 0
  tran 0.1n 100n
  set p_tran = $curplot
  
  let dvout = deriv(v(vout))
  meas tran slew_rate_max max dvout
  
  * Calculate final metrics
  let unity_gain_frequency = {$p_ac1}.unity_gain_frequency
  let open_loop_gain = {$p_ac1}.open_loop_gain
  let lhp_zero = {$p_ac1}.lhp_zero
  let second_pole = {$p_ac1}.second_pole
  let cmrr = {$p_ac2}.adm_cmrr_dc
  let psrr_plus = {$p_ac3}.adm_psrr_dc
  let slew_rate = {$p_tran}.slew_rate_max / 1e6
  
  print unity_gain_frequency open_loop_gain lhp_zero second_pole cmrr psrr_plus slew_rate
.endc
.end