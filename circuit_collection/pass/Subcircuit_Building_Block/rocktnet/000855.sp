* Continuous-Time CMFB Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm7a=0.5
.param L_xm7b=0.5
.param L_xm7c=0.5
.param L_xm7d=0.5
.param L_xm8_l=0.5
.param L_xm8_r=0.5
.param L_xm9_l=0.5
.param L_xm9_r=0.5

.param W_xm7a=5.0 L_xm7a=0.5
.param W_xm7b=5.0 L_xm7b=0.5
.param W_xm7c=5.0 L_xm7c=0.5
.param W_xm7d=5.0 L_xm7d=0.5
.param W_xm8_l=5.0 L_xm8_l=0.5
.param W_xm8_r=5.0 L_xm8_r=0.5
.param W_xm9_l=5.0 L_xm9_l=0.5
.param W_xm9_r=5.0 L_xm9_r=0.5

* DUT
XM7A TO_CMFB_MINUS VOUT_MINUS N3 VSS sky130_fd_pr__nfet_01v8 l={L_xm7a} w={W_xm7a}
XM7B TO_CMFB_PLUS VOUT_MINUS N3 VSS sky130_fd_pr__nfet_01v8 l={L_xm7b} w={W_xm7b}
XM7C TO_CMFB_MINUS VOUT_PLUS N1 VSS sky130_fd_pr__nfet_01v8 l={L_xm7c} w={W_xm7c}
XM7D TO_CMFB_PLUS VOUT_PLUS N1 VSS sky130_fd_pr__nfet_01v8 l={L_xm7d} w={W_xm7d}
XM8_L TO_CMFB_MINUS VBP1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8_l} w={W_xm8_l}
XM8_R TO_CMFB_PLUS VBP1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8_r} w={W_xm8_r}
XM9_L N3 VBN2 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm9_l} w={W_xm9_l}
XM9_R N1 VBN2 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm9_r} w={W_xm9_r}

* DC Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
VVBN2 VBN2 0 1.2

* Bias network for VBP1 to set output DC level
E_bias VBP1_ideal 0 vol='0.9 + 100*(v(TO_CMFB_PLUS) - 0.9)'
R_bias VBP1_ideal VBP1 1G
C_bias VBP1 0 1

* Input Signals (Common-Mode and Differential-Mode)
VCM_ac VCM_node 0 dc 0.9 ac 1 pulse(0.9 1.0 1n 1n 1n 50n 100n)
VDM_ac VDM_node 0 dc 0 ac 0

* Voltage-controlled voltage sources to generate VOUT_PLUS and VOUT_MINUS
E1 VOUT_PLUS 0 vol='v(VCM_node) + 0.5*v(VDM_node)'
E2 VOUT_MINUS 0 vol='v(VCM_node) - 0.5*v(VDM_node)'

* Load Capacitance (simulating the main amplifier's bias node)
Cload1 TO_CMFB_PLUS 0 150f
Cload2 TO_CMFB_MINUS 0 150f

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power
  print v(TO_CMFB_PLUS) v(TO_CMFB_MINUS)

  * Common-Mode AC Analysis
  ac dec 20 1 1G
  let cm_gain = vdb(TO_CMFB_PLUS)
  meas ac cm_gain_1k find cm_gain at=1k
  let cm_gain_3db = cm_gain_1k - 3
  meas ac cm_bw when cm_gain=cm_gain_3db fall=1

  * Differential-Mode AC Analysis
  alter VCM_ac ac=0
  alter VDM_ac ac=1
  ac dec 20 1 1G
  let dm_gain = vdb(TO_CMFB_PLUS)
  meas ac dm_gain_1k find dm_gain at=1k

  * Transient Analysis (Common-Mode Step Response)
  tran 0.1n 100n
  meas tran v_out_max max v(TO_CMFB_PLUS)
  meas tran v_out_min min v(TO_CMFB_PLUS)
  
  quit
.endc
.end