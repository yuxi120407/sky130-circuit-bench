* Testbench for Figure 17.33 CMOS Imager DSM Sensing Circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameter definitions for DUT MOSFET sizing
.param W_xm1=2.0  L_xm1=0.18
.param W_xm2=2.0  L_xm2=0.18
.param W_xm3=2.0  L_xm3=0.18
.param W_xm4=2.0  L_xm4=0.18
.param W_xm5=1.0  L_xm5=0.5
.param W_xm6=1.0  L_xm6=0.5
.param W_xm7=2.0  L_xm7=0.18
.param W_xm8=2.0  L_xm8=0.18
.param W_xm9=2.0  L_xm9=0.18
.param W_xm10=2.0 L_xm10=0.18
.param W_xm11=1.0 L_xm11=0.18
.param W_xm12=1.0 L_xm12=0.18

* --- DUT Netlist from prompt ---
VDD VDD 0 1.8
xm3 N002 phi1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm1 N004 phi2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 N006 Out N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
C1 N002 0 1e-13
xm4 vbucket VI N006 N006 sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
X_U1 vbucket vd4r Out Outi clock VDD 0 SUB_1
xm5 vbucket vd4r 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
C2 vbucket 0 5e-13
xm6 vd4r vd4r 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 N001 phi1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 N003 phi2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N005 0 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
C3 N001 0 1e-13
xm10 vd4r VR N005 N005 sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
Vblack Vblack 0 650m
Vinten Vinten 0 400m
Chr VR 0 1e-12
xm11 VR shr Vblack 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
Chi VI 0 1e-12
xm12 VI shi Vinten 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}

.subckt SUB_1 inp inm q qi clock VDD GND
  xm1 N003 inp GND 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 Outm Outp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
  xm3 Outp Outm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm5 N002 Outm N004 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm6 N001 Outp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm4 Outm clock VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm7 Outp clock VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8 Outm clock N001 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm9 Outp clock N002 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
  xm10 N004 inm 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
  X_U1 Outp q qi VDD 0 NAND_2
  X_U2 qi Outm q VDD 0 NAND_2
.ends SUB_1

.subckt NAND_2 A B Out VDD GND
  xm3 out B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm8 out A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm11 N001 B GND 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 out A N001 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
.ends NAND_2

* --- Control Signal Generation ---
* Initial sample and hold pulses (active high for first 20 ns)
Vshr shr 0 PULSE(1.8 0 0 0.1n 0.1n 20n 2000n)
Vshi shi 0 PULSE(1.8 0 0 0.1n 0.1n 20n 2000n)

* Non-overlapping clock phases for PMOS switched-capacitor network (active low)
* Period T = 10 ns (100 MHz)
* phi1 active (low) from 1 ns to 4 ns
Vphi1 phi1 0 PULSE(1.8 0 1.0n 0.1n 0.1n 3.0n 10n)
* phi2 active (low) from 5.5 ns to 8.5 ns
Vphi2 phi2 0 PULSE(1.8 0 5.5n 0.1n 0.1n 3.0n 10n)

* Clocked comparator strobe (active high evaluate from 8.8 ns to 9.8 ns)
Vclock clock 0 PULSE(0 1.8 8.8n 0.1n 0.1n 1.0n 10n)

.control
  tran 0.1n 1500n uic

  * Sampled reference and intensity voltages
  meas tran vr_sampled find v(VR) at=50n
  meas tran vi_sampled find v(VI) at=50n

  * Average voltages on bucket capacitor and mirror diode during sensing (500n to 1500n)
  meas tran vbucket_avg avg v(vbucket) from=500n to=1500n
  meas tran vd4r_avg avg v(vd4r) from=500n to=1500n

  * Average modulator output voltage to determine pulse density (M/N)
  meas tran out_avg avg v(Out) from=500n to=1500n

  * Calculate pulse density (fraction of clock cycles Out is high)
  let pulse_density = out_avg / 1.8
  print pulse_density

  * Reconstructed shifted intensity voltage VI,shift = VR,shift / (1 - M/N)
  let vr_shift_est = 1.8 - 0.42 - vr_sampled
  let vi_shift_sensed = vr_shift_est / (1.0 - pulse_density + 1e-9)
  print vr_shift_est vi_shift_sensed

  quit
.endc
.end
