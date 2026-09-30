* Testbench for FIR Filter Delay Cell
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

* DUT
XM4 OUTn INp N1 N1 sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM3 OUTp INn N2 N2 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 OUTn OUTn VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM1 OUTp OUTp VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM5 N2 INp N1 N1 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 INn N1 N1 sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

* Sources
VVDD VDD 0 1.8
VINp INp 0 DC 1.2 AC 0.5
VINn INn 0 DC 1.2 AC -0.5

* Tail currents (required for differential pair operation, added to complete the circuit)
I1 N1 0 25u
I2 N2 0 25u

* Load capacitance (simulating next stage input capacitance)
C1 OUTp 0 20f
C2 OUTn 0 20f

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power
  print v(OUTp) v(OUTn) v(N1) v(N2)

  * AC Analysis
  ac dec 50 1 100G
  let vout_diff = v(OUTp) - v(OUTn)
  let vin_diff = v(INp) - v(INn)
  let gain_mag = mag(vout_diff / vin_diff)
  let gain_db = 20 * log10(gain_mag)
  
  let dc_gain_mag = gain_mag[0]
  let gain_norm = gain_mag / dc_gain_mag
  let gain_norm_db = 20 * log10(gain_norm)
  
  let phase_rad = cph(vout_diff / vin_diff)
  let gd = -deriv(phase_rad) / 6.283185307179586
  
  meas ac dc_gain find gain_db at=10
  meas ac bandwidth when gain_norm_db=-3 fall=1
  meas ac group_delay find gd at=10
  
  print dc_gain
  print bandwidth
  print group_delay
  
  quit
.endc
.end