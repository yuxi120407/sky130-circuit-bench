* Subthreshold Voltage Reference Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmp1=0.5
.param L_xmp2=0.5
.param L_xmp3=0.5
.param L_xmp4=0.5
.param L_xmp5=0.5
.param L_xmp6=0.5
.param L_xmp7=0.5

* Parameterized W/L
.param W_xmp1=5.0 L_xmp1=0.5
.param W_xmp2=20.0 L_xmp2=0.5  $ Increased W to 20u to create K=4 ratio for PTAT generation
.param W_xmp3=5.0 L_xmp3=0.5
.param W_xmp4=5.0 L_xmp4=0.5
.param W_xmp5=5.0 L_xmp5=0.5
.param W_xmp6=5.0 L_xmp6=0.5
.param W_xmp7=5.0 L_xmp7=0.5

* DUT
XMP1 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xmp1} w={W_xmp1}
XMP2 N1 N2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xmp2} w={W_xmp2}
XMP3 N2 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp3} w={W_xmp3}
XMP4 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp4} w={W_xmp4}
XMP5 IB N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp5} w={W_xmp5}
XMP6 N0 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp6} w={W_xmp6}
XMP7 N2 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp7} w={W_xmp7}

* Added components for PTAT core and biasing
R1 N3 GND 200k
VVDD VDD 0 DC 1.8
VIB IB 0 DC 0.75

* Startup nodeset to avoid zero-current state
.nodeset v(N1)=1.0 v(N2)=0.5

.control
  * 1. DC Operating Point
  op
  let vref = v(N2)
  let power = -i(VVDD) * 1.8
  print vref power

  * 2. Temperature Sweep for TC
  dc temp -25 125 1
  let vref_max = vecmax(v(N2))
  let vref_min = vecmin(v(N2))
  let vref_nom = v(N2)[52]
  let tc = ((vref_max - vref_min) / vref_nom) / 150 * 1e6
  print tc

  * 3. Line Regulation
  dc VVDD 1.2 1.8 0.01
  let vref_1v8 = v(N2)[60]
  let vref_1v2 = v(N2)[0]
  let line_reg = (vref_1v8 - vref_1v2) / 0.6
  print line_reg

  quit
.endc
.end