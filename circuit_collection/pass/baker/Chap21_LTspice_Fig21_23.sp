* Common-Source Amplifier with Current-Source Load (Fig. 21.17)
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
.param L_xm25=0.5
.param L_xm26=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Sizing Parameters (Long-channel Baker sizing)
.param W_xm1=5.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu2=10.0 L_xmsu2=1.0
.param W_xmsu3=5.0 L_xmsu3=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=10.0 L_xm4=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=5.0 L_xm6=1.0
.param W_xm7=10.0 L_xm7=1.0
.param W_xm8=5.0 L_xm8=1.0
.param W_xm9=10.0 L_xm9=1.0
.param W_xm10=10.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=5.0 L_xm12=1.0
.param W_xm13=5.0 L_xm13=1.0
.param W_xm14=5.0 L_xm14=1.0
.param W_xm15=10.0 L_xm15=1.0
.param W_xm16=10.0 L_xm16=1.0
.param W_xm17=10.0 L_xm17=1.0
.param W_xm18=10.0 L_xm18=1.0
.param W_xm19=10.0 L_xm19=1.0
.param W_xm20=10.0 L_xm20=1.0
.param W_xm21=10.0 L_xm21=1.0
.param W_xm22=5.0 L_xm22=1.0
.param W_xm23=5.0 L_xm23=1.0
.param W_xm24=5.0 L_xm24=1.0
.param W_xm25=5.0 L_xm25=1.0
.param W_xm26=5.0 L_xm26=1.0

* DUT Circuit
VDD VDD 0 1.8
Vs Vs 0 dc 0 ac 1 pulse(0 0.5 10n 100p 100p 100n 300n)
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 Vout Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
R1 Vin Vout 1000000000.0
RS Vs N001 100000.0
C2 N001 Vin 1e-06
CL Vout 0 1p

.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 N002 N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 N002 Vbiasn N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N003 0 6.5k
  xm5 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
  xm6 Vbias2 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 N005 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8 Vbias1 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm9 Vbias1 Vbias2 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
  xm10 Vhigh Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
  xm11 Vncas Vbias2 Vhigh VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
  xm12 Vncas Vncas N009 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
  xm13 N009 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
  xm14 N010 N009 GND 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
  xm15 N006 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
  xm16 Vbias3 Vbias2 N006 VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
  xm17 N007 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
  xm18 Vbias4 Vbias2 N007 VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
  xm19 N008 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm19} l={L_xm19}
  xm20 N004 Vbias2 N008 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
  xm21 Vpcas Vpcas N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
  xm22 Vbias3 Vbias3 0 0 sky130_fd_pr__nfet_01v8 w={W_xm22} l={L_xm22}
  xm23 Vpcas Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
  xm24 N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
  xm25 Vbias4 Vbias3 Vlow 0 sky130_fd_pr__nfet_01v8 w={W_xm25} l={L_xm25}
  xm26 Vlow Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm26} l={L_xm26}
.ends SUB_1

.control
save all
save @m.xm1.msky130_fd_pr__nfet_01v8[id]
save @m.xm1.msky130_fd_pr__nfet_01v8[gm]
save @m.xm1.msky130_fd_pr__nfet_01v8[gds]
save @m.xm2.msky130_fd_pr__pfet_01v8[gds]
save @m.xm1.msky130_fd_pr__nfet_01v8[cgd]

* 1. DC Operating Point Analysis
op
let quiescent_current = @m.xm1.msky130_fd_pr__nfet_01v8[id]
let gds1 = @m.xm1.msky130_fd_pr__nfet_01v8[gds]
let gds2 = @m.xm2.msky130_fd_pr__pfet_01v8[gds]
let output_resistance = 1 / (gds1 + gds2 + 1e-12)
let gm1 = @m.xm1.msky130_fd_pr__nfet_01v8[gm]
let cgd1 = @m.xm1.msky130_fd_pr__nfet_01v8[cgd]
let rhp_zero_frequency = gm1 / (2 * pi * abs(cgd1) + 1e-18)

* 2. AC Analysis (100 Hz to 1000 GHz)
ac dec 100 100 1000G

let gain_db = db(v(Vout))
meas ac low_frequency_gain find gain_db at=100

let vin_db = db(v(Vin))
meas ac vin_mid find vin_db at=100
let vin_3db = vin_mid - 3.0
meas ac input_pole_frequency when vin_db=vin_3db fall=1

let core_gain_db = db(v(Vout)/v(Vin))
meas ac core_gain_mid find core_gain_db at=100
let core_gain_3db = core_gain_mid - 3.0
meas ac output_pole_frequency when core_gain_db=core_gain_3db fall=1

meas ac unity_gain_frequency when gain_db=0 fall=1
meas ac gain_at_400mhz find gain_db at=400MEG

* 3. Transient Slew Rate Analysis
tran 0.1n 300n
meas tran trise trig v(Vout) val=0.8 rise=1 targ v(Vout) val=1.0 rise=1
let slew_rate = 0.2 / trise / 1e6

* Print all metrics
print quiescent_current
print low_frequency_gain
print output_resistance
print input_pole_frequency
print output_pole_frequency
print rhp_zero_frequency
print unity_gain_frequency
print gain_at_400mhz
print slew_rate

quit
.endc
.end