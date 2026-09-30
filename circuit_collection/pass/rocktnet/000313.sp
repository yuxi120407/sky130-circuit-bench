* Testbench for Biomorphic Digital Image Sensor Pixel Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

XM1 N2 N0 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 LABEL_NET_1 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N3 LABEL_NET_2 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

Rload N2 GND 100k
Cload N2 GND 10f

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 1.8
VLABEL_NET_2 LABEL_NET_2 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 dc 0.9 ac 1 pulse(0 1.8 1n 100p 100p 2u 4u)

.control
  let trip_point = 0.9
  
  * DC Analysis
  dc VLABEL_NET_1 0 1.8 0.001
  let abs_gain_dc = abs(deriv(v(N2)))
  meas dc max_dc_gain max abs_gain_dc
  let DC_Gain = 20 * log10(max_dc_gain + 1e-12)
  print DC_Gain
  
  meas dc trip_point when v(N2)=0.9
  
  * AC Analysis
  alter VLABEL_NET_1 dc = $&trip_point
  op
  ac dec 100 1 1G
  meas ac ac_gain_db max vdb(N2)
  let gain_3db = ac_gain_db - 3
  meas ac Bandwidth when vdb(N2)=$&gain_3db fall=1
  print Bandwidth
  
  * Transient Analysis
  alter VLABEL_NET_1 dc = 0
  tran 10p 5u
  let delay_fall = 1e-9
  let delay_rise = 1e-9
  meas tran delay_fall trig v(LABEL_NET_1) val=0.9 rise=1 targ v(N2) val=0.9 fall=1
  meas tran delay_rise trig v(LABEL_NET_1) val=0.9 fall=1 targ v(N2) val=0.9 rise=1
  let Propagation_Delay = (delay_fall + delay_rise) / 2
  print Propagation_Delay
  
  let pwr = - (i(VVDD)*1.8 + i(VLABEL_NET_0)*1.8 + i(VLABEL_NET_2)*1.8)
  meas tran Power_Consumption avg pwr
  print Power_Consumption
  
  let Energy_per_operation = Power_Consumption * Propagation_Delay
  print Energy_per_operation
  
  quit
.endc
.end