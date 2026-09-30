* Discrete-Time Loop Filter Testbench

.param C_S=20p C_H=40p
.param I_pump=100u
.param T_pump=10n

* DUT (Adapted for ngspice valid switch syntax)
CS VCP GND {C_S}
CH VCH GND {C_H}
S1 VCP VCH ctrl1 GND sw_model
S2 VCP GND ctrl2 GND sw_model

* Switch Model
.model sw_model sw vt=0.9 vh=0.1 ron=10 roff=1G

* Stimulus
* 1. Charge pump current pulse (Integrate charge onto CS: 0 to 10ns)
I1 GND VCP PULSE(0 I_pump 1n 100p 100p T_pump 100n)

* 2. Switch 1 control (Charge share between CS and CH: 20ns to 30ns)
Vctrl1 ctrl1 GND PULSE(0 1.8 20n 100p 100p 10n 100n)

* 3. Switch 2 control (Reset CS to GND: 40ns to 50ns)
Vctrl2 ctrl2 GND PULSE(0 1.8 40n 100p 100p 10n 100n)

.control
* Run transient analysis
tran 100p 60n

* Measure peak voltage on CS after integration
meas tran v_vcp_peak max v(VCP) from=10n to=19n

* Measure final voltage on CH after charge sharing
meas tran v_vch_final find v(VCH) at=35n

* Measure reset voltage on CS after reset phase
meas tran v_vcp_reset find v(VCP) at=55n

* Calculate charge share ratio based on voltages
let charge_share_ratio = v_vch_final / v_vcp_peak
print charge_share_ratio

quit
.endc
.end