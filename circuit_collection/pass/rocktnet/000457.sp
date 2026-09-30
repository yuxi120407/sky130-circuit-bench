* Frequency Divider Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_n=0.15
.param W_n=5.0
.param L_p=0.15
.param W_p=1.0

VVDD VDD 0 1.8
* 2 GHz Differential Clock (Period = 500ps)
VCLK CLK 0 PULSE(0 1.8 0 20p 20p 230p 500p)
VCLKBAR CLKBAR 0 PULSE(1.8 0 0 20p 20p 230p 500p)

* DUT
XMP1 N_L1 CLK VDD VDD sky130_fd_pr__pfet_01v8 l={L_p} w={W_p}
XMP2 N_L2 CLK VDD VDD sky130_fd_pr__pfet_01v8 l={L_p} w={W_p}
XMP3 N_R1 CLKBAR VDD VDD sky130_fd_pr__pfet_01v8 l={L_p} w={W_p}
XMP4 N_R2 CLKBAR VDD VDD sky130_fd_pr__pfet_01v8 l={L_p} w={W_p}

XMN1 N_L1 N_L2 N_TL1 GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}
XMN2 N_L2 N_L1 N_TL1 GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}
XMN3 N_TL1 CLKBAR GND GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}

XMN4 N_L1 N_R1 N_TL2 GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}
XMN5 N_L2 N_R2 N_TL2 GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}
XMN6 N_TL2 CLK GND GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}

XMN7 N_R1 N_R2 N_TR1 GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}
XMN8 N_R2 N_R1 N_TR1 GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}
XMN9 N_TR1 CLK GND GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}

XMN10 N_R1 N_L2 N_TR2 GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}
XMN11 N_R2 N_L1 N_TR2 GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}
XMN12 N_TR2 CLKBAR GND GND sky130_fd_pr__nfet_01v8 l={L_n} w={W_n}

* Load capacitors to simulate next stage
C1 N_L1 0 5f
C2 N_L2 0 5f
C3 N_R1 0 5f
C4 N_R2 0 5f

.ic v(N_L1)=1.8 v(N_L2)=0 v(N_R1)=1.8 v(N_R2)=0

.control
tran 5p 10n

* Measure output frequency (should be 1 GHz for a 2 GHz input)
meas tran t_period trig v(N_L1) val=0.9 rise=5 targ v(N_L1) val=0.9 rise=6
let operating_frequency = 1e-9 / t_period
print operating_frequency

* Measure average power consumption
meas tran pwr avg i(VVDD) from=2n to=10n
let power_consumption = -pwr * 1.8 * 1000
print power_consumption

* Measure output voltage swing
meas tran v_max max v(N_L1) from=2n to=10n
meas tran v_min min v(N_L1) from=2n to=10n
let output_voltage_swing = v_max - v_min
print output_voltage_swing

quit
.endc
.end