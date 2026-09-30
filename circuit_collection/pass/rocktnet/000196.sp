* Wide-Range Delay-Locked Loop Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
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

XM1 N4 VBN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VO_MINUS VI_PLUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD VDD N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 VBN GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VO_MINUS VO_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 VO_PLUS VI_MINUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VO_PLUS VO_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 VO_MINUS VO_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 VO_PLUS VO_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}

VVDD VDD 0 1.8
VVBN VBN 0 0.54

VIP VI_PLUS 0 DC 0.9 AC 0.5 PULSE(0.4 1.4 1n 100p 100p 2n 4n)
VIM VI_MINUS 0 DC 0.9 AC -0.5 PULSE(1.4 0.4 1n 100p 100p 2n 4n)

.control
  op
  let power = -i(VVDD) * 1.8
  print power
  
  ac dec 20 1k 10G
  meas ac dc_gain find vdb(vo_plus) at=1k
  meas ac gain_db_3db param='dc_gain - 3'
  meas ac bandwidth when vdb(vo_plus)=gain_db_3db fall=1
  print dc_gain bandwidth
  
  tran 10p 10n
  meas tran v_max max v(vo_plus)
  meas tran v_min min v(vo_plus)
  meas tran delay trig v(vi_plus) val=0.9 td=1n rise=1 targ v(vo_plus) val=0.9 td=1n rise=1
  print delay
  
  quit
.endc
.end