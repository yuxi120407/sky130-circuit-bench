* Replica Inverter Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm10=5.0 L_xm10=0.5

XM1 OUTB VDD N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUTB OUTB INB VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 EN GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUTB OUTB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM6 OUTB OUTB N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM10 OUTB OUT INB VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

VVDD VDD 0 1.8
VINB INB 0 0.9
VOUT OUT 0 0.9
VEN EN 0 pwl(0 0 1n 0 1.1n 1.8 10n 1.8)

.control
  * DC Analysis for bias voltages and power
  dc VEN 0 1.8 1.8
  meas dc v_outb_dis find v(OUTB) at=0
  meas dc v_outb_en find v(OUTB) at=1.8
  meas dc i_vdd_en find i(VVDD) at=1.8
  let power_en = -i_vdd_en * 1.8
  print v_outb_dis v_outb_en power_en

  * Transient Analysis for turn-on delay
  tran 10p 5n
  meas tran t_delay_fall trig v(EN) val=0.9 rise=1 targ v(OUTB) val=0.8 fall=1
  
  quit
.endc
.end