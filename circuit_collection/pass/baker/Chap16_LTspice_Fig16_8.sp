* NMOS Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Circuit Netlist
XM1 BL BLB SAN 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM2 BLB BL SAN 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM3 SAN SAE 0 0 sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
XM4 BL EQ Vpre 0 sky130_fd_pr__nfet_01v8 w=2.0 l=0.15
XM5 BLB EQ Vpre 0 sky130_fd_pr__nfet_01v8 w=2.0 l=0.15
XM6 BL EQ BLB 0 sky130_fd_pr__nfet_01v8 w=2.0 l=0.15
XM7 Vcell WL BL 0 sky130_fd_pr__nfet_01v8 w=1.0 l=0.15

C_BL BL 0 1p
C_BLB BLB 0 1p
C_cell Vcell 0 50f

S1 Vcell VDD init 0 switch_model
.model switch_model sw(vt=0.9 vh=0.1 ron=1 roff=1g)

* Stimuli
VDD VDD 0 1.8
Vpre Vpre 0 0.9
Vinit init 0 PULSE(1.8 0 5n 10p 10p 100n 200n)
VEQ EQ 0 PULSE(1.8 0 10n 10p 10p 40n 200n)
VWL WL 0 PULSE(0 1.8 20n 10p 10p 30n 200n)
VSAE SAE 0 PULSE(0 1.8 30n 10p 10p 20n 200n)

.control
op
let total_charge = 50e-15 * v(Vcell) + 1e-12 * v(BL) + 1e-12 * v(BLB)
print total_charge

tran 10p 100n
meas tran final_bitline_voltage find v(BL) at=29n
meas tran vbl_initial find v(BL) at=19n
let delta_v_bit = final_bitline_voltage - vbl_initial
print delta_v_bit

meas tran avg_i_vdd avg i(VDD) from=0 to=100n
meas tran avg_i_vpre avg i(Vpre) from=0 to=100n
let average_power = -(avg_i_vdd * 1.8 + avg_i_vpre * 0.9)
print average_power
.endc
.end