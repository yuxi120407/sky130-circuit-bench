* PTAT Reference Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param mc_mm_switch=1
.param mc_pr_switch=1

.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5

* DUT
XM1 N6 N4 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N1 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N6 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 N3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 N2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 N4 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 LABEL_NET_2 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N2 N5 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

* Sources
VVDD VDD 0 0.9 ac 1
VLABEL_NET_0 LABEL_NET_0 VDD 0
VLABEL_NET_1 LABEL_NET_1 VDD 0
VLABEL_NET_2 LABEL_NET_2 0 0.45
Vfix_N7 N7 N6 0
Vfix_N1 N1 N3 0

* Startup Nodeset
.nodeset v(N0)=0.1 v(N1)=0.4 v(N2)=0.4 v(N3)=0.4 v(N4)=0.4 v(N5)=0.4 v(N6)=0.4 v(N7)=0.4

.control
  * DC Operating Point & Power
  op
  let power_consumption = -(i(VVDD)*0.9 + i(VLABEL_NET_2)*0.45)
  print power_consumption
  let i_dc_val = abs(i(VLABEL_NET_2))
  print i_dc_val
  set i_dc_set = $&i_dc_val

  * AC Analysis for PSRR
  ac dec 10 1 1G
  let psrr_db = 20 * log10( $i_dc_set / (mag(i(VLABEL_NET_2)) + 1e-15) )
  meas ac psrr find psrr_db at=100
  print psrr

  * DC Sweep for PTAT behavior
  dc temp -40 125 5
  let i_out_temp = abs(i(VLABEL_NET_2))
  meas dc i_out_m40 find i_out_temp at=-40
  meas dc i_out_125 find i_out_temp at=125
  let ptat_slope = ($&i_out_125 - $&i_out_m40) / 165
  print ptat_slope

  * Monte Carlo for current_std_dev
  setplot const
  let iout_mc = vector(30)
  set mc_run = 1
  
  dowhile $mc_run <= 30
    reset
    op
    let run_idx = $mc_run - 1
    let const.iout_mc[$&run_idx] = abs(i(VLABEL_NET_2))
    let next_run = $mc_run + 1
    set mc_run = $&next_run
  end
  
  setplot const
  let iout_mean = mean(iout_mc)
  let iout_diff = iout_mc - iout_mean
  let iout_diff_sq = iout_diff * iout_diff
  let iout_var = mean(iout_diff_sq)
  let iout_std = sqrt(iout_var)
  let current_std_dev = (iout_std / iout_mean) * 100
  print current_std_dev

  quit
.endc
.end