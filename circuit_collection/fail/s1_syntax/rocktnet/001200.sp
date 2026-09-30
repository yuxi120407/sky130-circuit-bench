* CMOS Bandgap Reference Without Resistors Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm5=5.0 L_xm5=0.5

XM1 VOUT VOUT N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM7 VD2 VD2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM2 GND VD2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM4 VD2 VD2 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM3 GND GND N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM5 VOUT VD2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

* Power supply with AC component for PSRR measurement
VVDD VDD 0 1.8 ac 1

* Connect N1 and N3 to VDD (acting as supply rails for the sub-circuit)
R1 VDD N1 0.001
R2 VDD N3 0.001

.control
  * 1. DC Operating Point (v_ref and power)
  op
  let power = -i(VVDD) * 1.8
  let v_ref = v(VOUT)
  print v_ref
  print power

  * 2. Temperature Sweep (0 C to 70 C)
  dc temp 0 70 1
  meas dc vout_max max v(VOUT)
  meas dc vout_min min v(VOUT)
  let temp_variation = vout_max - vout_min
  print temp_variation

  * 3. AC Analysis (PSRR)
  ac dec 10 1 1G
  let psrr_db = vdb(VOUT)
  meas ac psrr_100Hz find psrr_db at=100
  
  quit
.endc
.end