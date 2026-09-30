* CMOS Voltage Reference Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm5=5.0 L_xm5=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5

XM5 V1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM2 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 VDD V1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM4 VDD GND GND VDD sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8

.control
  op
  let Vref = v(V1)
  let Power = -i(VVDD) * 1.8
  print Vref Power

  * Temperature Sweep for TC
  dc temp -40 125 1
  meas dc vref_max MAX v(V1)
  meas dc vref_min MIN v(V1)
  meas dc vref_27 FIND v(V1) AT=27
  let TC = (vref_max - vref_min) / (vref_27 + 1e-15) / 165 * 1e6
  print TC

  * VDD Sweep for Line Regulation
  dc VVDD 1.2 1.8 0.01
  meas dc vref_18 FIND v(V1) AT=1.8
  meas dc vref_12 FIND v(V1) AT=1.2
  let Line_Regulation = (vref_18 - vref_12) / 0.6
  print Line_Regulation
.endc
.end