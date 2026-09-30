* VCO Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

VVDD VDD 0 1.8
VGND GND 0 0

* Biases
VVC VC 0 0.8
VVREP VREPLICA 0 0.8
VRST RST 0 1.8

* Inputs (Common mode 1.2V, 0.6Vpp swing for Tran, 1V diff for AC)
VVIP VI_PLUS 0 DC 1.2 AC 0.5 PULSE(0.9 1.5 1n 50p 50p 1n 2n)
VVIM VI_MINUS 0 DC 1.2 AC -0.5 PULSE(1.5 0.9 1n 50p 50p 1n 2n)

* DUT
XM1 VO_MINUS VI_PLUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VO_MINUS VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 VREPLICA GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VO_PLUS RST VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 VDD N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VO_PLUS VI_MINUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VO_PLUS VC VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 VO_MINUS VC VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Load capacitance (simulating next stage)
C1 VO_PLUS 0 10f
C2 VO_MINUS 0 10f

.control
* 1. Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* 2. AC Analysis
ac dec 100 1Meg 10G
* Single-ended gain in dB (input is 0.5V AC, so diff input is 1V)
let gain_se_db = vdb(VO_MINUS)
meas ac dc_gain_se find gain_se_db at=1Meg
meas ac bw when gain_se_db=0 fall=1

* 3. Transient Analysis
tran 10p 5n
* Measure delay at common-mode crossing (1.2V)
meas tran delay_fall trig v(VI_PLUS) val=1.2 rise=1 targ v(VO_MINUS) val=1.2 fall=1
meas tran delay_rise trig v(VI_PLUS) val=1.2 fall=1 targ v(VO_MINUS) val=1.2 rise=1

* Measure voltage swing
meas tran vout_max max v(VO_MINUS)
meas tran vout_min min v(VO_MINUS)
let swing = vout_max - vout_min
print swing

quit
.endc
.end