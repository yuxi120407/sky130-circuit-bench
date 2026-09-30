* High Efficiency Broadband Class-E Power Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 N5 N13 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND N16 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Terminate unused/dummy transistor XM2 to prevent floating nodes
R_N16 N16 GND 1k
R_N9 N9 GND 1k

* Class-E Load Network for XM1 (Designed for 1 GHz, Rload=1k)
Vvdd vdd GND 1.8
Lchoke vdd N5 10u
Cshunt N5 GND 20f
Lseries N5 N_mid 1.59u
Cseries N_mid out 17.9f
Rload out GND 1k

* Input Signal (1 GHz square wave for hard switching)
Vin N13 GND PULSE(0 1.8 0 10p 10p 490p 1n)

* Non-linear dependent sources to calculate instantaneous power
B_Pout Pout_node 0 V=v(out)*v(out)/1000
B_Pin Pin_node 0 V=-i(Vin)*v(N13)
B_Pdc Pdc_node 0 V=-i(Vvdd)*1.8

.control
* Run transient analysis for 40 cycles at 1 GHz
tran 10p 40n

* Measure average powers over the last 10 cycles (steady state)
meas tran Pout avg v(Pout_node) from=30n to=40n
meas tran Pin avg v(Pin_node) from=30n to=40n
meas tran Pdc avg v(Pdc_node) from=30n to=40n

* Calculate Metrics
let eff = (Pout / Pdc) * 100
let pae = ((Pout - Pin) / Pdc) * 100
let Pout_dBm = 10 * log10(Pout * 1000 + 1e-15)
let Gain_dB = 10 * log10((Pout + 1e-15) / (Pin + 1e-15))

print Pout
print Pout_dBm
print Pdc
print eff
print pae
print Gain_dB

quit
.endc
.end
