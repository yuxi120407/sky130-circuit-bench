* Testbench for ALU gate fragment
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 OUT B STACK_NODE BODY_B sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM3 OUT A GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT B GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Voltage sources
Vdd STACK_NODE 0 DC 1.8
Vbody BODY_B 0 DC 1.8
Va A 0 DC 0
Vb B 0 PULSE(1.8 0 100p 20p 20p 400p 1n)
Cload OUT 0 10f

.control
  * Transient analysis for delay
  tran 1p 2n
  meas tran t_pLH trig v(B) val=0.9 fall=1 targ v(OUT) val=0.9 rise=1
  meas tran t_pHL trig v(B) val=0.9 rise=1 targ v(OUT) val=0.9 fall=1

  * DC analysis for switching threshold
  dc Vb 0 1.8 0.01
  meas dc V_th_switch when v(OUT)=0.9 fall=1
  
  quit
.endc
.end