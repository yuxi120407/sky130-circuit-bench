* CMOS Inverter Characterization
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

* Define parameters for the parameterized netlist
.param W_xm1=1.0 L_xm1=0.15
.param W_xm2=2.0 L_xm2=0.15

* --- DUT (Pasted from prompt) ---
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
C1 Vout 0 5e-14
* --------------------------------

* Stimulus
Vin Vin 0 dc 0 pulse(0 1.8 1n 0.05n 0.05n 2n 4n)

.control
* 1. DC Analysis for Voltage Transfer Curve (VTC)
dc Vin 0 1.8 0.01

* Calculate derivative to find VIL and VIH (where slope = -1)
let dVout = deriv(v(Vout))
let vdiff = v(Vout) - v(Vin)

* Measure VSP (where Vin = Vout)
meas dc VSP find v(Vin) when vdiff=0

* Measure VIL and VIH (where dVout/dVin = -1)
* dVout starts at 0, goes negative (crosses -1 falling), reaches min, goes back to 0 (crosses -1 rising)
meas dc VIL find v(Vin) when dVout=-1 fall=1
meas dc VIH find v(Vin) when dVout=-1 rise=1

* Calculate Noise Margins
let VOH = 1.8
let VOL = 0
let NMH = VOH - VIH
let NML = VIL - VOL
print VSP VIL VIH NMH NML

* 2. Transient Analysis for Delay and Power
tran 10p 10n

* Measure Propagation Delays (50% of VDD = 0.9V)
meas tran tPHL trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 fall=1
meas tran tPLH trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 rise=1

* Measure Average Power over one full clock cycle (0 to 4ns)
* Note: i(VDD) is current flowing out of the VDD source node in ngspice convention
meas tran pwr_integ integ i(VDD) from=0 to=4n
let avg_pwr = -(pwr_integ / 4n) * 1.8

* Calculate Power Delay Product (PDP)
let PDP = avg_pwr * (tPHL + tPLH)
print tPHL tPLH avg_pwr PDP

quit
.endc
.end
