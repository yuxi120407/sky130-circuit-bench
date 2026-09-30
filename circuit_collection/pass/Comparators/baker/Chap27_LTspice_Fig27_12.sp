* Testbench for Rail-to-Rail Input Comparator (Figure 27.9)
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
.param L_xm3=0.5
.param L_xm31=0.5
.param L_xm4=0.5
.param L_xm41=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions matching Baker Fig. 27.9 sizing
.param W_xmsu3=10.0 L_xmsu3=2.0
.param W_xm31=20.0   L_xm31=1.0
.param W_xm41=20.0   L_xm41=1.0
.param W_xm2=10.0    L_xm2=1.0
.param W_xm1=10.0    L_xm1=1.0
.param W_xm3=20.0    L_xm3=1.0
.param W_xm4=20.0    L_xm4=1.0
.param W_xm5=10.0    L_xm5=1.0
.param W_xm6=10.0    L_xm6=1.0
.param W_xm7=10.0    L_xm7=1.0
.param W_xm8=10.0    L_xm8=1.0
.param W_xmsu1=10.0  L_xmsu1=10.0
.param W_xm9=20.0    L_xm9=1.0
.param W_xm10=20.0   L_xm10=1.0
.param W_xm11=20.0   L_xm11=1.0
.param W_xm12=10.0   L_xm12=1.0
.param W_xm13=10.0   L_xm13=1.0
.param W_xm14=20.0   L_xm14=1.0
.param W_xm15=10.0   L_xm15=1.0
.param W_xm16=10.0   L_xm16=1.0
.param W_xm17=10.0   L_xm17=1.0
.param W_xm18=10.0   L_xm18=1.0
.param W_xm19=10.0   L_xm19=1.0
.param W_xm20=20.0   L_xm20=2.0
.param W_xm21=20.0   L_xm21=1.0
.param W_xm22=20.0   L_xm22=1.0

* Bias circuit sizing
.param W_xmsu2=20.0  L_xmsu2=2.0

* Power Supplies
VDD VDD 0 DC 1.8

* Bias circuit subckt
.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xmsu3 VDD N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 Vbiasp Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 Vbiasp Vbiasn N002 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N002 GND 6.5k
.ends SUB_1

* Bias generator instance
X_U1 Vbiasn Vbiasp VDD 0 SUB_1

* Comparator Core (DUT)
xmsu3 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xm31 n1 n1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm31} l={L_xm31}
xm41 n2 n2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}
xm2 n2 vm N001 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 n1 vp N001 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}

xm3 vop n1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 vom n2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 vop vop N006 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 vop vom N006 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 vom vop N006 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 vom vom N006 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xmsu1 N006 N006 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}

xm9 N002 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 N005 vom N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm11 N003 vop N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 N005 N005 0 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 N003 N005 0 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm14 Out N003 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm14} l={L_xm14}
xm15 Out N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}

xm16 N008 N008 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 n2 N007 0 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 N007 N007 0 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 n1 N008 0 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
xm21 N007 vp N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 N008 vm N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}

* Load capacitance at output
CL Out 0 20f

* Input voltage sources
Vm vm 0 DC 0.9
Vp vp 0 DC 0.9 PULSE(0.85 0.95 100u 1n 1n 400u 1000u)

.control
* 1. Operating point analysis
op
let supply_current = -i(VDD)
print supply_current

* 2. DC Sweep for Gain, Offset, Output swing and Trip Point
dc Vp 0.7 1.1 0.1m
let gain_vec = deriv(v(Out))
meas dc voltage_gain max gain_vec
meas dc v_trip_up when v(Out)=0.9 cross=1
meas dc output_high_level max v(Out)
meas dc output_low_level min v(Out)

dc Vp 1.1 0.7 -0.1m
meas dc v_trip_dn when v(Out)=0.9 cross=1

meas dc systematic_offset param='(v_trip_up + v_trip_dn)/2 - 0.9'
meas dc hysteresis_voltage param='v_trip_up - v_trip_dn'

print voltage_gain systematic_offset hysteresis_voltage output_high_level output_low_level

* 3. Transient simulation for propagation delay
tran 10n 1000u
meas tran propagation_delay_lh trig v(vp) val=0.9 rise=1 targ v(Out) val=0.9 rise=1
meas tran propagation_delay_hl trig v(vp) val=0.9 fall=1 targ v(Out) val=0.9 fall=1

print propagation_delay_lh propagation_delay_hl
quit
.endc
.end