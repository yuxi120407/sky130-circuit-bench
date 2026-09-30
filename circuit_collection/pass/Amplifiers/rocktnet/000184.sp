* SiGe BiCMOS Burst-Mode Receiver Gain Stage
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic NPN model (used as SKY130 NPNs require specific subcircuit wrappers)
.model npn npn (is=1e-16 bf=100 vaf=50 cjc=100f cje=100f)

.param R1_val=100
.param R2_val=1k
.param CC_val=100f
.param RNLB_val=500
.param RFMB_val=2k
.param IB_val=100u

* DUT
IBIAS VDD N_BIAS {IB_val}
QB0 N_BIAS N_BIAS 0 npn
Q1 VDD IN N_Q2B npn
QB1 N_Q2B N_BIAS 0 npn
Q2 N_Q2C N_Q2B N_Q2E npn
R1 N_Q2E INDUMMY {R1_val}
R2 VDD N_Q2C {R2_val}
CC VDD N_Q2C {CC_val}
Q3 VDD N_Q2C OUT npn
QB2 OUT N_BIAS 0 npn
QNLB N_QNLB N_QNLB N_Q2B npn
RNLB N_QNLB OUT {RNLB_val}
RFMB N_Q2B OUT {RFMB_val}

* Sources
VVDD VDD 0 1.8
* DC bias adjusted to 1.4V to ensure Q2 turns on properly
VIN IN 0 DC 1.4 AC 1 SIN(1.4 0.05 10MEG 0 0)
* INDUMMY set to 0V to provide proper Vbe for Q2
VINDUMMY INDUMMY 0 DC 0

.control
* DC Analysis
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* AC Analysis
ac dec 100 1MEG 10G
let gain_db = db(v(OUT))
meas ac voltage_gain find gain_db at=10MEG
let gain_db_3db = voltage_gain - 3
meas ac bandwidth when gain_db=gain_db_3db fall=1
print voltage_gain
print bandwidth

* Transient Analysis
tran 100p 200n
meas tran output_swing pp v(OUT)
print output_swing

quit
.endc
.end