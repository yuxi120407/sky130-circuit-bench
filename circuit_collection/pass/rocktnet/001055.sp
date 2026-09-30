* Gm cell testbench
.param W_xm1cas=5.0 L_xm1cas=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1CAS N2 R2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1cas} w={W_xm1cas}
XM2 OUTN INP N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 N4 R1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM5 OUTP N1 LABEL_NET_3 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM3 OUTP INN N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUTN R3 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

* DC Sources and Biasing
VVDD VDD 0 1.8
VN1 N1 0 1.8
VLABEL_NET_3 LABEL_NET_3 0 1.8
VR1 R1 0 0.7
VR2 R2 0 1.2
VR3 R3 0 0.9

* Inputs
VINN INN 0 DC 0.9 AC 0
VINP INP 0 DC 0.9 AC 1 SIN(0.9 0.01 10MEG 0 0)

* Load Capacitance
CL OUTN 0 10f

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm1cas=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.control
  * 1. DC Sweep for Trip Point
  dc VINP 0 1.8 0.01
  meas dc vout_trip when v(OUTN)=0.9
  print vout_trip

  * Apply the trip point to VINP
  alter VINP dc = $&vout_trip
  alter @VINP[sin] = [ $&vout_trip 0.01 10MEG 0 0 ]

  * 2. DC Operating Point & Power
  op
  let power = -i(VVDD)*1.8 - i(VN1)*1.8 - i(VLABEL_NET_3)*1.8
  print power

  * 3. AC Analysis for Gain and Bandwidth
  ac dec 10 1k 10G
  let gain_db = db(v(OUTN))
  meas ac dc_gain find gain_db at=1k
  let gain_3db = dc_gain - 3
  meas ac bw_3db when gain_db="$&gain_3db" fall=1
  print dc_gain bw_3db

  * 4. Transient Analysis
  tran 1n 200n
  meas tran v_max max v(OUTN)
  print v_max
  
  quit
.endc
.end