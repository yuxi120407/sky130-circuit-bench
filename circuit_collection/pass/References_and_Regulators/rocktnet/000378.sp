* CMOS Voltage Reference Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameterized W/L
.param W_xm9=5.0 L_xm9=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm8=5.0 L_xm8=0.5

* DUT
XM9 VREF N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM4 N1 V3 N6 N6 sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM7 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM6 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM3 N0 V2 N6 N6 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM5 VDD N5 V2 V2 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM1 N5 N5 VDD N5 sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM8 N6 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Supplies and Biasing
VVDD VDD 0 1.8
* Close the op-amp feedback loop
V_V3 V3 VREF 0
* Bias currents to establish operating points for floating/unbiased nodes
I_N5 N5 0 1u
I_V2 V2 0 1u
I_tail N6 0 1u
I_load VREF 0 1u

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD)*1.8
  print power
  let vref_dc = v(VREF)
  print vref_dc

  * 2. Line Regulation (Sweep VDD)
  dc VVDD 1.6 2.0 0.01
  meas dc vref_16 find v(VREF) at=1.6
  meas dc vref_20 find v(VREF) at=2.0
  let line_reg = (vref_20 - vref_16) / 0.4
  print line_reg

  * 3. Temperature Coefficient (Sweep Temp)
  dc temp -40 85 1
  let vref_max = vecmax(v(VREF))
  let vref_min = vecmin(v(VREF))
  let temp_coeff = (vref_max - vref_min) / 125
  print temp_coeff

  quit
.endc
.end