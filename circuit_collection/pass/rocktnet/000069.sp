* 3T APS Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

* DUT
XM1 LABEL_NET_0 LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD N1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 LABEL_NET_2 LABEL_NET_3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Voltage Sources
VVDD VDD 0 1.8
VVRST LABEL_NET_0 0 1.8
* RST pulses high to reset the photodiode
VRST LABEL_NET_1 0 PULSE(0 1.8 1u 10n 10n 1u 20u)
* RS is kept high to continuously monitor the source follower output
VRS LABEL_NET_3 0 1.8

* Photodiode Model (Capacitance and Photocurrent)
C_pd N1 0 10f
I_photo N1 0 1n

* Column Bus Load
I_col LABEL_NET_2 0 1u
C_col LABEL_NET_2 0 100f

.control
  * Run transient analysis to simulate reset and integration
  tran 10n 15u
  
  * Measure Reset Levels
  meas tran v_pd_reset MAX v(N1) from=1u to=3u
  meas tran v_out_reset MAX v(LABEL_NET_2) from=1u to=3u
  
  * Measure Source Follower Gain during integration ramp
  * Point 1 (early integration)
  meas tran v_pd_1 find v(N1) at=3u
  meas tran v_out_1 find v(LABEL_NET_2) at=3u
  
  * Point 2 (mid integration)
  meas tran v_pd_2 find v(N1) at=6u
  meas tran v_out_2 find v(LABEL_NET_2) at=6u
  
  * Calculate Gain
  let sf_gain = (v_out_1 - v_out_2) / (v_pd_1 - v_pd_2)
  print sf_gain
  
  * Measure Power Consumption during read
  meas tran i_vdd_val find i(VVDD) at=5u
  let power = -i_vdd_val * 1.8
  print power
  
  quit
.endc
.end
