* High-Performance Very Low-Voltage Current Sense Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm8=5.0 L_xm8=0.5

XM3 N0 VREF GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM1 BL BL GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM7 VREF VREF N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM9 N3 BL GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM5 BL N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM8 N3 VREF GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Bitline capacitance
Cbl BL 0 1p

VVDD VDD 0 1.8
VVREF VREF 0 0.6

* Cell current simulation using a voltage-dependent current source to prevent negative bitline voltage
* IN_T=1 represents cell ON, IN_T=0 represents cell OFF
V_in_timing IN_T 0 PULSE(1 0 10n 0.1n 0.1n 40n 80n)
B_Icell BL 0 I=V(IN_T)*0.001*V(BL)

.control
  * DC Operating Point for Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * Transient Analysis for Delay and Swing
  tran 0.1n 80n
  
  meas tran v_bl_max max v(BL)
  meas tran v_bl_min min v(BL)
  let v_swing = v_bl_max - v_bl_min
  print v_swing

  * Measure read access time (delay)
  * Cell turns OFF at 10ns -> BL rises
  meas tran delay_rise trig v(IN_T) val=0.5 fall=1 targ v(BL) val=0.04 rise=1
  
  * Cell turns ON at 50.1ns -> BL falls
  meas tran delay_fall trig v(IN_T) val=0.5 rise=1 targ v(BL) val=0.04 fall=1
.endc
.end