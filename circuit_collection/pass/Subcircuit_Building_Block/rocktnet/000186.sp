* Bias Generator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM2 VREF IBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 IBIAS IBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM10 VBIAS2 VBIAS3 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM3 VBIAS3 IBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM12 VBIAS1 VBIAS3 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM4 VBIAS2 IBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VBIAS1 VBIAS1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM9 N7 VBIAS2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM11 N1 VBIAS2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM7 VREF VREF VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 VBIAS3 VBIAS3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

VVDD VDD 0 DC 1.8 AC 1
Iin VDD IBIAS DC 50u

C1 VREF 0 10f
C2 VBIAS1 0 10f
C3 VBIAS2 0 10f
C4 VBIAS3 0 10f

.control
  op
  let power = -i(VVDD) * 1.8
  print power
  let v_vref = v(VREF)
  let v_vbias1 = v(VBIAS1)
  let v_vbias2 = v(VBIAS2)
  let v_vbias3 = v(VBIAS3)
  print v_vref v_vbias1 v_vbias2 v_vbias3

  ac dec 10 1 1G
  meas ac psrr_vref find vdb(VREF) at=1k
  meas ac psrr_vbias1 find vdb(VBIAS1) at=1k
  meas ac psrr_vbias2 find vdb(VBIAS2) at=1k
  meas ac psrr_vbias3 find vdb(VBIAS3) at=1k
  
  quit
.endc
.end
