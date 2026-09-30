* Testbench for Voltage-Limiting Switch
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

VVDD VDD 0 1.8
VCLK CLK 0 dc 1.8 pulse(0 1.8 1n 0.1n 0.1n 4.9n 10n)
VCLK_BAR CLK_BAR 0 dc 0 pulse(1.8 0 1n 0.1n 0.1n 4.9n 10n)

* DUT1 - Transient (Precharge and Clock Feedthrough)
XM1_t VDD CLK N4_t VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2_t N3_t CLK N4_t GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3_t N4_t CLK_BAR N3_t GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4_t N2_t CLK N3_t VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5_t N3_t CLK_BAR N2_t VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
C1_t N4_t 0 10f
C2_t N2_t 0 10f

* DUT2 - DC Sweep (Voltage Limiting Transfer Characteristic)
VN4_dc N4_dc 0 dc 0
XM1_dc VDD CLK N4_dc VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2_dc N3_dc CLK N4_dc GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3_dc N4_dc CLK_BAR N3_dc GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4_dc N2_dc CLK N3_dc VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5_dc N3_dc CLK_BAR N2_dc VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}

.control
* DC Sweep
dc VN4_dc 0 1.8 0.01
meas dc v_out_max MAX v(N2_dc)
meas dc v_out_min MIN v(N2_dc)
let v_swing = v_out_max - v_out_min
print v_out_max v_out_min v_swing

* Transient Analysis
tran 0.1n 20n
meas tran v_precharge_n2 FIND v(N2_t) AT=8n
meas tran v_glitch_max MAX v(N2_t) FROM=0.9n TO=2.0n
meas tran v_glitch_min MIN v(N2_t) FROM=0.9n TO=2.0n
let glitch_pp = v_glitch_max - v_glitch_min
print v_precharge_n2 glitch_pp

meas tran i_vdd_avg AVG i(VVDD) FROM=0 TO=20n
let power = -i_vdd_avg * 1.8
print power
quit
.endc
.end