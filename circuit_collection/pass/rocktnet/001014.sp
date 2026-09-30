* Clocked Switch Driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 N3 INP N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 CLK GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 CLK GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 INN N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VDD N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VDD N3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Pull-up resistors added to provide DC path and baseline swing
R1 N3 VDD 5k
R2 N4 VDD 5k

VVDD VDD 0 1.8
VINP INP 0 DC 0.9 AC 1 PULSE(0 1.8 0 50p 50p 2n 4n)
VINN INN 0 DC 0.9 AC -1 PULSE(1.8 0 0 50p 50p 2n 4n)
VCLK CLK 0 DC 1.8 PULSE(0 1.8 0.5n 50p 50p 0.4n 1n)

.control
  * DC Operating Point
  op
  let power_dc = -i(VVDD) * 1.8
  print power_dc

  * AC Analysis
  ac dec 50 1Meg 100G
  let gain_db = 20 * log10(mag(v(N3) - v(N4)) / 2)
  meas ac gain find gain_db at=1Meg
  let gain_3db = gain - 3
  meas ac bandwidth when gain_db=gain_3db fall=1
  print gain
  print bandwidth

  * Transient Analysis
  tran 10p 3n
  meas tran v_max max v(N3)
  meas tran v_min min v(N3)
  let v_swing = v_max - v_min
  print v_swing
  
  meas tran t_delay trig v(CLK) val=0.9 rise=1 targ v(N3) val=0.9 fall=1
  print t_delay
  
  quit
.endc
.end