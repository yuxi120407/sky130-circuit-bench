* CS Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

VDD vdd 0 1.8
VSS vss 0 0

* Bias Circuit
Iref vbias_p 0 10u
XM3 vbias_p vbias_p vdd vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.5

* Amplifier
XM1 vout vin 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
XM2 vout vbias_p vdd vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.5

Cload vout 0 1p

* DC feedback for biasing
L1 vout vin 1T
C1 vin_ac vin 1
Vin_ac vin_ac 0 dc 0 ac 1
Iout_ac 0 vout dc 0 ac 0

.control
  ac dec 100 1 100G
  let gain_db = db(v(vout))
  meas ac low_freq_gain find gain_db at=1
  let gain_3db = low_freq_gain - 3
  meas ac dominant_pole when gain_db = gain_3db
  
  let phase_vout = ph(v(vout))
  meas ac rhp_zero when phase_vout=45
  
  alter Vin_ac acmag=0
  alter Iout_ac acmag=1
  ac dec 10 1 100G
  let rout_mag = mag(v(vout))
  meas ac output_resistance find rout_mag at=1
  
  print low_freq_gain dominant_pole rhp_zero output_resistance
.endc
.end