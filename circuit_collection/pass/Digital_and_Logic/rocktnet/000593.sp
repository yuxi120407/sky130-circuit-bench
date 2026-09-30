* NAND Gate Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N3 B GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT A N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT A VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VB B 0 DC 1.8
VA A 0 PULSE(0 1.8 1n 0.1n 0.1n 2n 4n)
Cload OUT 0 10f

.control
  * DC Analysis for Logic Threshold
  dc VA 0 1.8 0.01
  meas dc vth_logic when v(OUT)=0.9
  
  * Transient Analysis for Delay and Power
  tran 10p 8n
  meas tran tplh trig v(A) val=0.9 fall=1 targ v(OUT) val=0.9 rise=1
  meas tran tphl trig v(A) val=0.9 rise=1 targ v(OUT) val=0.9 fall=1
  meas tran trise trig v(OUT) val=0.36 rise=1 targ v(OUT) val=1.44 rise=1
  meas tran tfall trig v(OUT) val=1.44 fall=1 targ v(OUT) val=0.36 fall=1
  
  meas tran avg_current avg i(VVDD) from=0 to=8n
  print avg_current
  quit
.endc
.end