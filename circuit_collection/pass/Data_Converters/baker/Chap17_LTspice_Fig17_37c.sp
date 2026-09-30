* Delta-Sigma Modulator Sensing Circuit Testbench (Baker Fig. 17.36)
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
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Transistor size parameters (scaled for SKY130 0.15u min length)
.param W_xm1=1.5  L_xm1=0.15
.param W_xm2=1.5  L_xm2=0.15
.param W_xm3=7.5  L_xm3=1.5
.param W_xm4=1.5  L_xm4=0.15
.param W_xm5=1.5  L_xm5=0.15
.param W_xm6=1.5  L_xm6=0.15
.param W_xm7=1.5  L_xm7=1.5
.param W_xm8=1.5  L_xm8=0.15
.param W_xm9=1.5  L_xm9=0.15
.param W_xm10=1.5 L_xm10=0.15
.param W_xm11=7.5 L_xm11=1.5
.param W_xm12=1.5 L_xm12=1.5
.param W_xm13=75.0  L_xm13=1.5
.param W_xm14=75.0  L_xm14=1.5
.param W_xm15=3.0 L_xm15=0.15
.param W_xm16=3.0 L_xm16=0.15
.param W_xm17=3.0 L_xm17=0.15
.param W_xm18=3.0 L_xm18=0.15
.param W_xm19=3.0 L_xm19=0.15
.param W_xm20=3.0 L_xm20=0.15
.param W_xm21=1.5 L_xm21=0.15
.param W_xm22=1.5 L_xm22=0.15
.param W_xm23=1.5 L_xm23=0.15
.param W_xm24=1.5 L_xm24=0.15

* Supply and Input DC Voltages
VDD VDD 0 1.8
Vr Vr 0 650m
Vi Vi 0 500m

* Two-phase non-overlapping clock (100 MHz, T=10ns)
* phi1: high from 0.5ns to 4.5ns
Vphi1 phi1 0 PULSE(0 1.8 0.5n 0.1n 0.1n 4.0n 10n)
* phi2: high from 5.5ns to 9.5ns
Vphi2 phi2 0 PULSE(0 1.8 5.5n 0.1n 0.1n 4.0n 10n)

* Circuit under test (from prompt)
xm3 VDD N005 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm5 N006 phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm7 vbuck vbucki VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm1 N005 phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N004 phi1 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm4 N003 phi1 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm6 N002 VDD N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm8 N001 Q N003 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 vbuck Vi N002 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 vbucki Vr N001 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 VDD N006 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 vbucki vbucki VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 0 vbuck 0 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm14 0 vbucki 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 n1 vbuck VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
xm16 n2 vbucki VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
xm17 n3 Out n1 VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
xm18 n4 Outi n2 VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
xm19 Outi phi2 n3 VDD sky130_fd_pr__pfet_01v8 w={W_xm19} l={L_xm19}
xm20 Out phi2 n4 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
xm21 Out Outi 0 0 sky130_fd_pr__nfet_01v8 w={W_xm21} l={L_xm21}
xm22 Outi Out 0 0 sky130_fd_pr__nfet_01v8 w={W_xm22} l={L_xm22}
xm23 Outi phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 Out phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
X_U1 Out Qi Q VDD 0 NOR_2
X_U2 Q Outi Qi VDD 0 NOR_2

.subckt NOR_2 A B Out VDD GND
  xm3 out B N001 VDD sky130_fd_pr__pfet_01v8 w=3.0 l=0.15
  xm8 N001 A VDD VDD sky130_fd_pr__pfet_01v8 w=3.0 l=0.15
  xm11 out B GND 0 sky130_fd_pr__nfet_01v8 w=1.5 l=0.15
  xm12 out A 0 0 sky130_fd_pr__nfet_01v8 w=1.5 l=0.15
.ends NOR_2

* Initial condition to avoid metastability at t=0
.ic v(vbuck)=1.2 v(vbucki)=1.2 v(Q)=0 v(Qi)=1.8

.control
tran 0.1n 1500n uic

* Average bucket capacitor voltages during measurement window (500ns to 1500ns)
meas tran vbuck_avg avg v(vbuck) from=500n to=1500n
meas tran vbucki_avg avg v(vbucki) from=500n to=1500n

* Average duty cycle of Q (feedback active ratio M/N)
meas tran q_avg avg v(Q) from=500n to=1500n
let feedback_ratio = q_avg / 1.8
print feedback_ratio

* Average power during measurement window
meas tran i_vdd_avg avg i(VDD) from=500n to=1500n
let p_avg = -i_vdd_avg * 1.8
print p_avg

* Modulator reconstruction
let v_thn = 0.42
let vr_shift = 0.65 - v_thn
let vi_shift_sensed = vr_shift * feedback_ratio
let resolution = vr_shift / 100
print vr_shift vi_shift_sensed resolution

quit
.endc
.end