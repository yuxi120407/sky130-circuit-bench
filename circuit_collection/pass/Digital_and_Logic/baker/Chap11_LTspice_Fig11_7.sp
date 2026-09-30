* CMOS Inverter Testbench - Baker Chapter 11
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT parameters
.param W_xm1=1.0
.param L_xm1=0.15
.param W_xm2=2.0
.param L_xm2=0.15

* DUT Netlist
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
Vin Vin 0 dc 0 pulse(0 1.8 0.2n 50p 50p 1n 2.2n)
VDD VDD 0 1.8
xm2 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}

* Output capacitive load (interconnect + fanout)
Cload Vout 0 10f

.control
save all

* ==========================================
* 1. DC Sweep Analysis for VTC and Noise Margins
* ==========================================
dc Vin 0 1.8 0.001

* Rail voltages
meas dc output_high_voltage max v(Vout)
meas dc output_low_voltage min v(Vout)

* Switching point voltage VSP where Vout = Vin
meas dc switching_point_voltage when v(Vout)=v(Vin)

* Peak crossing current from VDD during switching
let id_vdd = -i(VDD)
meas dc peak_crossing_current max id_vdd

* Unity gain points dVout/dVin = -1 for VIL and VIH
let gain = deriv(v(Vout))
meas dc input_low_voltage when gain=-1 fall=1
meas dc input_high_voltage when gain=-1 rise=1

* Noise margins
meas dc noise_margin_high param='output_high_voltage - input_high_voltage'
meas dc noise_margin_low param='input_low_voltage - output_low_voltage'

print switching_point_voltage peak_crossing_current output_high_voltage output_low_voltage input_low_voltage input_high_voltage noise_margin_high noise_margin_low

* ==========================================
* 2. Transient Analysis for Switching Delays and Power
* ==========================================
tran 1p 4.4n

* Propagation delays (50% to 50%)
meas tran propagation_delay_hl trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 fall=1
meas tran propagation_delay_lh trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 rise=1

* Dynamic power over one complete cycle (0.2ns to 2.4ns)
let inst_pwr = -i(VDD) * 1.8
meas tran dynamic_power avg inst_pwr from=0.2n to=2.4n

* Power Delay Product
meas tran power_delay_product param='dynamic_power * (propagation_delay_hl + propagation_delay_lh)'

print propagation_delay_hl propagation_delay_lh dynamic_power power_delay_product

quit
.endc
.end