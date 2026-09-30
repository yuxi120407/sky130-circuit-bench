* Clocked Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameters
.param W_xm10=5.0 L_xm10=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm11=5.0 L_xm11=0.5

* DUT
XM10 N1 CLK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM8 N2 CLK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM18 N1 IN0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XM7 N5 OFFCTRL N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM16 N1 IN0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM3 N3 CLK GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 N2 INB0 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM15 N6 OFFCTRL N4 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM17 N2 INB0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM12 N4 CLK GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM4 OUT N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUT OUTB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM1 OUTB N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM14 OUTB OUT VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM9 OUT N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM13 OUT OUTB GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM6 OUTB N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM11 OUTB OUT GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

* Sources
VVDD VDD 0 1.8
VIN0 IN0 0 DC 0.9 AC 1
VINB0 INB0 0 DC 0.9 AC 0
VOFFCTRL OFFCTRL 0 DC 0
VCLK CLK 0 DC 0.9 PULSE(0 1.8 10p 10p 10p 490p 1n)

.control
* 1. AC Analysis (Biased at metastable point)
alter VCLK DC = 0.9
alter VIN0 DC = 0.9
alter VINB0 DC = 0.9
ac dec 10 1Meg 100G
let gain_db = db(v(out) - v(outb))
meas ac ac_gain find gain_db at=1G

* 2. Transient Analysis (1GHz Clocking)
alter VCLK DC = 0
alter VIN0 DC = 1.8
alter VINB0 DC = 0.0
tran 1p 3n
meas tran delay_clk_to_out trig v(clk) val=0.9 rise=1 targ v(out) val=0.9 rise=1
meas tran I_avg avg i(VVDD) from=0 to=3n
let power_dynamic = -$&I_avg * 1.8

* 3. Binary Search for Trip Point
alter VINB0 DC = 0.9
let v_high = 1.0
let v_low = 0.8
let iter = 0

while iter < 12
    let v_mid = (v_high + v_low) / 2
    alter VIN0 DC = $&v_mid
    tran 10p 3n
    meas tran out_max MAX v(out) from=1.3n to=1.5n
    let out_val = $&out_max
    if out_val > 1.5
        let v_high = v_mid
    else
        let v_low = v_mid
    end
    let iter = iter + 1
end
let trip_point = v_mid

print ac_gain delay_clk_to_out power_dynamic trip_point
quit
.endc
.end