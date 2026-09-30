* Common-Source Amplifier with Current-Source Load Testbench
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

.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=20.0 L_xm2=1.0
.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu2=5.0 L_xmsu2=1.0
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

VDD VDD 0 1.8
Vs Vs 0 dc 0 ac 1 pwl(0 0 100n 0 101n 0.5 500n 0.5 501n -0.5 1.5u -0.5)
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 Vout Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
R1 Vin Vout 1000000000.0
RS Vs N001 100000.0
C2 N001 Vin 1e-06
Cc Vin Vout 1e-12
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
op
let quiescent_bias_current = abs(@m.xm2.msky130_fd_pr__pfet_01v8[id])
let quiescent_power = -i(VDD) * 1.8
let gm1 = @m.xm1.msky130_fd_pr__nfet_01v8[gm]
let gds1 = @m.xm1.msky130_fd_pr__nfet_01v8[gds]
let open_circuit_gain = 20 * log10(gm1 / gds1)
let rhp_zero_fz = gm1 / (2 * 3.14159265359 * 1e-12)

print quiescent_bias_current
print quiescent_power
print open_circuit_gain
print rhp_zero_fz

ac dec 100 10 10G
let gain_db = vdb(Vout) - vdb(Vs)

meas ac small_signal_voltage_gain find gain_db at=100
let gain_3db = small_signal_voltage_gain - 3
meas ac input_pole_fin when gain_db=gain_3db fall=1
meas ac unity_gain_frequency when gain_db=0 fall=1

print small_signal_voltage_gain
print input_pole_fin
print unity_gain_frequency

tran 1n 1.5u
meas tran dt_sr trig v(Vout) val=0.5 rise=1 targ v(Vout) val=1.3 rise=1
let slew_rate = 0.8 / (dt_sr * 1e6)
print slew_rate

quit
.endc
.end