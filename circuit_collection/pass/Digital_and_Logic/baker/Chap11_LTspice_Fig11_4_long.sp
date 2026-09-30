* CMOS Inverter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

xm1 vout vin 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
xm2 vout vin vdd vdd sky130_fd_pr__pfet_01v8 w=5.0 l=0.15

Vdd vdd 0 dc 1.8
Vin vin 0 dc 0 ac 0 pulse(0 1.8 0 10p 10p 1n 2n)
Iout 0 vout dc 0 ac 0
Cload vout 0 0f

.control
* DC Analysis
dc vin 0 1.8 0.01
meas dc switching_point_voltage when v(vout)=v(vin)
let switching_point_voltage_short_channel = switching_point_voltage

let idd = -i(Vdd)
meas dc crossing_current max idd

let dvout = deriv(v(vout))
meas dc vil find v(vin) when dvout=-1 fall=1
meas dc vih find v(vin) when dvout=-1 rise=1
meas dc voh find v(vout) when dvout=-1 fall=1
meas dc vol find v(vout) when dvout=-1 rise=1
let noise_margin_low = vil - vol
let noise_margin_high = voh - vih

* AC Analysis for input capacitance
alter Vin ac=1
alter Iout ac=0
ac dec 10 1G 10G
let cap_in = mag(i(Vin))/(2*pi*frequency)
meas ac input_capacitance find cap_in at=1G

* AC Analysis for output capacitance
alter Vin ac=0
alter Iout ac=1
ac dec 10 1G 10G
let yout = 1/v(vout)
let cap_out = imag(yout)/(2*pi*frequency)
meas ac output_capacitance find cap_out at=1G

* Transient Analysis for intrinsic delay
alter Vin ac=0
alter Iout ac=0
tran 1p 4n
meas tran intrinsic_delay_hl trig v(vin) val=0.9 rise=1 targ v(vout) val=0.9 fall=1
meas tran intrinsic_delay_lh trig v(vin) val=0.9 fall=1 targ v(vout) val=0.9 rise=1

* Transient Analysis for loaded delay
alter Cload 100f
tran 1p 4n
meas tran loaded_delay_hl trig v(vin) val=0.9 rise=1 targ v(vout) val=0.9 fall=1
meas tran loaded_delay_lh trig v(vin) val=0.9 fall=1 targ v(vout) val=0.9 rise=1

print noise_margin_high noise_margin_low crossing_current switching_point_voltage switching_point_voltage_short_channel input_capacitance output_capacitance intrinsic_delay_lh intrinsic_delay_hl loaded_delay_lh loaded_delay_hl
.endc
.end