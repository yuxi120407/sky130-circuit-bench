* Wide-Swing Cascode Current Mirror Simulation Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_n=0.5
.param L_n_ws=0.5
.param L_p=0.5
.param L_p_ws=0.5
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
.param L_xm6b=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmn=0.5
.param L_xmp=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Default W/L sizing parameters for SKY130
.param W_n=2.0 L_n=0.5
.param W_p=6.0 L_p=0.5
.param W_n_ws=0.5 L_n_ws=2.0
.param W_p_ws=1.5 L_p_ws=2.0

* DUT parameters
.param W_xm2={W_n} L_xm2={L_n}
.param W_xmn={W_n} L_xmn={L_n}
.param W_xm6b={W_p} L_xm6b={L_p}
.param W_xmp={W_p} L_xmp={L_p}

* SUB_1 parameters
.param W_xmsu1=1.0 L_xmsu1=2.0
.param W_xmsu2=1.0 L_xmsu2=2.0
.param W_xmsu3=1.0 L_xmsu3=2.0
.param W_xm1={W_n} L_xm1={L_n}
.param W_xm2={W_n} L_xm2={L_n}
.param W_xm3={W_p} L_xm3={L_p}
.param W_xm4={W_p} L_xm4={L_p}
.param W_xm5={W_p} L_xm5={L_p}
.param W_xm6={W_n} L_xm6={L_n}
.param W_xm7={W_p} L_xm7={L_p}
.param W_xm8={W_n} L_xm8={L_n}
.param W_xm9={W_p} L_xm9={L_p}
.param W_xm10={W_p} L_xm10={L_p}
.param W_xm11={W_p} L_xm11={L_p}
.param W_xm12={W_n_ws} L_xm12={L_n_ws}
.param W_xm13={W_n} L_xm13={L_n}
.param W_xm14={W_n} L_xm14={L_n}
.param W_xm15={W_p} L_xm15={L_p}
.param W_xm16={W_p} L_xm16={L_p}
.param W_xm17={W_p} L_xm17={L_p}
.param W_xm18={W_p} L_xm18={L_p}
.param W_xm19={W_p} L_xm19={L_p}
.param W_xm20={W_p} L_xm20={L_p}
.param W_xm21={W_p_ws} L_xm21={L_p_ws}
.param W_xm22={W_n} L_xm22={L_n}
.param W_xm23={W_n} L_xm23={L_n}
.param W_xm24={W_n} L_xm24={L_n}
.param W_xm25={W_n} L_xm25={L_n}
.param W_xm26={W_n} L_xm26={L_n}

* Circuit netlist
VDD VDD 0 1.8
xm2 N003 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
Vo N002 0 0.9
xmn N002 Vbias3 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmn} l={L_xmn}
xm6b N001 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6b} l={L_xm6b}
xmp N002 Vbias2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xmp} l={L_xmp}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1

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
* Operating point analysis
op
let quiescent_power = -i(VDD) * 1.8
print quiescent_power

* DC sweep of Vo from 0 to 1.8V to evaluate compliance and output resistance
dc Vo 0 1.8 0.005

* Calculate currents using KCL to isolate NMOS cascode current
* At Vo=1.8V, the PMOS cascode is off (Vds=0), so id_vdd is exactly I_SUB1
let id_vdd = -i(VDD)
meas dc I_SUB1 find id_vdd at=1.8
let i_xmn = id_vdd - $&I_SUB1 - i(Vo)

* Measure output current at mid-supply
meas dc output_current find i_xmn at=0.9

* Output resistance Ro = dVo / dIo
let ro_out = 1 / deriv(i_xmn)

* Measure output resistance at mid-supply
meas dc cascode_output_resistance find ro_out at=0.9

* Measure compliance voltage (where current drops by 10% from saturation level)
let i_xmn_target = 0.9 * $&output_current
meas dc minimum_output_voltage when i_xmn=$&i_xmn_target cross=1

print output_current cascode_output_resistance minimum_output_voltage
quit
.endc
.end