* Testbench for Class AB Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

Vdd vdd 0 1.8
Vin vin_src 0 dc 0 ac 1 pulse(0 0.4 1n 0.1n 0.1n 40n 100n)

* AC coupling and self-bias
C1 vin_src vin 1u
Rfb vin vout 1Meg

* Push-pull output stage
xmop vout vin vdd vdd sky130_fd_pr__pfet_01v8 w=10.0 l=0.15
xmon vout vin 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15

* Load
CL vout 0 1p

.control
  op
  
  * AC Analysis
  ac dec 10 0.01 100G
  let gain_db = db(v(vout))
  let intrinsic_gain_db = db(v(vout)/v(vin))
  let phase_deg = 180/PI*cph(v(vout))
  
  meas ac small_signal_gain MAX gain_db
  meas ac open_circuit_gain MAX intrinsic_gain_db
  
  let gain_3db = small_signal_gain - 3
  
  meas ac input_pole WHEN gain_db=gain_3db RISE=1
  meas ac output_pole WHEN gain_db=gain_3db FALL=1
  
  meas ac unity_gain_frequency WHEN gain_db=0 FALL=1
  
  meas ac midband_phase FIND phase_deg AT=10000
  let shifted_phase = phase_deg - midband_phase
  meas ac transfer_function_zero WHEN shifted_phase=-135 FALL=1
  
  * Transient Analysis
  tran 10p 100n
  meas tran vout_max MAX v(vout)
  meas tran vout_min MIN v(vout)
  let v90 = vout_min + 0.9 * (vout_max - vout_min)
  let v10 = vout_min + 0.1 * (vout_max - vout_min)
  meas tran t1 WHEN v(vout)=v10 CROSS=1
  meas tran t2 WHEN v(vout)=v90 CROSS=1
  let slew_rate = abs((v90 - v10) / (t2 - t1)) / 1e6
  
  print small_signal_gain open_circuit_gain output_pole input_pole transfer_function_zero unity_gain_frequency slew_rate
.endc
.end