* DAC Current Source Array Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
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
.param W_xm11=5.0 L_xm11=0.5

XM1 N9 N3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N10 N11 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N11 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N10 N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N7 N1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N10 N1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N6 N7 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N8 N3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 N3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 N13 LABEL_NET_0 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N7 N7 N13 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

VLABEL_NET_0 LABEL_NET_0 0 0.9
Vdd7 N7 0 1.8
Vdd3 N3 0 1.8
Vgnd0 N0 0 0
Vgnd5 N5 0 0
Vbias1 N1 0 1.0
Vbias11 N11 0 1.0
Vout N10 0 1.0

.control
  * 1. Measure total current with all branches ON
  op
  let i_total = -i(Vout)
  let v_cal_bias = v(n13)
  let power_total = (-i(Vdd7) - i(Vdd3)) * 1.8
  
  * 2. Measure MSB total current (Main + Calibration)
  alter Vbias11 0.0
  op
  let i_msb_total = -i(Vout)
  
  * 3. Measure LSB current
  alter Vbias1 0.0
  alter Vbias11 1.0
  op
  let i_lsb = -i(Vout)
  
  * 4. Separate MSB Main and Calibration currents
  * Turn off calibration by raising its source voltage above bias
  alter Vbias1 1.0
  alter Vbias11 0.0
  alter VLABEL_NET_0 1.8
  op
  let i_msb_main = -i(Vout)
  let i_cal = i_msb_total - i_msb_main
  
  print i_total i_msb_total i_lsb i_msb_main i_cal v_cal_bias power_total
  
  * Restore nominal voltages for DC sweep
  alter VLABEL_NET_0 0.9
  alter Vbias1 1.0
  alter Vbias11 1.0
  
  * 5. DC sweep to measure Output Impedance (Rout)
  dc Vout 0.5 1.5 0.01
  let i_out = -i(Vout)
  let g_out = deriv(i_out)
  meas dc g_out_val find g_out at=1.0
  let rout = 1 / g_out_val
  print rout
  
  quit
.endc
.end