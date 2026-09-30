* Cascode OTA Testbench for SKY130 (Fig. 24.35)
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
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm31=0.5
.param L_xm4=0.5
.param L_xm41=0.5
.param L_xm5=0.5
.param L_xm51=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xma1=0.5
.param L_xma10=0.5
.param L_xma11=0.5
.param L_xma12=0.5
.param L_xma2=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xma5=0.5
.param L_xma6=0.5
.param L_xma7=0.5
.param L_xma8=0.5
.param L_xma9=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5

* Default transistor dimensions for sky130
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=10.0 L_xm4=1.0
.param W_xm31=10.0 L_xm31=1.0
.param W_xm41=10.0 L_xm41=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm51=10.0 L_xm51=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm6b=10.0 L_xm6b=1.0
.param W_xm7=10.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xm9=10.0 L_xm9=1.0
.param W_xm10=10.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm14=10.0 L_xm14=1.0

.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu2=5.0 L_xmsu2=1.0
.param W_xmsu3=5.0 L_xmsu3=1.0
.param W_xmsu4=5.0 L_xmsu4=1.0
.param W_xm1=5.0 L_xm1=1.0
.param W_xm2=5.0 L_xm2=1.0
.param W_xm3=5.0 L_xm3=1.0
.param W_xm4=5.0 L_xm4=1.0
.param W_xm5=5.0 L_xm5=1.0
.param W_xm6=5.0 L_xm6=1.0
.param W_xm7=5.0 L_xm7=1.0
.param W_xm8=5.0 L_xm8=1.0
.param W_xm9=5.0 L_xm9=1.0
.param W_xm10=5.0 L_xm10=1.0
.param W_xm11=5.0 L_xm11=1.0
.param W_xm12=5.0 L_xm12=1.0
.param W_xm13=5.0 L_xm13=1.0
.param W_xm14=5.0 L_xm14=1.0
.param W_xm15=5.0 L_xm15=1.0
.param W_xm16=5.0 L_xm16=1.0
.param W_xm17=5.0 L_xm17=1.0
.param W_xm18=5.0 L_xm18=1.0
.param W_xma1=10.0 L_xma1=1.0
.param W_xma2=10.0 L_xma2=1.0
.param W_xma3=10.0 L_xma3=1.0
.param W_xma4=10.0 L_xma4=1.0
.param W_xma5=10.0 L_xma5=1.0
.param W_xma6=10.0 L_xma6=1.0
.param W_xma7=10.0 L_xma7=1.0
.param W_xma8=10.0 L_xma8=1.0
.param W_xma9=10.0 L_xma9=1.0
.param W_xma10=10.0 L_xma10=1.0
.param W_xma11=10.0 L_xma11=1.0
.param W_xma12=10.0 L_xma12=1.0

* Bias Generation Subcircuit
.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 N004 N004 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N005 GND 5.5k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm6 Vbiasp N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xma1 Vbias3 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma1} l={L_xma1}
  xma2 Vbias4 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma2} l={L_xma2}
  xmsu4 Vbias3 Vbias3 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu4} l={L_xmsu4}
  xm8 Vbias4 Vbias3 Vlow 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm9 Vlow Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
  xm10 Vpcas Vbias3 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
  xm11 N009 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 Vbias2 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
  xm13 N010 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
  xm14 Vbias1 Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
  xm15 N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
  xma5 Vpcas Vpcas N006 VDD sky130_fd_pr__pfet_01v8 w={W_xma5} l={L_xma5}
  xma6 N006 Vbias2 N007 VDD sky130_fd_pr__pfet_01v8 w={W_xma6} l={L_xma6}
  xma7 N007 N006 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma7} l={L_xma7}
  xma8 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma8} l={L_xma8}
  xma9 Vbias1 Vbias2 Vhigh VDD sky130_fd_pr__pfet_01v8 w={W_xma9} l={L_xma9}
  xma10 Vhigh Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma10} l={L_xma10}
  xma11 Vncas Vbias2 N008 VDD sky130_fd_pr__pfet_01v8 w={W_xma11} l={L_xma11}
  xma12 N008 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma12} l={L_xma12}
  xm16 Vncas Vncas N012 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
  xm17 N012 Vbias3 P001 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
  xm18 P001 N012 0 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
.ends SUB_1

* DUT Instance
VDD VDD 0 DC 1.8
xm2 N002 vp N007 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 vm N007 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm3 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6b N010 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
xm51 N011 N008 0 0 sky130_fd_pr__nfet_01v8 w={W_xm51} l={L_xm51}
xm4 N006 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 N012 N008 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}

* DC Biasing and AC Stability Network (Fig. 24.34)
R1 vm Vout 100000000.0
C1 vm 0 0.0001
CL Vout 0 1e-12

xm31 N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm31} l={L_xm31}
xm41 N005 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}
xm6 N007 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 N009 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 N007 Vbias3 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 N008 Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 Vout Vbias3 N012 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 N008 Vbias2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 Vout Vbias2 N006 VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 N001 Vbias2 N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm13} l={L_xm13}
xm14 N002 Vbias2 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm14} l={L_xm14}

* Signal source on vp (non-inverting input)
Vin vp 0 DC 0.9 AC 1 PULSE(0.8 1.0 10n 1n 1n 5u 10u)

.control
* 1. Operating Point
op
let power_dissipation = -i(VDD) * 1.8
print power_dissipation

* 2. AC Open-Loop Analysis
ac dec 100 1 10G
let aol_db = db(v(Vout))
meas ac open_loop_gain MAX aol_db
meas ac dominant_pole_3dB_frequency when aol_db='open_loop_gain-3' fall=1
meas ac unity_gain_frequency when aol_db=0 fall=1

let transconductance = unity_gain_frequency * 2 * 3.1415926535 * 1e-12
print transconductance
print open_loop_gain
print dominant_pole_3dB_frequency
print unity_gain_frequency

* 3. Transient Slewing
tran 10n 5u
meas tran dt trig v(Vout) val=0.85 rise=1 targ v(Vout) val=0.95 rise=1
let slew_rate = 0.1 / dt / 1e6
let maximum_output_current = 0.1 / dt * 1e-12
print slew_rate
print maximum_output_current

quit
.endc
.end