* AI-Calibrated IF Filter Bias DAC Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param Ir=1u

* Modified DUT for ngspice compatibility (ideal switches replaced with V-controlled switches)
Iref VDD Bias 21.6u
I2 VDD N6 {16*Ir}
I9 VDD N10 {8*Ir}
I5 VDD N11 {4*Ir}
I7 VDD N3 {2*Ir}
I8 VDD N12 {Ir}
I6 Bias N8 {16*Ir}
I11 Bias N7 {8*Ir}
I4 Bias N4 {4*Ir}
I10 Bias N5 {2*Ir}
I1 Bias N2 {Ir}

S1 N6 Bias ctrl1 0 switch_model
S2 N10 Bias ctrl2 0 switch_model
S3 N11 Bias ctrl3 0 switch_model
S4 N3 Bias ctrl4 0 switch_model
S5 N12 Bias ctrl5 0 switch_model
S6 N8 VSS ctrl6 0 switch_model
S7 N7 VSS ctrl7 0 switch_model
S8 N4 VSS ctrl8 0 switch_model
S9 N5 VSS ctrl9 0 switch_model
S10 N2 VSS ctrl10 0 switch_model

.model switch_model SW(vt=0.9 ron=1 roff=1G)

* Supplies and Bias Load
VVDD VDD 0 1.8
VVSS VSS 0 0
VBias Bias 0 dc 0.9 ac 1

* Control Voltages (Digital Inputs)
Vctrl1 ctrl1 0 dc 0
Vctrl2 ctrl2 0 dc 0
Vctrl3 ctrl3 0 dc 0
Vctrl4 ctrl4 0 dc 0
Vctrl5 ctrl5 0 dc 0
Vctrl6 ctrl6 0 dc 0
Vctrl7 ctrl7 0 dc 0
Vctrl8 ctrl8 0 dc 0
Vctrl9 ctrl9 0 dc 0
Vctrl10 ctrl10 0 dc 0

Vdummy dummy 0 dc 0

.control
  * 1. Measure Base Current and Power (All switches OFF)
  alter Vctrl1 dc=0
  alter Vctrl2 dc=0
  alter Vctrl3 dc=0
  alter Vctrl4 dc=0
  alter Vctrl5 dc=0
  alter Vctrl6 dc=0
  alter Vctrl7 dc=0
  alter Vctrl8 dc=0
  alter Vctrl9 dc=0
  alter Vctrl10 dc=0
  
  alter I2 0
  alter I9 0
  alter I5 0
  alter I7 0
  alter I8 0
  alter I6 0
  alter I11 0
  alter I4 0
  alter I10 0
  alter I1 0

  dc Vdummy 0 1 1
  meas dc I_VDD_base find i(VVDD) at=0
  meas dc Power param='-I_VDD_base * 1.8'
  meas dc I_VBias_base find i(VBias) at=0
  meas dc I_base param='I_VBias_base'
  
  * 2. Measure LSB Source Current (Turn on S5)
  alter Vctrl5 dc=1.8
  alter I8 {Ir}
  dc Vdummy 0 1 1
  meas dc I_VBias_lsb find i(VBias) at=0
  meas dc I_LSB param='I_VBias_lsb - I_base'
  
  * 3. Measure Max Source Current (Turn on S1-S5)
  alter Vctrl1 dc=1.8
  alter Vctrl2 dc=1.8
  alter Vctrl3 dc=1.8
  alter Vctrl4 dc=1.8
  alter Vctrl5 dc=1.8
  alter I2 {16*Ir}
  alter I9 {8*Ir}
  alter I5 {4*Ir}
  alter I7 {2*Ir}
  alter I8 {Ir}
  dc Vdummy 0 1 1
  meas dc I_VBias_max find i(VBias) at=0
  meas dc I_max_tune param='I_VBias_max - I_base'
  
  * AC Analysis for Filter metrics
  ac dec 10 1k 100Meg
  let vbias_db = db(v(Bias))
  meas ac Filter_Gain max vbias_db
  meas ac Filter_Frequency max_at vbias_db

  print Power I_base I_LSB I_max_tune Filter_Gain Filter_Frequency
  quit
.endc
.end