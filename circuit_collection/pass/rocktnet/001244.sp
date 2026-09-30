* PFD DFF Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 N3 CLK GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 QB N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 RESET GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 QB N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 RESET N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 CLK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

VVDD VDD 0 1.8
* 25.6 MHz clock -> period = 39.0625ns
VCLK CLK 0 PULSE(0 1.8 10n 100p 100p 10n 39.0625n)
VRST RESET 0 PULSE(1.8 0 5n 100p 100p 20n 39.0625n)

Cload QB 0 10f

.control
tran 10p 100n
let pwr_inst = -i(VVDD)*1.8
meas tran power_avg avg pwr_inst from=10n to=49.0625n
meas tran delay_clk_qb trig v(CLK) val=0.9 rise=1 targ v(QB) val=0.9 fall=1
meas tran delay_rst_qb trig v(RESET) val=0.9 rise=1 targ v(QB) val=0.9 rise=1
meas tran vdd_val max v(VDD)
meas tran clk_period trig v(CLK) val=0.9 rise=1 targ v(CLK) val=0.9 rise=2
print power_avg delay_clk_qb delay_rst_qb vdd_val clk_period
quit
.endc
.end
