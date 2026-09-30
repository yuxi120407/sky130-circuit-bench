* VCO Sub-circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
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
.param W_xm10=5.0 L_xm10=0.5

VVDD VDD 0 1.8
VREP V_REPLICA 0 0.9
VRST RST 0 pulse(0 1.8 1n 0.1n 0.1n 5n 10n)
VIN VI_PLUS 0 pulse(0 1.8 2n 0.1n 0.1n 5n 10n)

XM1 N0 V_REPLICA GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD N0 VDD GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD RST N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VO_MINUS VI_PLUS VDD GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VDD VO_MINUS VDD GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 V_REPLICA GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VDD VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 VO_MINUS VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 VO_MINUS VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Loads to prevent floating nodes and simulation errors
R_VO VO_MINUS 0 1G
C_VO VO_MINUS 0 1f
C_N0 N0 0 1f

.control
  op
  let power = -i(VVDD) * 1.8
  print power

  tran 0.1n 20n
  meas tran n0_reset max v(N0)
  meas tran n0_active min v(N0)
  meas tran vo_max max v(VO_MINUS)
  quit
.endc
.end