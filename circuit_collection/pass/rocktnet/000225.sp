* Duty Cycle Detector Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmn1=0.5
.param L_xmn2=0.5
.param L_xmns=0.5
.param L_xmp1=0.5
.param L_xmp2=0.5
.param L_xmps=0.5

.param W_xmn1=5.0 L_xmn1=0.5
.param W_xmp2=5.0 L_xmp2=0.5
.param W_xmn2=5.0 L_xmn2=0.5
.param W_xmp1=5.0 L_xmp1=0.5
.param W_xmns=5.0 L_xmns=0.5
.param W_xmps=5.0 L_xmps=0.5

* DUT
XMN1 B PULSE2 GND GND sky130_fd_pr__nfet_01v8 l={L_xmn1} w={W_xmn1}
XMP2 VCTRL VQP A VDD sky130_fd_pr__pfet_01v8 l={L_xmp2} w={W_xmp2}
XMN2 VCTRL VQN B GND sky130_fd_pr__nfet_01v8 l={L_xmn2} w={W_xmn2}
XMP1 A PULSE1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp1} w={W_xmp1}
XMNS A PULSE1 GND GND sky130_fd_pr__nfet_01v8 l={L_xmns} w={W_xmns}
XMPS B PULSE2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmps} w={W_xmps}

* Supplies and Biases
VVDD VDD 0 1.8
VVQP VQP 0 0.9
VVQN VQN 0 0.6

* Inputs (400MHz, 50% duty cycle)
VPULSE1 PULSE1 0 dc 0 pulse(0 1.8 0 100p 100p 1.15n 2.5n)
VPULSE2 PULSE2 0 dc 0 pulse(0 1.8 0 100p 100p 1.15n 2.5n)

* Output Load and Forcing Network
R_VCTRL VCTRL VCTRL_FORCE 1m
VVCTRL VCTRL_FORCE 0 0.9
C_VCTRL VCTRL 0 1p

.ic v(VCTRL)=0.9

.control
  * 1. DC Analysis for I_up (Inputs = 0V)
  alter @VPULSE1[dc] = 0
  alter @VPULSE2[dc] = 0
  dc VVCTRL 0 1.8 0.01
  let i_up = i(VVCTRL)
  meas dc i_up_900m find i_up at=0.9
  print i_up_900m
  
  * 2. DC Analysis for I_down (Inputs = 1.8V)
  alter @VPULSE1[dc] = 1.8
  alter @VPULSE2[dc] = 1.8
  dc VVCTRL 0 1.8 0.01
  let i_down = -i(VVCTRL)
  meas dc i_down_900m find i_down at=0.9
  print i_down_900m
  
  * 3. Transient Analysis (400MHz operation)
  alter @VPULSE1[dc] = 0
  alter @VPULSE2[dc] = 0
  alter R_VCTRL 1e12
  tran 10p 20n uic
  meas tran vctrl_min min v(VCTRL) from=10n to=20n
  meas tran vctrl_max max v(VCTRL) from=10n to=20n
  let vctrl_ripple = vctrl_max - vctrl_min
  print vctrl_ripple
  
  quit
.endc
.end