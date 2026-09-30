* Sense Amplifier Testbench
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
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm20=5.0 L_xm20=0.5
.param W_xm21=5.0 L_xm21=0.5
.param W_xm22=5.0 L_xm22=0.5
.param W_xm23=5.0 L_xm23=0.5
.param W_xm24=5.0 L_xm24=0.5

XM1 VDD SR_B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 IC N5 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LSA GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 RS1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 C3 N11 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 IC N7 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 C3 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 VDD RS0 SR_B GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 BCN N2 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 VDD IC T1 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N6 IT GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 QC VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 VDD VDD N3 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 IC VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 QT C3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 IT VDD N0 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N7 SR_B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM19 IT N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 VDD BTN N2 GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}
XM21 RS0 BC RS0 VDD sky130_fd_pr__pfet_01v8 l={L_xm21} w={W_xm21}
XM22 IT N5 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm22} w={W_xm22}
XM23 N11 N11 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm23} w={W_xm23}
XM24 RS0 BT VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm24} w={W_xm24}

VVDD VDD 0 1.8
VN5 N5 0 0
VLSA LSA 0 PULSE(0 1.8 1n 50p 50p 2n 5n)
VRS1 RS1 0 1.8
VBCN BCN 0 1.8
VBTN BTN 0 1.8
VBC BC 0 1.8
VBT BT 0 1.8

.control
let vbt_sweep = 1.8
let step = 0.02
let min_diff = 0
let found = 0

while vbt_sweep >= 0
    if found == 1
        break
    end
    alter VBT $&vbt_sweep
    tran 10p 5n
    
    meas tran ic_before find v(IC) at=0.9n
    meas tran ic_after find v(IC) at=3n
    let ic_drop = $&ic_before - $&ic_after
    
    if ic_drop < 0.1
        let min_diff = 1.8 - $&vbt_sweep
        let found = 1
    end
    let vbt_sweep = vbt_sweep - step
end

if found == 0
    let min_diff = 1.8
end

alter VBT 1.8
tran 10p 5n

let pwr = -i(VVDD)*1.8
meas tran average_power avg pwr from=0 to=5n

meas tran ic_init find v(IC) at=0.9n
meas tran ic_final find v(IC) at=3n
let ic_mid = ($&ic_init + $&ic_final) / 2
meas tran sense_delay trig v(LSA) val=0.9 rise=1 targ v(IC) val=$&ic_mid fall=1

let min_bitline_differential = min_diff
print sense_delay average_power min_bitline_differential
quit
.endc
.end