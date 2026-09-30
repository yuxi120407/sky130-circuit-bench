* Wide-swing cascode testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.subckt SUB_1 vbias1 vbias2 vbias3 vbias4 VDD VSS
R1 VDD vbias1 20k
XM1 vbias1 vbias1 vbias2 VSS sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM2 vbias2 vbias2 VSS VSS sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
R2 vbias4 VSS 20k
XM3 vbias4 vbias4 vbias3 VDD sky130_fd_pr__pfet_01v8 w=10.0 l=0.15
XM4 vbias3 vbias3 VDD VDD sky130_fd_pr__pfet_01v8 w=10.0 l=0.15
.ends

X1 vbias1 vbias2 vbias3 vbias4 VDD_bias 0 SUB_1
Vref VDD VDD_bias 0

XM5 vout_n vbias1 n1 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM6 n1 vbias2 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15

XM7 vout_p vbias4 n2 VDD sky130_fd_pr__pfet_01v8 w=10.0 l=0.15
XM8 n2 vbias3 VDD VDD sky130_fd_pr__pfet_01v8 w=10.0 l=0.15

VDD VDD 0 1.8
Vout_n vout_n 0 0.9
Vout_p vout_p 0 0.9

.control
  set temp = 27
  dc Vout_n 0 1.8 0.01
  
  let i_out = -i(Vout_n)
  let g_out = deriv(i_out)
  let r_out = 1 / g_out
  
  meas dc output_resistance find r_out at=0.9
  print output_resistance
  
  meas dc i_nom find i_out at=0.9
  let i_target_val = 0.95 * i_nom
  set i_target_str = $&i_target_val
  meas dc minimum_output_voltage when i_out=$i_target_str
  print minimum_output_voltage
  
  let iref_total = abs(i(Vref))
  meas dc reference_current find iref_total at=0.9
  print reference_current
  
  set ref_curr_str = $&reference_current
  
  set temp = 77
  dc Vout_n 0 1.8 0.01
  let iref_total_high = abs(i(Vref))
  meas dc iref_77 find iref_total_high at=0.9
  
  let ref_curr_num = $ref_curr_str
  let temperature_coefficient = (iref_77 - ref_curr_num) / (ref_curr_num * 50)
  print temperature_coefficient
.endc

.end