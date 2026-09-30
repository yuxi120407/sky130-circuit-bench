* Bitline Accelerator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

XM1 N3 N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 VDD N3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

VVDD VDD 0 1.8
VN2 N2 0 0
VN4 N4 0 0

* Bitline capacitance
CBL N3 0 1p
* Output load
ROUT OUT 0 100k
COUT OUT 0 10f

* Cell discharge current (starts at 10ns)
Icell N3 0 PWL(0 0 10n 0 11n 10u)

* Precharge to 1.8V
.ic v(N3)=1.8 v(N1)=0 v(OUT)=0

.control
tran 100p 100n
* Measure trip voltage
meas tran trip_voltage find v(N3) when v(OUT)=0.9 rise=1
* Measure response time
meas tran t_start when v(N3)=1.4 fall=1
meas tran t_out when v(OUT)=0.9 rise=1
let response_time = t_out - t_start
print response_time
* Measure peak discharge current
meas tran peak_current max i(VN2)
let peak_discharge_current = peak_current
print peak_discharge_current
* Measure static power
meas tran pwr_static find i(VVDD) at=5n
let static_power = -pwr_static * 1.8
print static_power
* Sense Margin
let sense_margin = 1.8 - trip_voltage
print sense_margin
quit
.endc
.end
