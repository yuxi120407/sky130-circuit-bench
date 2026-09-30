* Testbench for Monotonic Digitally Controlled Delay Element
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameters
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm19=5.0 L_xm19=0.5

* DUT
XM1 VG N11 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 VG VG GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM13 OUT N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM4 VG VG N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N7 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N11 N11 N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N8 VG GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 VG GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N11 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 VG B N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N5 IN N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM3 N3 N11 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM14 OUT N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N5 IN N8 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N4 N11 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N10 N11 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm17} w={W_xm17}
XM18 VG A N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM19 VG D N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm19} w={W_xm19}

* Sources
VVDD VDD 0 1.8
VN11 N11 0 1.0
VIN IN 0 PULSE(0 1.8 1n 50p 50p 2n 4n)
VA A 0 DC 1.8
VB B 0 DC 1.8
VD D 0 DC 1.8

* Load
CL OUT 0 10f

.control
  * State 0: All OFF (Max Delay)
  alter @VA[dc] = 1.8
  alter @VB[dc] = 1.8
  alter @VD[dc] = 1.8
  op
  let power_min = -i(VVDD) * 1.8
  tran 10p 5n
  meas tran delay_max trig v(in) val=0.9 rise=1 targ v(out) val=0.9 rise=1

  * State 1: 1 ON (Mid Delay)
  alter @VD[dc] = 0
  tran 10p 5n
  meas tran delay_mid trig v(in) val=0.9 rise=1 targ v(out) val=0.9 rise=1

  * State 3: All ON (Min Delay)
  alter @VA[dc] = 0
  alter @VB[dc] = 0
  op
  let power_max = -i(VVDD) * 1.8
  tran 10p 5n
  meas tran delay_min trig v(in) val=0.9 rise=1 targ v(out) val=0.9 rise=1
  
  let delay_resolution = delay_max - delay_mid
  let tuning_range = (delay_max - delay_min) / delay_max * 100
  
  print delay_max delay_min delay_resolution power_min power_max tuning_range
  quit
.endc
.end
