* Testbench for Current-Differencing Amplifier

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM1 N3 N3 N2 0 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N5 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N1 N2 0 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N5 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 N6 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N6 N3 N2 0 sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N6 N6 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 N1 N2 0 sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

Vvdd N0 0 1.8
Vvdd_bulk VDD 0 1.8
Vn2 N2 0 0
Vbias N5 0 0.9

* DC stabilization for high-impedance output node
Vmid Vmid 0 0.9
Rdc N4 Vmid 100MEG

* AC Input Currents (Differential 1A total)
Iin_p 0 N3 DC 0 AC 0.5
Iin_m 0 N1 DC 0 AC -0.5

.control
  * DC Operating Point
  op
  let power = -i(Vvdd) * 1.8
  let vout_dc = v(N4)
  print power vout_dc

  * AC Analysis
  ac dec 100 1 10G
  
  * Transimpedance gain (V/I)
  let tz_gain_db = db(v(N4))
  
  * Voltage gain (V/V)
  let v_diff = v(N3) - v(N1)
  let v_gain_complex = v(N4) / v_diff
  let v_gain_db = db(v_gain_complex)
  
  meas ac tz_gain MAX tz_gain_db
  meas ac v_gain MAX v_gain_db
  
  * Bandwidth
  let tz_gain_3db = tz_gain - 3
  meas ac bw when tz_gain_db=tz_gain_3db fall=1
  
  print tz_gain v_gain bw
  quit
.endc
.end