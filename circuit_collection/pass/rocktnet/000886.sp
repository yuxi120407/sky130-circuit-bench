* Avalanche-Tolerant Bias Circuit and PA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic BJT models for functional verification
.model npn npn (is=1e-16 bf=100)
.model pnp pnp (is=1e-16 bf=50)

* Parameters
.param I_bias=100u
.param L_val=1n
.param C_val=1p
.param VDD=1.8

* DUT
I1 VCC_bias N8 {I_bias}
I2 VCC_bias N0 0.1u
Q3 N0 N8 N6 npn
Q7 N1 N5 N0 pnp
Q2 N3 N7 GND npn
Q8 N6 N1 GND npn
Q4 N5 N5 GND npn
Q9 N8 N1 GND npn
Q1 N8 N8 N5 npn
C1 N3 PA_out {C_val}
C2 N7 RF_in {C_val}
L1 N6 N7 {L_val}
L2 N3 VCC_PA {L_val}

* Sources and Loads
V1 VCC_bias GND {VDD}
V2 VCC_PA GND {VDD}
Vrf RF_in GND dc 0 ac 1
Rload PA_out GND 50

.control
* 1. DC Operating Point
op
let dc_power = (-i(V1) - i(V2)) * 1.8
let bias_voltage = v(N7)
print dc_power
print bias_voltage

* 2. AC Analysis
ac dec 50 100Meg 20G
let gain_db = db(v(PA_out))
meas ac voltage_gain max gain_db
meas ac operating_frequency max_at gain_db
print voltage_gain
print operating_frequency

quit
.endc
.end