* Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0

VVDD VDD 0 1.8
VBP2 LABEL_NET_2 0 0.7
VBP3 LABEL_NET_3 0 0.7
VREF LABEL_NET_1 0 0.9
VIN LABEL_NET_0 0 dc 0.9 pulse(0 1.8 10u 0.1n 0.1n 90u 200u)

* Connect N4 to N1 to form current mirror load for the diff pair
V_N4 N4 N1 0

* DUT
XM1 N1 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_1 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N0 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}

* Load Capacitor
CL N2 0 10f

.control
  * 1. DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * 2. DC Sweep
  dc VIN 0 1.8 0.01
  meas dc switching_threshold find v(LABEL_NET_0) when v(N2)=0.9
  print switching_threshold
  let gain = deriv(v(N2))
  meas dc dc_gain max gain
  print dc_gain

  * 3. Transient Analysis
  tran 10n 200u
  meas tran t_vin_rise when v(LABEL_NET_0)=0.9 rise=1
  meas tran t_vout_rise when v(N2)=0.9 rise=1
  let t_delay_rise = t_vout_rise - t_vin_rise

  meas tran t_vin_fall when v(LABEL_NET_0)=0.9 fall=1
  meas tran t_vout_fall when v(N2)=0.9 fall=1
  let t_delay_fall = t_vout_fall - t_vin_fall

  let propagation_delay = (t_delay_rise + t_delay_fall) / 2
  print propagation_delay
  
  quit
.endc
.end