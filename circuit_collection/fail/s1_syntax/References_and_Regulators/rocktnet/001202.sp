* CMOS Bandgap Reference Without Resistors Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm26=0.5
.param L_xm27=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm7=0.5
.param L_xm71=0.5
.param L_xm72=0.5
.param L_xm81=0.5
.param L_xm82=0.5
.param L_xm83=0.5
.param L_xm84=0.5
.param L_xm85=0.5

.param W_xm71=5.0 L_xm71=0.5
.param W_xm82=5.0 L_xm82=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm85=5.0 L_xm85=0.5
.param W_xm83=5.0 L_xm83=0.5
.param W_xm27=5.0 L_xm27=0.5
.param W_xm26=5.0 L_xm26=0.5
.param W_xm84=5.0 L_xm84=0.5
.param W_xm23=5.0 L_xm23=0.5
.param W_xm24=5.0 L_xm24=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm72=5.0 L_xm72=0.5
.param W_xm81=5.0 L_xm81=0.5
.param W_xm22=5.0 L_xm22=0.5
.param W_xm1=5.0 L_xm1=0.5

VVDD VDD 0 1.8

* Nodeset to avoid zero-current state in self-biased circuits
.nodeset v(VD2)=0.9 v(VOUT)=1.1

XM71 VD2 VD2 VD2 GND sky130_fd_pr__nfet_01v8 l={L_xm71} w={W_xm71}
XM82 N7 N7 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm82} w={W_xm82}
XM7 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM4 N1 VD2 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM85 N7 N7 VD2 GND sky130_fd_pr__nfet_01v8 l={L_xm85} w={W_xm85}
XM83 N7 N7 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm83} w={W_xm83}
XM27 VD2 VD2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm27} w={W_xm27}
XM26 VD2 VD2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm26} w={W_xm26}
XM84 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm84} w={W_xm84}
XM23 N6 VD2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm23} w={W_xm23}
XM24 VD2 VD2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm24} w={W_xm24}
XM2 GND VD2 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM5 GND VOUT N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM3 GND VD1 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM72 VD2 VD2 VD1 GND sky130_fd_pr__nfet_01v8 l={L_xm72} w={W_xm72}
XM81 N4 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm81} w={W_xm81}
XM22 N3 VD2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm22} w={W_xm22}
XM1 VOUT VOUT N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}

.control
  * 1. Nominal Operating Point
  op
  let vref_nom = v(VOUT)
  let power_nom = -i(VVDD) * 1.8
  print vref_nom power_nom

  * 2. Temperature Sweep (0 to 70 C)
  dc temp 0 70 1
  meas dc vref_max max v(VOUT)
  meas dc vref_min min v(VOUT)
  let tc_vref = vref_max - vref_min
  print tc_vref

  * 3. Line Regulation (VDD Sweep 1.6V to 2.0V)
  dc VVDD 1.6 2.0 0.01
  meas dc vref_vdd_max max v(VOUT)
  meas dc vref_vdd_min min v(VOUT)
  let line_reg = (vref_vdd_max - vref_vdd_min) / (2.0 - 1.6)
  print line_reg

  quit
.endc
.end