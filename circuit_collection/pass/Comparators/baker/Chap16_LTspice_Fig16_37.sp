* Testbench for Latched Sense Amplifier (Baker Fig 16.32 / 16.35 / 16.37)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=2.0 L_xm1=0.18
.param W_xm2=2.0 L_xm2=0.18
.param W_xm3=2.0 L_xm3=0.18
.param W_xm4=1.0 L_xm4=0.18
.param W_xm5=2.0 L_xm5=0.18
.param W_xm6=2.0 L_xm6=0.18
.param W_xm7=1.0 L_xm7=0.18
.param W_xm8=2.0 L_xm8=0.18
.param W_xm9=2.0 L_xm9=0.18
.param W_xm10=2.0 L_xm10=0.18
.param W_xm11=1.0 L_xm11=2.0
.param W_xm12=1.0 L_xm12=2.0
.param W_xm13=1.0 L_xm13=2.0
.param W_xm14=1.0 L_xm14=2.0

* DUT Netlist
xm1 N003 Inp 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 Outm Outp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Outp Outm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm5 N002 Outm N004 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N001 Outp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm4 Outm clock VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm7 Outp clock VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 Outm clock N001 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 Outp clock N002 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N004 Inm 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
X_U1 Outp Q Qi VDD 0 NAND_2
X_U2 Qi Outm Q VDD 0 NAND_2
xm11 Inp VDD VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 Inp VDD 0 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 Inm 0 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm13} l={L_xm13}
xm14 Inm 0 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}

.subckt NAND_2 A B Out VDD GND
  xm3 out B VDD VDD sky130_fd_pr__pfet_01v8 w=1.0 l=0.15
  xm8 out A VDD VDD sky130_fd_pr__pfet_01v8 w=1.0 l=0.15
  xm11 N001 B GND 0 sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
  xm12 out A N001 0 sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
.ends NAND_2

* Clock source: 10 ns period (100 MHz), 50% duty cycle
Vclk clock 0 PULSE(0 1.8 0 100p 100p 4.9n 10n)

.control
tran 10p 25n

* Kickback noise: measure disturbance on Inp/Inm around the 20ns clock edge
meas tran v_inp_base find v(Inp) at=19.5n
meas tran v_inp_min min v(Inp) from=19.8n to=21.0n
meas tran v_inp_max max v(Inp) from=19.8n to=21.0n
let kickback_inp = v_inp_max - v_inp_min
print kickback_inp

meas tran v_inm_base find v(Inm) at=19.5n
meas tran v_inm_min min v(Inm) from=19.8n to=21.0n
meas tran v_inm_max max v(Inm) from=19.8n to=21.0n
let kickback_inm = v_inm_max - v_inm_min
print kickback_inm

* Peak switching current from VDD
meas tran idd_peak max -i(VDD) from=19.0n to=21.0n
print idd_peak

* Output logic levels
meas tran v_q_val find v(Q) at=24.5n
meas tran v_qi_val find v(Qi) at=24.5n
print v_q_val v_qi_val

quit
.endc
.end