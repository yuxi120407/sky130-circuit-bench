* NMOS Bootstrapped Inverter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmc=0.5
.param L_xmd=0.5
.param L_xmpd=0.5
.param L_xmpu=0.5

* Sizing based on Fig 18.40(a) ratios (Mpu is 4x longer, Mc is large)
.param W_xmpd=1.5 L_xmpd=0.15
.param W_xmpu=1.5 L_xmpu=0.6
.param W_xmc=1.5 L_xmc=1.5
.param W_xmd=1.5 L_xmd=0.15

* DUT
xmpd out in 0 0 sky130_fd_pr__nfet_01v8 w={W_xmpd} l={L_xmpd}
VDD VDD 0 1.8
xmc out boot out 0 sky130_fd_pr__nfet_01v8 w={W_xmc} l={L_xmc}
xmpu VDD boot out 0 sky130_fd_pr__nfet_01v8 w={W_xmpu} l={L_xmpu}
xmd VDD VDD boot 0 sky130_fd_pr__nfet_01v8 w={W_xmd} l={L_xmd}
Cload out 0 1e-14

* Stimulus: 
* 0 to 200ns: Input=0 (Allows circuit to settle to static state)
* 200ns to 300ns: Input=1.8V (Measures VOL and boot precharge)
* 300ns to 400ns: Input=0V (Measures dynamic VOH and boot peak)
Vin in 0 PWL(0 0 200n 0 201n 1.8 300n 1.8 301n 0 400n 0)

.control
tran 1n 400n uic

* Measure static metrics (before switching)
meas tran v_oh_static find v(out) at=190n
meas tran v_boot_static find v(boot) at=190n

* Measure metrics when input is high (output low)
meas tran v_ol min v(out) from=210n to=290n
meas tran v_boot_min min v(boot) from=210n to=290n

* Measure dynamic metrics when input goes low (output driven high)
meas tran v_oh_dynamic max v(out) from=310n to=390n
meas tran v_boot_max max v(boot) from=310n to=390n

quit
.endc
.end
