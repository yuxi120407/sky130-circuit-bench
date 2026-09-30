* Testbench for Differential Delay Cell
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
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM1 OUTp INn NTAIL GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUTn INp NTAIL GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 VN2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 NTAIL VN1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUTn VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUTn OUTn VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 OUTp VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 OUTp OUTp VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

VVDD VDD 0 1.8
VVN2 VN2 0 0.9
VVN1 VN1 0 1.3
VVBP VBP 0 0.99

VINp INp 0 DC 0.9 AC 0.5 0 SIN(0.9 0.1 400MEG 0 0 0)
VINn INn 0 DC 0.9 AC 0.5 180 SIN(0.9 0.1 400MEG 0 0 180)

C1 OUTp 0 10f
C2 OUTn 0 10f

.control
  op
  let power = -i(VVDD) * 1.8
  print power
  
  ac dec 100 1MEG 100G
  let out_diff = v(OUTp) - v(OUTn)
  let gain_mag = mag(out_diff)
  let gain_db = 20*log10(gain_mag)
  
  meas ac max_gain MAX gain_db
  let gain_3db = max_gain - 3
  meas ac bandwidth WHEN gain_db=gain_3db FALL=1
  print max_gain bandwidth
  
  tran 10p 10n
  let in_diff = v(INp) - v(INn)
  let out_diff_tran = v(OUTp) - v(OUTn)
  meas tran diff_max MAX out_diff_tran
  meas tran diff_min MIN out_diff_tran
  let diff_swing = diff_max - diff_min
  print diff_swing
  
  meas tran delay_rise TRIG in_diff VAL=0 RISE=1 TD=1n TARG out_diff_tran VAL=0 RISE=1 TD=1n
  meas tran delay_fall TRIG in_diff VAL=0 FALL=1 TD=1n TARG out_diff_tran VAL=0 FALL=1 TD=1n
  let prop_delay = (delay_rise + delay_fall) / 2
  print prop_delay
  
  quit
.endc
.end