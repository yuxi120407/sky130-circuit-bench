* Electronic Attenuator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic BJT models for translinear core
.model pnp pnp
.model npn npn

* Parameters
.param R_val=10k

* Ideal Op-Amps replacing A1 and A2 from netlist
* A1 (N1 GND) amplifier -> Input buffer
E1 N1 GND VIN GND 1
* A2 (VOUT N4 GND) amplifier -> Output transimpedance amplifier
E2 VOUT GND GND N4 1Meg

* DUT (Original netlist with parameterized resistors)
Q1 GND GND VE1 pnp
R1 VE2 VEE {R_val}
R2 VE1 N1 {R_val}
R3 VOUT N4 {R_val}
Q3 GND GND VE2 npn
R4 VIN GND {R_val}
Q4 N4 GND VE2 npn
Q2 N4 GND VE1 pnp

* Stimulus
VVIN VIN GND DC 1.8 AC 1 SIN(1.8 0.1 1k)
VVEE VEE GND DC -1.8

.control
  * DC Operating Point
  op
  let power_consumption = abs(i(VVEE) * -1.8) + abs(i(VVIN) * 1.8)
  print power_consumption

  * AC Analysis for Gain and Bandwidth
  ac dec 10 1 100G
  let gain_db = vdb(VOUT)
  meas ac midband_gain find gain_db at=1k
  let gain_3db = midband_gain - 3
  meas ac bandwidth when gain_db = gain_3db fall=1

  * Noise Analysis for Dynamic Range
  noise v(VOUT) VVIN dec 10 1 100G
  setplot noise2
  let dynamic_range = 20 * log10(0.707 / onoise_total)
  print dynamic_range

  * Transient Analysis for THD and Swing
  tran 1u 5m
  meas tran v_max max v(VOUT)
  meas tran v_min min v(VOUT)
  fourier 1k v(VOUT)
.endc

.end