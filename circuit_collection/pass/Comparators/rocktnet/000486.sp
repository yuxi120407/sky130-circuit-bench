* Dynamic Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
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
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5

XM1 N3 VREFP N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 VREFN N5 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 COMPBD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N2 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 VINP N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N3 VINN N0 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N2 N4 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N4 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N4 COMPB N2 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}

VVDD VDD 0 1.8
VBIAS BIAS 0 0.6
VVREFP VREFP 0 0.9
VVREFN VREFN 0 0.9

* Clocks: 10MHz, 40ns reset (1.8V), 60ns eval (0V)
VCOMPB COMPB 0 PULSE(1.8 0 40n 100p 100p 59.8n 100n)
VCOMPBD COMPBD 0 PULSE(1.8 0 40n 100p 100p 59.8n 100n)

* Inputs: DC for AC analysis, PWL for Transient
VVINP VINP 0 DC 0.9 AC 0.5 PWL(0 0.9 1n 0.95 90n 0.95 91n 0.85 190n 0.85 191n 0.905 300n 0.905)
VVINN VINN 0 DC 0.9 AC -0.5 PWL(0 0.9 1n 0.85 90n 0.85 91n 0.95 190n 0.95 191n 0.895 300n 0.895)

C1 N2 0 10f
C2 N4 0 10f

.control
  * AC Analysis for Pre-amp
  ac dec 10 1Meg 1Gig
  let gain_db = 20 * log10(mag(v(n1) - v(n3)))
  meas ac preamp_gain_db find gain_db at=1Meg
  
  * Transient Analysis
  tran 100p 300n
  
  * Delay measurements
  meas tran delay_rise trig v(compb) val=0.9 fall=1 targ v(n2) val=1.6 rise=1
  meas tran delay_fall trig v(compb) val=0.9 fall=2 targ v(n2) val=0.2 fall=1
  
  * Power measurement
  meas tran avg_current avg i(VVDD) from=0 to=300n
  let avg_power = -avg_current * 1.8
  print avg_power
  
  * Functionality checks (Cycle 1: VINP > VINN -> N2 High, N4 Low)
  meas tran v_n2_c1 find v(n2) at=80n
  meas tran v_n4_c1 find v(n4) at=80n
  
  * Functionality checks (Cycle 2: VINP < VINN -> N2 Low, N4 High)
  meas tran v_n2_c2 find v(n2) at=180n
  meas tran v_n4_c2 find v(n4) at=180n
  
  quit
.endc
.end
