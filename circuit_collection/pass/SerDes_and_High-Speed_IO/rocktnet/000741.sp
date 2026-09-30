* LVDS Driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

* DUT
XM1 N2 LABEL_NET_0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N3 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_4 LABEL_NET_3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 LABEL_NET_5 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}

* Biases and Supplies
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8
VLABEL_NET_3 LABEL_NET_3 0 0
VLABEL_NET_5 LABEL_NET_5 0 0
VLABEL_NET_4 LABEL_NET_4 0 1.8

* Inputs (250 MHz data rate to allow settling with 6.4pF load)
VLABEL_NET_0 LABEL_NET_0 0 PULSE(0 1.8 1n 100p 100p 1.9n 4n)
VLABEL_NET_2 LABEL_NET_2 0 PULSE(1.8 0 1n 100p 100p 1.9n 4n)
VN3 N3 0 PULSE(1.8 0 1n 100p 100p 1.9n 4n)

* Load (100 ohm differential, 6.4pF single-ended as per paper)
Rload N1 N2 100
Cload1 N1 0 6.4p
Cload2 N2 0 6.4p

.control
  tran 10p 10n
  
  let vdiff = v(N1) - v(N2)
  let vcm = (v(N1) + v(N2)) / 2
  
  meas tran vod_max max vdiff from=2n to=10n
  meas tran vod_min min vdiff from=2n to=10n
  let vod = (vod_max - vod_min)/2
  
  meas tran vocm_avg avg vcm from=2n to=10n
  
  * Power calculation (including all sources that supply current)
  let pwr = -i(VVDD)*1.8 - i(VLABEL_NET_1)*1.8 - i(VN3)*v(N3)
  meas tran pwr_avg avg pwr from=2n to=10n
  
  * Delay measurements
  meas tran delay_lh trig v(LABEL_NET_0) val=0.9 rise=1 targ vdiff val=0 rise=1
  meas tran delay_hl trig v(LABEL_NET_0) val=0.9 fall=1 targ vdiff val=0 fall=1
  
  print vod vocm_avg pwr_avg delay_lh delay_hl
  quit
.endc
.end