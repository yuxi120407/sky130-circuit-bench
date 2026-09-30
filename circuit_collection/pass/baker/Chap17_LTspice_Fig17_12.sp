* Switched-Capacitor Charge Pump Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

Vdd VDD 0 1.8
Vref VREF 0 1.0
Vbit Vbit 0 0.5

Vphi1 phi1 0 dc 1.8 pulse(0 1.8 0 100p 100p 4.8n 10n)
Vphi2 phi2 0 dc 1.8 pulse(0 1.8 5n 100p 100p 4.8n 10n)

S1 VDD X phi1 0 mysw
S2 X Y phi2 0 mysw
.model mysw sw vt=0.9 vh=0.1 ron=1 roff=1G

Ccup X 0 1p

XM4 Vbit VREF Y VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15

.control
  * 1. Regulated charge per cycle
  alter Vref 1.0
  alter Vbit 0.5
  tran 0.1n 50n
  meas tran charge_per_cycle_regulated integ i(Vbit) from=35n to=40n
  print charge_per_cycle_regulated

  * 2. Unregulated charge per cycle
  alter Vref 0.0
  tran 0.1n 50n
  meas tran charge_per_cycle_unregulated integ i(Vbit) from=35n to=40n
  print charge_per_cycle_unregulated

  * 3. Max bitline voltage (DC)
  alter Vref 1.0
  dc Vbit 0 1.8 0.01
  meas dc I_sat find i(Vbit) at=1.0
  let I_target = 0.9 * I_sat
  meas dc max_bitline_voltage when i(Vbit) = $&I_target fall=1
  print max_bitline_voltage

  * 4. Zero charge VREF limit (DC)
  alter Vbit 0.5
  dc Vref 0 1.8 0.01
  meas dc zero_charge_vref_limit when i(Vbit) = 1e-8 fall=1
  print zero_charge_vref_limit
.endc
.end