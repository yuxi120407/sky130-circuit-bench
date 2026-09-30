* LNA Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* --- DUT ---
.param W_xm1=5.0 L_xm1=0.5
XM1 IOUT N2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
* -----------

* Biasing and Supply
Vdd VDD 0 1.8
Vbias VBIAS 0 1.8

* Source connection (Common Source)
Vsrc N3 0 0

* Gate bias and RF input
Rgate VBIAS N2 10k
Cin IN N2 10p
Rsrc IN_src IN 50
Vin IN_src 0 dc 0 ac 2

* Drain RF choke and load
Ldrain VDD IOUT 10n
Cout IOUT OUT 10p
Rload OUT 0 50

.control
  * 1. DC Operating Point for Power
  op
  let power_consumption = -i(Vdd)*1.8
  print power_consumption

  * 2. AC Analysis for Voltage Gain
  ac dec 50 100MEG 10G
  let gain_db = db(v(OUT))
  meas ac voltage_gain find gain_db at=1.23G
  print voltage_gain
  
  * 3. Noise Analysis for Noise Figure
  * Calculate NF relative to 50 ohm source thermal noise at 290K (0.894 nV/rtHz)
  noise v(OUT) Vin dec 50 100MEG 10G
  setplot noise1
  let nf_db = db(inoise_spectrum / 8.94e-10)
  meas noise noise_figure find nf_db at=1.23G
  print noise_figure
.endc
.end