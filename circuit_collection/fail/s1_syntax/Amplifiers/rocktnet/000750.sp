* Sinh Resistor Transconductor Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_n=0.5
.param L_p=0.5

.param W_p=2.0 L_p=1.0
.param W_n=2.0 L_n=1.0

* DUT (T replaced with M for standard SPICE, N3 mapped to VDD)
M3 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 W={W_p} L={L_p}
M6 N2 Vb GND GND sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
M4 Vout N1 VDD VDD sky130_fd_pr__pfet_01v8 W={W_p} L={L_p}
M5 Vout Vout N2 GND sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
M1 N1 V1 N2 GND sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
M2 N2 V2 N1 VDD sky130_fd_pr__pfet_01v8 W={W_p} L={L_p}

* Sources
VVDD VDD 0 1.8
VVB Vb 0 0.54

VCM VCM 0 DC 0.9 AC 0
Vdiff Vdiff 0 DC 0 AC 1

* E-sources for differential inputs (V1, V2)
E1 V1 VCM Vdiff 0 0.5
E2 V2 VCM Vdiff 0 -0.5

* Output load (force voltage to measure short-circuit current)
Vmeas Vout 0 0.9

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * DM AC Analysis
  alter Vdiff ac=1
  alter VCM ac=0
  ac dec 10 1 100Meg
  let adm = mag(i(Vmeas))
  meas ac gm_dm find adm at=10
  meas ac bw_3db when adm='gm_dm/1.414' fall=1

  * CM AC Analysis
  alter Vdiff ac=0
  alter VCM ac=1
  ac dec 10 1 100Meg
  let acm = mag(i(Vmeas))
  meas ac gm_cm find acm at=10

  * CMRR
  let cmrr_db = 20*log10(gm_dm / gm_cm)
  print cmrr_db

  * DC Sweep for Sinh characteristic
  alter Vdiff ac=0
  alter VCM ac=0
  dc Vdiff -0.5 0.5 0.01
  meas dc iout_max max i(Vmeas)
  meas dc iout_min min i(Vmeas)

  quit
.endc
.end
