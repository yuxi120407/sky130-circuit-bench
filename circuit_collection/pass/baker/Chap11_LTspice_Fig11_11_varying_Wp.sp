* CMOS Inverter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

* Define parameters for device sizing
.param W_xm1=1.0 L_xm1=0.15
.param W_xm2=2.0 L_xm2=0.15

* DUT Instantiation
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}

* Load Capacitance (50fF as per text examples)
Cload Vout 0 50fF

* Input Source (Pulse for Tran, overridden by DC sweep)
Vin Vin 0 PULSE(0 1.8 1n 50p 50p 4n 10n)

.control
* ==========================================
* 1. DC Analysis (VTC, VSP, Noise Margins)
* ==========================================
dc Vin 0 1.8 0.01

* Find Switching Point Voltage (VSP) where Vin = Vout
let vdiff = v(Vout) - v(Vin)
meas dc vsp find v(Vin) when vdiff=0

* Find Noise Margins (VIL, VIH where dVout/dVin = -1)
let dvout = deriv(v(Vout))
meas dc vil find v(Vin) when dvout=-1 cross=1
meas dc vih find v(Vin) when dvout=-1 cross=2

let nml = vil - 0
let nmh = 1.8 - vih
print nml nmh

* Measure peak crossing (short-circuit) current
let i_vdd_dc = -i(VDD)
meas dc max_cross_current max i_vdd_dc

* ==========================================
* 2. Transient Analysis (Delay, Power, PDP)
* ==========================================
tran 10p 20n

* Measure Propagation Delays (50% to 50%)
meas tran tphl trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 fall=1
meas tran tplh trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 rise=1

* Measure Average Dynamic Power over 2 cycles (20ns)
meas tran i_avg avg i(VDD) from=0 to=20n
let p_avg = -i_avg * 1.8
print p_avg

* Calculate Power Delay Product (PDP)
let pdp = p_avg * (tphl + tplh) / 2
print pdp

quit
.endc
.end
