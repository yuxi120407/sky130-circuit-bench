* VSWR-Protected RF PA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R1_val=10k
.param R2_val=10k

* DUT
R1 RFin N1 {R1_val}
R2 N1 GND {R2_val}
Q1 RFin N1 GND npn
Q2 RFout RFin GND npn

* Valid SKY130 PDK bipolar device model
.model npn ako:sky130_fd_pr__npn_05v5_model

* Biasing and Load
VDD VDD 0 DC 1.8
Rload VDD RFout 200

* Input Bias Tee
Vbias RFin_DC 0 DC 0.81
L1 RFin_DC RFin 1m
Vac Vac_node 0 DC 0 AC 1 sin(0 0.02 1.8G)
Rs Vac_node RFin_AC 50
C1 RFin_AC RFin 1u

.control
* DC Analysis
op
let DC_Power = -i(VDD)*1.8
print DC_Power

* AC Analysis
ac dec 50 10Meg 10G
let gain_db = db(v(RFout))
meas ac Voltage_Gain max gain_db
meas ac Bandwidth when gain_db='Voltage_Gain-3' fall=1
print Voltage_Gain Bandwidth

* Transient Analysis
tran 10p 5n
meas tran vout_pp pp v(RFout) from=3n to=5n
meas tran vin_pp pp v(RFin) from=3n to=5n
meas tran Output_Power param='10 * log10((vout_pp * vout_pp / 1600) * 1000 + 1e-15)'
print Output_Power

quit
.endc
.end