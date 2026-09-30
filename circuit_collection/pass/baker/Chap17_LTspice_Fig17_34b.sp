* Testbench for Figure 17.33: DSM Sensing Circuit for CMOS Imaging Chips
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

* Parameter definitions for device sizes
.param W_xm1=3.6  L_xm1=0.18
.param W_xm2=3.6  L_xm2=0.18
.param W_xm3=3.6  L_xm3=0.18
.param W_xm4=3.6  L_xm4=0.18
.param W_xm5=1.8  L_xm5=1.8
.param W_xm6=1.8  L_xm6=1.8
.param W_xm7=3.6  L_xm7=0.18
.param W_xm8=3.6  L_xm8=0.18
.param W_xm9=3.6  L_xm9=0.18
.param W_xm10=3.6 L_xm10=0.18
.param W_xm11=1.8 L_xm11=0.18
.param W_xm12=1.8 L_xm12=0.18

* Power supplies and input DC levels
VDD VDD 0 DC 1.8
Vblack Vblack 0 DC 0.650
Vinten Vinten 0 DC 0.645

* Sampling clock pulses (sample reference and intensity during initial 40 ns)
V_shr shr 0 PULSE(1.8 0 40n 0.1n 0.1n 2000n 2500n)
V_shi shi 0 PULSE(1.8 0 40n 0.1n 0.1n 2000n 2500n)

* Non-overlapping switched-capacitor clocks (Period = 10 ns, 100 MHz)
* PMOS switches: active LOW
V_phi1 phi1 0 PULSE(1.8 0 50.5n 0.2n 0.2n 3.5n 10n)
V_phi2 phi2 0 PULSE(1.8 0 55.0n 0.2n 0.2n 3.5n 10n)

* Comparator clock (active HIGH evaluation at end of phi2 phase)
V_clock clock 0 PULSE(0 1.8 58.5n 0.2n 0.2n 1.5n 10n)

* Core DSM sensing circuit (from Figure 17.33)
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
Chr VR 0 1e-12
xm11 VR shr Vblack 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
Chi VI 0 1e-12
xm12 VI shi Vinten 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}

* Subcircuit: Clocked Comparator with NAND SR Latch
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

* Subcircuit: 2-input NAND Gate
.subckt NAND_2 A B Out VDD GND
  xm3 out B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm8 out A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm11 N001 B GND 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 out A N001 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
.ends NAND_2

.control
tran 0.1n 1500n uic

* Measure sampled voltages on hold capacitors
meas tran v_sample_vr find v(VR) at=45n
meas tran v_sample_vi find v(VI) at=45n

* Measure shifted voltages across switched-cap resistors
let v_thp_est = 0.42
let vr_shift = 1.8 - v_thp_est - v_sample_vr
let vi_shift = 1.8 - v_thp_est - v_sample_vi
print vr_shift vi_shift

* Measure bucket and mirror voltages during modulation
meas tran v_bucket_avg avg v(vbucket) from=500n to=1500n
meas tran v_d4r_avg avg v(vd4r) from=500n to=1500n

* Calculate switched capacitor resistance (100 MHz, 100 fF)
let f_clock = 100e6
let c_cup = 100e-15
let r_r = 1.0 / (f_clock * c_cup)
let i_r = vr_shift / r_r
print r_r i_r

* Sensed resolution for N=100 samples
let n_samples = 100
let v_resolution = vr_shift / n_samples
print v_resolution

* Plot critical waveforms as requested in Baker's book
* plot v(vd4r) v(vbucket) v(Out)

quit
.endc
.end
