* Low-power Inverter / Delay Cell Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

VVDD VDD 0 1.8
VIN N0 0 PULSE(0 1.8 1u 100p 100p 15u 31.25u)

XM1 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

* Load capacitance for realistic measurements
CL1 N1 0 10f
CL2 N2 0 10f

.control
  * DC Analysis for Switching Threshold
  dc VIN 0 1.8 0.01
  meas dc vth_switch find v(N0) when v(N1)=0.9
  print vth_switch
  
  * Transient Analysis for Delay and Power
  tran 10p 35u
  
  * Rise and Fall Times
  meas tran t_rise trig v(N1) val=0.18 rise=1 targ v(N1) val=1.62 rise=1
  meas tran t_fall trig v(N1) val=1.62 fall=1 targ v(N1) val=0.18 fall=1
  
  * Propagation Delays
  meas tran t_pd_hl trig v(N0) val=0.9 rise=1 targ v(N1) val=0.9 fall=1
  meas tran t_pd_lh trig v(N0) val=0.9 fall=1 targ v(N1) val=0.9 rise=1
  let t_pd = (t_pd_hl + t_pd_lh) / 2
  print t_rise t_fall t_pd
  
  * Average Power Consumption
  let inst_power = -i(VVDD) * 1.8
  meas tran avg_power avg inst_power from=0 to=35u
  print avg_power
  
  quit
.endc
.end