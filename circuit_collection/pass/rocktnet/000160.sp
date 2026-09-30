* Testbench for CMOS Transconductance Amplifier

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5 W_xm1=5.0
.param L_xm2=0.5 W_xm2=5.0
.param L_xm3=0.5 W_xm3=5.0
.param L_xm4=0.5 W_xm4=5.0
.param L_xm5=0.5 W_xm5=5.0
.param L_xm6=0.5 W_xm6=5.0
.param L_xm7=0.5 W_xm7=5.0
.param L_xm8=0.5 W_xm8=5.0
.param L_xm9=0.5 W_xm9=5.0
.param L_xm10=0.5 W_xm10=5.0
.param L_xm11=0.5 W_xm11=5.0

* DUT
XM1 N_OUT VIP N_TAIL1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_MIRROR VREF N_TAIL1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_MIRROR VREF N_TAIL2 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N_OUT VIN N_TAIL2 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_MIRROR N_MIRROR VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N_MIRROR N_MIRROR VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N_OUT N_MIRROR VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N_OUT VCMFB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 VB VB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N_TAIL1 VB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N_TAIL2 VB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

* Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
VVREF VREF 0 0.9
VVIN VIN 0 DC 0.9 SIN(0.9 0.5 10 0 0)
VVIP VIP 0 DC 0.9 AC 1 180
VVCMFB VCMFB 0 0.9
VVB VB 0 0.99

* Load Capacitance (180pF as reported in paper)
C_load N_OUT 0 180p

* Ideal DC CMFB to stabilize output operating point
VREF_CMFB N_REF_CMFB 0 0.9
E_err N_err 0 N_OUT N_REF_CMFB 1
R_cmfb N_err N_err_f 1G
C_cmfb N_err_f 0 1
G_cmfb N_OUT 0 N_err_f 0 1m

.control
  * AC Analysis
  ac dec 20 0.1 100MEG
  
  meas ac dc_gain max vdb(N_OUT)
  let gain3db = dc_gain - 3
  meas ac f3db when vdb(N_OUT)=gain3db fall=1
  meas ac gbw when vdb(N_OUT)=0 fall=1
  
  let phase_deg = 180/3.141592653589793 * vp(N_OUT)
  meas ac phase_at_gbw find phase_deg when vdb(N_OUT)=0 fall=1
  let phase_margin = phase_at_gbw + 180
  
  * Transient Analysis (large signal to measure swing and power)
  tran 100u 200m
  meas tran vout_max max v(N_OUT) from=100m to=200m
  meas tran vout_min min v(N_OUT) from=100m to=200m
  let output_swing = vout_max - vout_min
  meas tran current_avg avg i(VVDD) from=100m to=200m
  let power_consumption = -current_avg * 1.8
  
  print dc_gain gbw phase_margin power_consumption vout_max vout_min output_swing
  quit
.endc
.end