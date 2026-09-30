* Programmable Bandpass Filter Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* === DUT (Incomplete Netlist from Extraction) ===
C2 Vin N1 1p
C1 Vout GND 1p

* === Dummy Components ===
R_dummy1 N1 Vout 1Meg
R_dummy2 Vout GND 10Meg

* === Sources ===
VDD VDD 0 DC 1.8
VVIN Vin 0 DC 0.9 AC 1 SIN(0.9 0.1 10k 0 0)
I1 VDD N1 DC 0.1u

* === Analyses ===
.control
  * 1. DC Operating Point & Power
  op
  let power_consumption = -i(VDD) * 1.8
  print power_consumption

  * 2. AC Analysis for Filter Response
  ac dec 50 1 100Meg
  meas ac passband_gain MAX vdb(Vout)
  meas ac center_frequency MAX_AT vdb(Vout)
  print passband_gain
  print center_frequency

  * 3. Noise Analysis for Dynamic Range
  noise v(Vout) VVIN dec 10 1 100Meg
  setplot noise2
  let dynamic_range = 20 * log10(0.9 / inoise_total)
  print dynamic_range

  quit
.endc

.end