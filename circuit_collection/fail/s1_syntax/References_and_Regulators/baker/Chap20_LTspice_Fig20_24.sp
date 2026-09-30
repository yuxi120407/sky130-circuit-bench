* Testbench for Regulated Beta-Multiplier Current Reference (Fig 20.22)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for DUT sizing
.param W_xmsu2=10.0  L_xmsu2=20.0
.param W_xmsu1=50.0  L_xmsu1=2.0
.param W_xmsu3=10.0  L_xmsu3=1.0
.param W_xm3=100.0   L_xm3=2.0
.param W_xm4=100.0   L_xm4=2.0
.param W_xm1=50.0    L_xm1=2.0
.param W_xm2=200.0   L_xm2=2.0
.param W_xma4=100.0  L_xma4=2.0
.param W_xma3=100.0  L_xma3=2.0
.param W_xm5=50.0    L_xm5=2.0
.param W_xm6=50.0    L_xm6=2.0
.param W_xm7=100.0   L_xm7=100.0
.param W_xm8=100.0   L_xm8=100.0

* Power Supply (PULSE for transient, DC for bias/sweep)
VDD VDD 0 PULSE(0 1.8 10n 5n 5n 10u 20u) DC 1.8

* Current Reference Core (DUT as provided)
xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
xmsu1 N002 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
R1 N004 0 5500.0
xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 VDD 0 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 0 0 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}

.control
save all
save @m.xm1.msky130_fd_pr__nfet_01v8[gm]
save @m.xm1.msky130_fd_pr__nfet_01v8[vth]
save @m.xmsu3.msky130_fd_pr__nfet_01v8[id]

* 1. Operating Point Analysis at VDD = 1.8 V
op
let reference_current = v(N004) / 5500.0
let transconductance_gm = @m.xm1.msky130_fd_pr__nfet_01v8[gm]
let overdrive_voltage = v(Vbiasn) - @m.xm1.msky130_fd_pr__nfet_01v8[vth]
let vgs_difference = v(N004)
let voltage_regulation_error = abs(v(N003) - v(Vbiasn))
let startup_leakage_current = abs(@m.xmsu3.msky130_fd_pr__nfet_01v8[id])

print reference_current
print transconductance_gm
print overdrive_voltage
print vgs_difference
print voltage_regulation_error
print startup_leakage_current

* 2. DC Sweep: VDD variation from 0 to 1.8 V to determine VDDmin and Sensitivity
dc VDD 0 1.8 0.01
let iref_dc = v(N004) / 5500.0
let diff_iref = deriv(iref_dc)

meas dc v_nom find v(N004) at=1.8
let v_90_val = v_nom * 0.9
meas dc minimum_supply_voltage when v(N004)=$&v_90_val rise=1
meas dc supply_sensitivity find diff_iref at=1.8

print minimum_supply_voltage
print supply_sensitivity

* 3. Transient Analysis: Startup response when VDD is pulsed from 0 to 1.8 V
tran 1n 2u
let iref_tran = v(N004) / 5500.0

meas tran v_final find v(N004) at=1.9u
let v_90_tran_val = v_final * 0.9
meas tran startup_settling_time trig v(VDD) val=0.9 rise=1 targ v(N004) val=$&v_90_tran_val cross=last

print startup_settling_time

quit
.endc
.end