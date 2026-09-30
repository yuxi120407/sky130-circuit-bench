* Baker Fig 23.13 Beta-Multiplier Voltage Reference Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm3t=0.5
.param L_xm4t=0.5
.param L_xma1=0.5
.param L_xma2=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions from Fig. 23.13
.param W_xmsu1=10.0  L_xmsu1=2.0
.param W_xmsu2=10.0  L_xmsu2=20.0
.param W_xmsu3=10.0  L_xmsu3=1.0
.param W_xm3t=100.0  L_xm3t=2.0
.param W_xm4t=100.0  L_xm4t=2.0
.param W_xm2=40.0    L_xm2=2.0
.param W_xm1=10.0    L_xm1=2.0
.param W_xma1=10.0   L_xma1=2.0
.param W_xma2=10.0   L_xma2=2.0
.param W_xma3=100.0  L_xma3=2.0
.param W_xma4=100.0  L_xma4=2.0
.param W_xm3=100.0   L_xm3=100.0

* Supply Voltage
VDD VDD 0 1.8

* Circuit Netlist (DUT)
xmsu1 N002 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
xm3t Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3t} l={L_xm3t}
xm4t VREF Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4t} l={L_xm4t}
xm2 VREF VREF N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
R1 N003 0 5500.0
xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
xma1 N001 VREF 0 0 sky130_fd_pr__nfet_01v8 w={W_xma1} l={L_xma1}
xma2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xma2} l={L_xma2}
xm3 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}

.control
* 1. Nominal Operating Point at 25C, VDD=1.8V
set temp=25
op
let vref_nominal = v(VREF)
let vbiasn_nom = v(Vbiasn)
let amplifier_offset = abs(vref_nominal - vbiasn_nom)
let iref_branch = v(N003) / 5500.0
let startup_margin = v(N002) - v(Vbiasn)

print vref_nominal
print amplifier_offset
print iref_branch
print startup_margin

* 2. Temperature Sweep for TC
dc temp 0 100 1
meas dc vref_0 find v(VREF) at=0
meas dc vref_100 find v(VREF) at=100
meas dc temperature_coefficient param='(vref_100 - vref_0) / 100.0'
print temperature_coefficient

* 3. VDD Sweep for Line Regulation and VDD_min
set temp=25
dc VDD 0 1.8 0.01
meas dc vref_at_1p2 find v(VREF) at=1.2
meas dc vref_at_1p8 find v(VREF) at=1.8
meas dc line_regulation param='(vref_at_1p8 - vref_at_1p2) / 0.6'
print line_regulation

meas dc vdd_min when v(VREF)=0.5 rise=1
print vdd_min

quit
.endc
.end