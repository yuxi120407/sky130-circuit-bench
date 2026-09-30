* Replica Bias Circuit Testbench

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

* DUT
XM1 GND GND N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND VCTRL N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 GND VCO_SUPPLY VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 GND N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 GND N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 GND GND N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 GND ADAPTIVE_SUPPLY VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 GND VDD N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Voltage Sources
VVDD VDD 0 1.8
VVCTRL VCTRL 0 0.9
VVCO VCO_SUPPLY 0 1.8
VADAPT ADAPTIVE_SUPPLY 0 pwl(0 0 1n 0 1.1n 1.8)

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.control
  * 1. DC Operating Point
  op
  let I_VCO_SUPPLY = -i(VVCO)
  let V_N1_DC = v(N1)
  let V_N0_DC = v(N0)
  print I_VCO_SUPPLY V_N1_DC V_N0_DC

  * 2. Transient Analysis for Step Response
  tran 10p 20n
  meas tran t_delay_N2 trig v(ADAPTIVE_SUPPLY) val=0.9 rise=1 targ v(N2) val=1.0 rise=1
  print t_delay_N2

  quit
.endc
.end