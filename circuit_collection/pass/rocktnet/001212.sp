* Silicon Retina Pixel Block Testbench

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* DUT
XM1 N4 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N10 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 GND N3 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 LABEL_NET_3 N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 GND N3 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N5 LABEL_NET_6 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N5 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}

* Power Supply
VVDD VDD 0 1.8

* Biases
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VN8 N8 0 0.5
VLABEL_NET_1 LABEL_NET_1 0 1.8

* Input for Inverter (AC and Tran)
VIN VIN_NODE 0 DC 0.9 AC 1 PULSE(0 1.8 10n 1n 1n 40n 100n)
R3 LABEL_NET_3 VIN_NODE 0 1m
R4 LABEL_NET_4 VIN_NODE 0 1m

* Input for MOSCAP Integrator
VLABEL_NET_6 LABEL_NET_6 0 PULSE(0 1.8 10n 1n 1n 40n 100n)

.ic v(N5)=1.8

.control
  * Find bias for N4 = 1.0V to properly bias the PFET current sources
  dc VLABEL_NET_0 0 1.8 0.01
  meas dc vbias0 when v(N4)=1.0
  alter @VLABEL_NET_0[dc] = $&vbias0

  * Find trip point
  dc VIN 0 1.8 0.01
  meas dc vtrip when v(N3)=v(VIN_NODE)
  alter @VIN[dc] = $&vtrip

  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 10 1k 1G
  let gain_inv_db = vdb(N3)
  let gain_sf_db = vdb(N2) - vdb(N3)
  meas ac gain_inv find gain_inv_db at=1k
  meas ac gain_sf find gain_sf_db at=1k
  print gain_inv gain_sf

  * Transient Analysis
  tran 0.1n 100n
  meas tran delay trig v(VIN_NODE) val=0.9 rise=1 targ v(N2) val=1.35 fall=1
  
  * Measure discharge rate of N5
  meas tran v_n5_t1 find v(N5) at=1n
  meas tran v_n5_t2 find v(N5) at=2n
  let discharge_rate = (v_n5_t1 - v_n5_t2) / 1e-9
  print discharge_rate
  
  quit
.endc
.end