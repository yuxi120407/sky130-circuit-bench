* Testbench for Ramp Generator
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=20.0 L_xm2=0.5 $ Modified from 5u to 20u to enable beta-multiplier operation
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5

XM1 N5 VCTRL VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N3 N4 VSS sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N1 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 IOUT N1 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N3 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N6 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N1 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N9 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}

* Connect N4 and N5 to form the beta-multiplier source degeneration
Vshort N4 N5 0

* Power supplies
VVDD VDD 0 1.8
VVSS VSS 0 0
VVCTRL VCTRL 0 0.9

* Load and measurement
Vmeas_I IOUT IOUT_meas 0
Cload IOUT_meas 0 10p

* Reset switch to hold IOUT at 0V initially
Vreset reset 0 PWL(0 1.8 10n 1.8 11n 0)
XMreset IOUT_meas reset 0 0 sky130_fd_pr__nfet_01v8 L=0.15 W=10.0

* Startup nodeset for the self-biased loop
.nodeset v(N3)=1.0 v(N0)=0.5 v(N1)=0.5

.control
  * Run transient analysis
  tran 1n 5u
  
  * Measure DC current before reset is released (at t=5ns)
  meas tran DC_Current find i(Vmeas_I) at=5n
  
  * Measure ramp times for 10% (0.18V) and 90% (1.62V) of VDD
  meas tran t_10 WHEN v(IOUT_meas)=0.18 RISE=1
  meas tran t_90 WHEN v(IOUT_meas)=1.62 RISE=1
  
  * Calculate actual slope (V/s and V/us)
  meas tran Ramp_Slope param='(1.62 - 0.18) / (t_90 - t_10) / 1e6'
  
  * Calculate slope error compared to ideal I/C
  meas tran ideal_slope param='DC_Current / 10e-12'
  meas tran Slope_Error param='( (1.62 - 0.18) / (t_90 - t_10) - ideal_slope ) / ideal_slope * 100'
  
  * Calculate INL at the midpoint of the ramp
  meas tran t_mid param='(t_10 + t_90) / 2'
  meas tran v_mid find v(IOUT_meas) at=t_mid
  meas tran INL_Midpoint param='v_mid - 0.9'
  
  * Print all metrics
  print DC_Current Ramp_Slope Slope_Error INL_Midpoint
  
  quit
.endc
.end