* Testbench for IF DCOC Loop
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_n=0.5
.param L_p=0.5

.param W_n=2.0 L_n=0.15
.param W_p=4.0 L_p=0.15

* Supplies and Bias
VVDD VDD 0 1.8
VPLUS V_PLUS 0 1.8
VMINUS V_MINUS 0 0
VREF_P Iref_p 0 1.0
VREF_N Iref_n 0 0.8
V_EN IF_enable 0 1.8

* Stimulus: AC current for impedance measurement, PWL for transient step
I_in 0 IF DC 0 AC 1 PWL(0 0 10n 0 11n 10u)

* DUT
T3 V_C Iref_n N11 GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
T11 IF N9 N8 GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
T6 N3 V_C GND GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
T8 N9 Iref_n N12 GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
T5 N3 Iref_p V_PLUS VDD sky130_fd_pr__pfet_01v8 w={W_p} l={L_p}
T12 N8 IF_enable V_MINUS GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
T7 N9 V_C GND VDD sky130_fd_pr__pfet_01v8 w={W_p} l={L_p}
T13 IF IF_enable V_PLUS VDD sky130_fd_pr__pfet_01v8 w={W_p} l={L_p}
T9 N12 IF_enable V_MINUS GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
T10 IF N3 V_PLUS VDD sky130_fd_pr__pfet_01v8 w={W_p} l={L_p}
T1 N13 IF V_PLUS VDD sky130_fd_pr__pfet_01v8 w={W_p} l={L_p}
T2 V_C Iref_p N13 VDD sky130_fd_pr__pfet_01v8 w={W_p} l={L_p}
T4 N11 IF V_MINUS GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
C1 V_C V_MINUS 10p

.control
  * DC Operating Point
  op
  let power = -i(VVDD)*1.8 - i(VPLUS)*1.8
  print power
  let if_dc = v(IF)
  print if_dc

  * AC Analysis for Impedance Profile
  ac dec 20 1k 100Meg
  let z_mag = vdb(IF)
  meas ac z_100k find z_mag at=100k
  meas ac z_10meg find z_mag at=10Meg

  * Transient Analysis for Settling
  tran 1n 2u
  meas tran v_peak max v(IF)
  meas tran v_steady find v(IF) at=1.9u
  
  quit
.endc
.end