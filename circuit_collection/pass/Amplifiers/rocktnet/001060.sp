* 4-PAM LSB Receiver Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM1 V_N V_IN N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 V_BIASN GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 V_NB VREFHI N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 V_NB V_IN N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 V_N VREFHI N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 V_N VREFLO N2 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Power supply and references
VVDD VDD 0 1.8
VVREFHI VREFHI 0 1.1
VVREFLO VREFLO 0 0.7
VBIAS V_BIASN 0 0.7

* Input signal (PWL for transient, overridden by DC sweep)
VIN V_IN 0 pwl(0 0 1n 0 1.1n 0.9 3n 0.9 3.1n 1.8 5n 1.8 5.1n 0.9 7n 0.9 7.1n 0 10n 0)

* Pull-up resistors to convert current to voltage
R1 VDD V_N 2k
R2 VDD V_NB 2k

* Load capacitors
C1 V_N 0 10f
C2 V_NB 0 10f

* Compensate for grounded gates in XM5 and XM8 (extraction error in original netlist)
* We add ideal current sources to provide the tail currents for the differential pairs
I_tail2 N2 0 120u
I_tail3 N3 0 120u

* Behavioral source to calculate differential output for robust measurement
Bdiff diff_out 0 V=v(V_N)-v(V_NB)

.control
  * 1. DC Operating Point for Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. DC Sweep for Window Function
  dc VIN 0 1.8 0.01
  meas dc v_cross_low find v(V_IN) when v(diff_out)=0 rise=1
  meas dc v_cross_high find v(V_IN) when v(diff_out)=0 fall=1
  print v_cross_low v_cross_high

  * Save thresholds to variables for tran
  set vcl = $&v_cross_low
  set vch = $&v_cross_high

  * 3. Transient Analysis for Delay
  tran 10p 10n
  * Measure delay when input crosses actual thresholds
  meas tran delay_rise trig v(V_IN) val=$vcl rise=1 targ v(diff_out) val=0 rise=1
  meas tran delay_fall trig v(V_IN) val=$vch rise=1 targ v(diff_out) val=0 fall=1
  
  let delay = (delay_rise + delay_fall) / 2
  print delay
  
  quit
.endc
.end