* Peak Detector Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm5_prime=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm5_prime=5.0 L_xm5_prime=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 N0 IN N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM5 VDD N1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM5_PRIME VDD N1 OUT GND sky130_fd_pr__nfet_01v8 l={L_xm5_prime} w={W_xm5_prime}
XM3 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM6 N1 RESET_BAR VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

* Missing connections and biasing
Vshort N1 N2 DC 0
I_tail N5 GND 200u
C_hold N3 GND 250f
C_out OUT GND 250f
R_discharge N3 GND 100k
R_discharge_out OUT GND 100k

VVDD VDD GND 1.8
VRESET RESET_BAR GND PWL(0 1.8 10n 1.8 10.1n 0 15n 0)

* Input source: DC + AC + Transient Pulse
VIN IN GND DC 1.0 AC 1 PWL(0 1.0 1n 1.0 1.1n 1.1 1.5n 1.1 1.6n 1.0 3n 1.0 3.1n 1.1 3.5n 1.1 3.6n 1.0)

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis for tracking bandwidth
  ac dec 20 1Meg 10Gig
  let gain_db = vdb(out)
  meas ac dc_gain find gain_db at=1Meg
  let gain_3db = dc_gain - 3
  meas ac bw_3db when gain_db=gain_3db fall=1

  * Transient Analysis for peak detection and reset
  tran 10p 15n
  meas tran v_peak_in max v(in) from=0 to=5n
  meas tran v_peak_out max v(out) from=0 to=5n
  let track_error = v_peak_in - v_peak_out
  print track_error
  
  meas tran v_hold find v(out) at=9n
  meas tran v_reset find v(out) at=14n
  meas tran t_reset trig v(reset_bar) val=0.9 fall=1 targ v(out) val=1.2 rise=1
  
  quit
.endc
.end
