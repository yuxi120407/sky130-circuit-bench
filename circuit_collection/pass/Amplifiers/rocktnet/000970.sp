* Cascoded Inverter Amplifier Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xmn1=0.5
.param L_xmn21=0.5
.param L_xmn22=0.5
.param L_xmp1=0.5
.param L_xmp21=0.5
.param L_xmp22=0.5

.param W_xmp22=5.0 L_xmp22=0.5
.param W_xmn22=5.0 L_xmn22=0.5
.param W_xmn21=5.0 L_xmn21=0.5
.param W_xmn1=5.0 L_xmn1=0.5
.param W_xmp21=5.0 L_xmp21=0.5
.param W_xmp1=5.0 L_xmp1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5

* DUT
XMP22 VO VB0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xmp22} w={W_xmp22}
XMN22 VO VB1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xmn22} w={W_xmn22}
XMN21 N0 GND N3 GND sky130_fd_pr__nfet_01v8 l={L_xmn21} w={W_xmn21}
XMN1 N3 VON GND GND sky130_fd_pr__nfet_01v8 l={L_xmn1} w={W_xmn1}
XMP21 N4 VDD N1 VDD sky130_fd_pr__pfet_01v8 l={L_xmp21} w={W_xmp21}
XMP1 N1 VOP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp1} w={W_xmp1}
XM2 N0 N0 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM1 N4 LABEL_NET_2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* DC Sources
VVDD VDD 0 1.8
VVB0 VB0 0 0.99
VVB1 VB1 0 0.54
VLABEL_NET_2 LABEL_NET_2 0 0.9

* Closed loop for DC self-biasing at the trip point
* Huge inductor shorts output to input at DC, open at AC
L1 VO VOP 1G
* Tie VOP and VON together for inverter operation
R1 VOP VON 0
* Huge capacitor couples AC signal without disturbing DC bias
C1 VIN_AC VOP 1G
Vac VIN_AC 0 DC 0 AC 1

* Load Capacitance
CL VO 0 1p

.control
  * 1. Operating Point Analysis
  op
  let power_consumption = -i(VVDD) * 1.8
  let vtrip = v(VO)
  print power_consumption vtrip

  * 2. AC Analysis
  ac dec 100 1 10G
  let gain_db = db(v(VO))
  let phase_deg = 180/PI * ph(v(VO))
  
  meas ac dc_gain find gain_db at=10
  meas ac ugf when gain_db=0 fall=1
  meas ac phase_margin find phase_deg when gain_db=0 fall=1
  
  print dc_gain ugf phase_margin
  quit
.endc
.end