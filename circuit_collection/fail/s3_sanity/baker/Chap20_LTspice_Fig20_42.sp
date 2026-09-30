* Regulated Cascode Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

VDD VDD 0 1.8
VOUT out_mir 0 1.8
V_out_ref out_ref 0 1.8

* Beta-multiplier reference
V_Iref VDD pbias_src 0
XM_BMR_P1 pbias pbias pbias_src VDD sky130_fd_pr__pfet_01v8 w=10.0 l=1.0
XM_BMR_P2 nbias pbias VDD VDD sky130_fd_pr__pfet_01v8 w=10.0 l=1.0
XM_BMR_N1 pbias nbias 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=1.0
XM_BMR_N2 nbias nbias S2 0 sky130_fd_pr__nfet_01v8 w=20.0 l=1.0
R_BMR S2 0 1k

* Main current mirror
XM_M1 d1 nbias 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=1.0
XM_M2 d2 nbias 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=1.0

* Cascode transistors
XM_C1 out_ref g_cas1 d1 0 sky130_fd_pr__nfet_01v8 w=5.0 l=1.0
XM_C2 out_mir g_cas2 d2 0 sky130_fd_pr__nfet_01v8 w=5.0 l=1.0

* Active feedback amplifiers (xma1-xma4)
xma1 g_cas1 d1 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=1.0
xma2 g_cas1 pbias VDD VDD sky130_fd_pr__pfet_01v8 w=10.0 l=1.0
xma3 g_cas2 d2 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=1.0
xma4 g_cas2 pbias VDD VDD sky130_fd_pr__pfet_01v8 w=10.0 l=1.0

* Startup circuit
B_startup VDD nbias I='max(0, 0.9 - v(nbias))*1m'

.nodeset v(pbias)=0.9 v(nbias)=0.9

.control
  * 1. Measure output resistance and minimum output voltage
  dc VOUT 0 1.8 0.01
  let i_out = -i(VOUT)
  let r_out = 1 / (abs(deriv(i_out)) + 1e-18)
  
  meas dc cascode_output_resistance find r_out at=1.0
  
  meas dc i_nom find i_out at=1.0
  let i_95 = i_nom * 0.95
  meas dc minimum_output_voltage when i_out=$&i_95
  
  print cascode_output_resistance
  print minimum_output_voltage
  
  * 2. Measure reference current tempco
  dc temp -40 125 1
  let i_ref = i(V_Iref)
  meas dc i_max max i_ref
  meas dc i_min min i_ref
  meas dc i_nom_temp find i_ref at=25
  let reference_current_tempco = ((i_max - i_min) / (i_nom_temp + 1e-18)) / 165 * 1e6
  
  print reference_current_tempco
.endc
.end