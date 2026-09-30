* Charge Pump Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

VDD VDD 0 DC 1.8
Vosc node_osc 0 PULSE(0 1.8 0 100p 100p 5n 10n)

* Inverter
XM3 node_inv_out node_osc VDD VDD sky130_fd_pr__pfet_01v8 w=10.0 l=0.15
XM4 node_inv_out node_osc 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15

* Pump capacitor
C1 node_inv_out node_a 1p

* Diode-connected NMOS
XM1 VDD VDD node_a 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM2 node_a node_a vout 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15

* Load capacitor
C2 vout 0 10p

.tran 100p 200n

.control
run
meas tran node_a_low_voltage MIN v(node_a) from=180n to=200n
meas tran node_a_high_voltage MAX v(node_a) from=180n to=200n
meas tran steady_state_output_voltage MAX v(vout) from=180n to=200n
let target_v = steady_state_output_voltage * 0.95
meas tran startup_time WHEN v(vout)=$&target_v RISE=1
print node_a_low_voltage node_a_high_voltage steady_state_output_voltage startup_time
.endc
.end