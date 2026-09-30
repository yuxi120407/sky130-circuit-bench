* Testbench for BJT Parasitic RC Network
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param c_diff=10f c_je=5f c_cbi=2f c_cbx=2f
.param r_bb=50 r_ex=5 r_c=10 r_cc=100 r_ee=10

* DUT
CDIFF N0 N1 {c_diff}
CJE N0 N1 {c_je}
CCBI N0 N1 {c_cbi}
CCBX N0 Base {c_cbx}
rBB N1 Base {r_bb}
rEX N0 Emitter {r_ex}
rC N0 Collector {r_c}
RCC VDD Collector {r_cc}
REE Emitter GND {r_ee}

* Sources
VVDD VDD 0 DC 1.8
VBase Base 0 DC 0 AC 1 PULSE(0 1 10p 1p 1p 100p 200p)

.control
* DC Analysis
op
let DC_Power = -i(VVDD) * 1.8
print DC_Power

* AC Analysis
ac dec 100 1G 1000G
let gain_db = vdb(Collector)
meas ac High_Freq_Gain find gain_db at=100G
print High_Freq_Gain

* Transient Analysis
tran 0.01p 50p
meas tran v_baseline find v(Collector) at=1p
meas tran Peak_Transient_Voltage max v(Collector)
meas tran t_peak max_at v(Collector)

let v_target = v_baseline + (Peak_Transient_Voltage - v_baseline) * 0.367879441
let v_col_shifted = v(Collector) - v_target

meas tran t_decay WHEN v_col_shifted=0 FALL=1
let tau = t_decay - t_peak
let Operating_Frequency_Support = 1 / (2 * 3.1415926535 * tau) / 1e9

print Operating_Frequency_Support
print Peak_Transient_Voltage

quit
.endc
.end