* Testbench for Self-Biased Two-Stage Amplifier from Baker Ch. 21
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
.param L_xma=0.5
.param L_xmb=0.5
.param L_xmc=0.5
.param L_xmd=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm2=5.0
.param W_xm20=5.0
.param W_xm21=5.0
.param W_xm23=5.0
.param W_xm24=5.0
.param W_xm25=5.0
.param W_xm26=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xmsu2=5.0
.param W_xmsu3=5.0

* Parameter definitions for long-channel sizing
.param W_xma=10.0 L_xma=1.0
.param W_xmb=10.0 L_xmb=1.0
.param W_xmc=20.0 L_xmc=1.0
.param W_xmd=20.0 L_xmd=1.0
.param W_xmsu1=10.0 L_xmsu1=1.0 W_xmsu2=20.0 L_xmsu2=1.0 W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm1=10.0 L_xm1=1.0 W_xm2=10.0 L_xm2=1.0 W_xm3=20.0 L_xm3=1.0 W_xm4=20.0 L_xm4=1.0
.param W_xm5=20.0 L_xm5=1.0 W_xm6=10.0 L_xm6=1.0 W_xm7=20.0 L_xm7=1.0 W_xm8=10.0 L_xm8=1.0 W_xm9=20.0 L_xm9=1.0
.param W_xm10=20.0 L_xm10=1.0 W_xm11=20.0 L_xm11=1.0 W_xm12=10.0 L_xm12=1.0 W_xm13=10.0 L_xm13=1.0 W_xm14=10.0 L_xm14=1.0
.param W_xm15=20.0 L_xm15=1.0 W_xm16=20.0 L_xm16=1.0 W_xm17=20.0 L_xm17=1.0 W_xm18=20.0 L_xm18=1.0
.param W_xm19=20.0 L_xm19=1.0 W_xm20=20.0 L_xm20=1.0 W_xm21=20.0 L_xm21=1.0
.param W_xm22=10.0 L_xm22=1.0 W_xm23=10.0 L_xm23=1.0 W_xm24=10.0 L_xm24=1.0 W_xm25=10.0 L_xm25=1.0 W_xm26=10.0 L_xm26=1.0

* Power Supply
VDD VDD 0 1.8

* AC / Transient Signal Source
Vs Vs 0 dc 0 ac 1 pulse(-0.05 0.05 50n 1n 1n 200n 400n)

* Core Amplifier Circuit (DUT)
xma n1 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xma} l={L_xma}
xmc n1 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmc} l={L_xmc}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
R1 Vin n1 1000000000.0
C2 Vs Vin 1e-06
xmb Vout n1 0 0 sky130_fd_pr__nfet_01v8 w={W_xmb} l={L_xmb}
xmd Vout Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmd} l={L_xmd}
Cc1 n1 Vout 1e-12
Cload Vout 0 1e-13

* Bias Subcircuit from Fig. 20.43
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
* 1. DC Operating Point Analysis
op
let dc_power_dissipation = -i(VDD) * 1.8

* 2. AC Frequency Response Analysis
ac dec 100 1 10G
let a_tot_db = vdb(Vout)
let a_stg1_db = vdb(n1)
let a_stg2_db = vdb(Vout) - vdb(n1)
let phase_out = 180/PI * cph(v(Vout))
let phase_stg2 = 180/PI * ph(v(Vout)/v(n1))

meas ac stage1_voltage_gain find a_stg1_db at=10
meas ac total_dc_gain find a_tot_db at=10
meas ac open_circuit_gain find a_stg2_db at=10

meas ac unity_gain_frequency when a_tot_db=0 fall=1
meas ac phase_dc find phase_out at=10
meas ac phase_at_ugf find phase_out when a_tot_db=0 fall=1
let phase_margin = 180 + phase_at_ugf - phase_dc

meas ac rhp_zero_frequency when phase_stg2=45 fall=1

* 3. Transient Analysis for Slew Rate
tran 1n 500n
meas tran sr_rise trig v(Vout) val=0.9 rise=1 targ v(Vout) val=1.3 rise=1
let slew_rate = (1.3 - 0.9) / (sr_rise * 1e6)

print stage1_voltage_gain total_dc_gain open_circuit_gain unity_gain_frequency rhp_zero_frequency phase_margin slew_rate dc_power_dissipation

quit
.endc
.end