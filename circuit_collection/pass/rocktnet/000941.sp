* CMOS Temperature Sensor Front-End Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic PNP model for temperature sensing
.model pnp pnp (is=1e-16)

* Parameterized values based on paper metrics
.param CVAL=120f
.param I_UNIT=2u

* DUT Netlist
I2I VDD VIN_N DC I_UNIT
I10I VDD VIN_P DC {5*I_UNIT} AC 1u
QR GND GND VIN_N pnp
QL GND GND VIN_P pnp

C1 VIN_P N4 {CVAL}
C2 N3 VIN_N {CVAL}
C3 N4 LABEL_NET_0 {CVAL}
C4 VINT_P N4 {2*CVAL}
C5 VINT_N N3 {2*CVAL}
C6 N3 VIN_N {CVAL}

X1 VINT_P VINT_N N4 N3 amplifier

* Ideal Fully-Differential Amplifier Subcircuit
.subckt amplifier out+ out- in+ in-
E_diff out_diff 0 in+ in- 10000
E_out+ out+ 0 VALUE={0.9 + V(out_diff)/2}
E_out- out- 0 VALUE={0.9 - V(out_diff)/2}
.ends

* DC feedback resistors to prevent floating nodes in AC/DC analysis
R_dc1 VINT_P N4 1G
R_dc2 VINT_N N3 1G

* Voltage Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9

* Differential voltage extractors for AC measurement
E_diff_out diff_out 0 VINT_P VINT_N 1
E_diff_in diff_in 0 VIN_P VIN_N 1

.control
  * 1. Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. Temperature Sweep for Delta VBE
  dc temp -55 125 5
  let dvbe = v(vin_p) - v(vin_n)
  meas dc delta_vbe find dvbe at=25
  print delta_vbe
  meas dc vbe find v(vin_n) at=25
  print vbe
  meas dc delta_vbe_125 find dvbe at=125
  print delta_vbe_125
  meas dc delta_vbe_m55 find dvbe at=-55
  print delta_vbe_m55
  let tc_delta_vbe = (delta_vbe_125 - delta_vbe_m55) / 180.0
  print tc_delta_vbe

  * 3. AC Analysis for Closed-Loop Gain
  ac dec 10 1 1Meg
  let gain_db = db(v(diff_out)) - db(v(diff_in))
  meas ac midband_gain_db find gain_db at=100k
  print midband_gain_db
  
  quit
.endc
.end