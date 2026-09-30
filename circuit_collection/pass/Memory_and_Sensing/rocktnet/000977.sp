* SRAM Cell Testbench
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

XM1 Q QB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 QB Q VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 QB Q GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 BLB QB PRED GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 Q QB GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 BLB 0 QB GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 BL 0 Q GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 1 1 BL GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 BL Q PREDB GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 1 1 BLB GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

VVDD VDD 0 1.8
V1 1 0 1.8

* Bitline capacitance
CBL BL 0 50f
CBLB BLB 0 50f

* Prediction lines (Read Wordlines)
* Idle at 1.8V, pulse low to read
VPRED PRED 0 1.8
VPREDB PREDB 0 PULSE(1.8 0 2n 0.1n 0.1n 2n 10n)

* Initialize SRAM cell state (Q=1, QB=0)
.ic v(Q)=1.8 v(QB)=0 v(BL)=1.2 v(BLB)=1.2

.control
  tran 10p 6n
  
  * Measure Read Delay on BL
  meas tran t_read trig v(PREDB) val=0.9 fall=1 targ v(BL) val=1.1 fall=1
  
  * Measure Bitline Swing
  meas tran bl_min min v(BL)
  
  * Measure Read Power
  meas tran i_vdd_avg avg i(VVDD) from=2n to=4n
  meas tran i_v1_avg avg i(V1) from=2n to=4n
  let read_power = -(i_vdd_avg + i_v1_avg) * 1.8
  print read_power
  
  * Measure Leakage Power
  meas tran i_vdd_leak avg i(VVDD) from=0.5n to=1.5n
  meas tran i_v1_leak avg i(V1) from=0.5n to=1.5n
  let leak_power = -(i_vdd_leak + i_v1_leak) * 1.8
  print leak_power
  
  quit
.endc
.end
