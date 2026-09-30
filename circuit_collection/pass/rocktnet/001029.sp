* Charge Pump Testbench
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
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

VVDD VDD 0 1.8
IREF VDD N_BIAS 50u

XM1 CP_OUTPUT N_PMIRROR VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM3 N_PMIRROR N_PMIRROR VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM2 CP_OUTPUT N_BIAS N_SW2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM4 N_BIAS N_BIAS N_SRC1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_SRC1 VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM8 N_PMIRROR N_BIAS N_SW1 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM6 N_SW1 UP_BAR GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N_SW2 DOWN_BAR GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

VUP UP_BAR 0 0
VDOWN DOWN_BAR 0 0
VOUT CP_OUTPUT 0 0.9

.control
  * 1. UP Current and Compliance
  alter VUP 1.8
  alter VDOWN 0
  dc VOUT 0 1.8 0.01
  let i_up = i(VOUT)
  meas dc i_up_nom find i_up at=0.9
  let target_up = i_up_nom * 0.9
  meas dc v_comp_max when i_up = $&target_up fall=1
  
  * 2. DOWN Current and Compliance
  alter VUP 0
  alter VDOWN 1.8
  dc VOUT 0 1.8 0.01
  let i_down = -i(VOUT)
  meas dc i_down_nom find i_down at=0.9
  let target_down = i_down_nom * 0.9
  meas dc v_comp_min when i_down = $&target_down rise=1
  
  * 3. Leakage Current
  alter VUP 0
  alter VDOWN 0
  dc VOUT 0 1.8 0.01
  let i_leak = abs(i(VOUT))
  meas dc i_leak_nom find i_leak at=0.9
  
  * 4. Mismatch
  let mismatch = abs(dc1.i_up_nom - dc2.i_down_nom) / ((dc1.i_up_nom + dc2.i_down_nom)/2) * 100
  print dc1.i_up_nom dc2.i_down_nom dc3.i_leak_nom mismatch dc1.v_comp_max dc2.v_comp_min
  
  quit
.endc
.end