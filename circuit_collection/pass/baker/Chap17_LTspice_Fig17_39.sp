* Delta-Sigma Modulator Imager Sensor Testbench (Baker Fig. 17.36)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_bucket=0.5
.param L_cm=0.5
.param L_cup=0.5
.param L_n=0.5
.param L_p=0.5
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

* W/L parameter definitions matching Fig. 17.36 scaled for SKY130
.param Lmin=0.15u
.param W_cup=2.5    L_cup=0.5
.param W_bucket=25.0  L_bucket=0.5
.param W_cm=1.0     L_cm=1.0
.param W_p=2.0      L_p=0.15
.param W_n=1.0      L_n=0.15

* Transistor sizes mapped from Fig. 17.36
.param W_xm1={W_n}       L_xm1={L_n}
.param W_xm2={W_n}       L_xm2={L_n}
.param W_xm3={W_cup}     L_xm3={L_cup}
.param W_xm4={W_n}       L_xm4={L_n}
.param W_xm5={W_n}       L_xm5={L_n}
.param W_xm6={W_n}       L_xm6={L_n}
.param W_xm7={W_cm}      L_xm7={L_cm}
.param W_xm8={W_n}       L_xm8={L_n}
.param W_xm9={W_n}       L_xm9={L_n}
.param W_xm10={W_n}      L_xm10={L_n}
.param W_xm11={W_cup}    L_xm11={L_cup}
.param W_xm12={W_cm}     L_xm12={L_cm}
.param W_xm13={W_bucket} L_xm13={L_bucket}
.param W_xm14={W_bucket} L_xm14={L_bucket}
.param W_xm15={W_p}      L_xm15={L_p}
.param W_xm16={W_p}      L_xm16={L_p}
.param W_xm17={W_p}      L_xm17={L_p}
.param W_xm18={W_p}      L_xm18={L_p}
.param W_xm19={W_p}      L_xm19={L_p}
.param W_xm20={W_p}      L_xm20={L_p}
.param W_xm21={W_n}      L_xm21={L_n}
.param W_xm22={W_n}      L_xm22={L_n}
.param W_xm23={W_n}      L_xm23={L_n}
.param W_xm24={W_n}      L_xm24={L_n}

* DUT Instance Netlist
VDD VDD 0 1.8
xm3 VDD N006 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm5 N007 phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm7 vbuck vbucki VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
Vr Vr 0 650m
Vi N001 0 640m
xm1 N006 phi2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N005 phi1 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm4 N004 phi1 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm6 N003 VDD N005 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm8 N002 Q N004 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 vbuck Vi N003 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 vbucki Vr N002 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 VDD N007 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
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
Vos N001 Vi 20m

.subckt NOR_2 A B Out VDD GND
  xm3 out B N001 VDD sky130_fd_pr__pfet_01v8 w=2.0 l=0.15
  xm8 N001 A VDD VDD sky130_fd_pr__pfet_01v8 w=2.0 l=0.15
  xm11 out B GND 0 sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
  xm12 out A 0 0 sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
.ends NOR_2

* Non-overlapping two-phase clocks (T = 10 ns, 100 MHz)
Vphi1 phi1 0 PULSE(0 1.8 1.0n 0.1n 0.1n 3.0n 10.0n)
Vphi2 phi2 0 PULSE(0 1.8 6.0n 0.1n 0.1n 3.0n 10.0n)

* Transient Analysis matching Baker's simulation window
.tran 0.1n 1500n uic

.control
run

* Measure shifted reference and input voltage levels
let v_thn = 0.42
let vr_val = v(vr)
let vi_val = v(vi)
let vr_shift = vr_val - v_thn
let vi_shift = vi_val - v_thn
let n_samples = 100
let v_resolution = vr_shift / n_samples

print vr_shift vi_shift v_resolution

* Measure bucket voltages and latch outputs at equilibrium
meas tran vbuck_avg avg v(vbuck) from=500n to=1500n
meas tran vbucki_avg avg v(vbucki) from=500n to=1500n
meas tran q_max max v(Q) from=500n to=1500n
meas tran qi_max max v(Qi) from=500n to=1500n

* Print final measurement results
print vbuck_avg vbucki_avg
quit
.endc
.end