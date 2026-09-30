* LVDS Driver Testbench
.param VDD_val=1.8

VVDD VDD 0 {VDD_val}
* Common-mode bias for the termination center tap
Vcm Vocm 0 1.25

* DUT (Adapted for valid ngspice syntax)
I1 VDD N1 3.5m
I2 N2 GND 3.5m
R1 Vocm Von 50
R2 Vop Vocm 50

* Voltage-controlled switches replacing pseudo-syntax
S1 Von N2 Vinp 0 switch_ideal
S2 N1 Vop Vinp 0 switch_ideal
S3 N1 Von Vinn 0 switch_ideal
S4 Vop N2 Vinn 0 switch_ideal

.model switch_ideal sw vt=0.9 vh=0.1 ron=1 roff=1G

* Load capacitance (from paper: 6.4pF)
Cload Vop Von 6.4p

* Stimulus (125 MHz clock to allow settling with 6.4pF load)
Vinp Vinp 0 PULSE(0 1.8 0 100p 100p 4n 8n)
Vinn Vinn 0 PULSE(1.8 0 0 100p 100p 4n 8n)

* Behavioral sources for differential and common-mode measurements
B1 Vdiff 0 V=v(Vop)-v(Von)
B2 Vcm_out 0 V=(v(Vop)+v(Von))/2

.control
tran 10p 20n

* Measure Differential Output Voltage (VOD)
meas tran VOD_max max v(Vdiff)
meas tran VOD_min min v(Vdiff)

* Measure Common-Mode Voltage (VOCM)
meas tran VOCM_meas avg v(Vcm_out)

* Measure Rise and Fall Times (approx 20% to 80% of 700mVpp diff swing)
meas tran trise trig v(Vdiff) val=-200m rise=1 targ v(Vdiff) val=200m rise=1
meas tran tfall trig v(Vdiff) val=200m fall=1 targ v(Vdiff) val=-200m fall=1

* Measure Power Consumption
meas tran I_vdd avg i(VVDD)
let power = -I_vdd * 1.8
print power

quit
.endc
.end
