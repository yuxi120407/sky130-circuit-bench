* Testbench for Cascode OTA (Fig 24.35) in SkyWater 130nm
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
.param L_xm3lb=0.5
.param L_xm3lt=0.5
.param L_xm3rb=0.5
.param L_xm3rt=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm5l=0.5
.param L_xm5r=0.5
.param L_xm6=0.5
.param L_xm6l=0.5
.param L_xm6r=0.5
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

* Default Transistor Sizing Parameters
.param L_default=0.15
.param W_p=10.0
.param W_n=5.0

* DUT Transistor Parameters
.param W_xm6r={W_p} L_xm6r={L_default}
.param W_xm6l={W_p} L_xm6l={L_default}
.param W_xm5r={W_p} L_xm5r={L_default}
.param W_xm5l={W_p} L_xm5l={L_default}
.param W_xm8={W_p}  L_xm8={L_default}
.param W_xm7={W_p}  L_xm7={L_default}

.param W_xm1={W_n}  L_xm1={L_default}
.param W_xm2={W_n}  L_xm2={L_default}
.param W_xm3rt={W_n} L_xm3rt={L_default}
.param W_xm3rb={W_n} L_xm3rb={L_default}
.param W_xm3lt={W_n} L_xm3lt={L_default}
.param W_xm3lb={W_n} L_xm3lb={L_default}
.param W_xm10={W_n} L_xm10={L_default}
.param W_xm12={W_n} L_xm12={L_default}
.param W_xm9={W_n}  L_xm9={L_default}
.param W_xm11={W_n} L_xm11={L_default}

* Bias Generator Subcircuit Parameters
.param W_xmsu1={W_n} L_xmsu1={L_default}
.param W_xmsu2={W_p} L_xmsu2={L_default}
.param W_xmsu3={W_n} L_xmsu3={L_default}
.param W_xmsu4={W_n} L_xmsu4={L_default}
.param W_xm3={W_p}   L_xm3={L_default}
.param W_xm4={W_p}   L_xm4={L_default}
.param W_xma1={W_p}  L_xma1={L_default}
.param W_xma2={W_p}  L_xma2={L_default}
.param W_xma3={W_p}  L_xma3={L_default}
.param W_xma4={W_p}  L_xma4={L_default}
.param W_xma5={W_p}  L_xma5={L_default}
.param W_xma6={W_p}  L_xma6={L_default}
.param W_xma7={W_p}  L_xma7={L_default}
.param W_xma8={W_p}  L_xma8={L_default}
.param W_xma9={W_p}  L_xma9={L_default}
.param W_xma10={W_p} L_xma10={L_default}
.param W_xma11={W_p} L_xma11={L_default}
.param W_xma12={W_p} L_xma12={L_default}
.param W_xm5={W_n}   L_xm5={L_default}
.param W_xm6={W_n}   L_xm6={L_default}
.param W_xm7={W_p}   L_xm7={L_default}
.param W_xm8={W_n}   L_xm8={L_default}
.param W_xm9={W_n}   L_xm9={L_default}
.param W_xm10={W_n}  L_xm10={L_default}
.param W_xm11={W_n}  L_xm11={L_default}
.param W_xm12={W_n}  L_xm12={L_default}
.param W_xm13={W_n}  L_xm13={L_default}
.param W_xm14={W_n}  L_xm14={L_default}
.param W_xm15={W_n}  L_xm15={L_default}
.param W_xm16={W_n}  L_xm16={L_default}
.param W_xm17={W_n}  L_xm17={L_default}
.param W_xm18={W_n}  L_xm18={L_default}

* Bias Generator Subcircuit
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

* Cascode OTA Core (DUT)
VDD VDD 0 1.8
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6r N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6r} l={L_xm6r}
xm1 N002 vp N004 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N003 vm N004 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3rt N004 Vbias3 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm3rt} l={L_xm3rt}
xm3rb N006 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3rb} l={L_xm3rb}
xm3lt N004 Vbias3 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm3lt} l={L_xm3lt}
xm3lb N005 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3lb} l={L_xm3lb}
xm10 Vout Vbias3 N008 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm12 N008 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm9 N001 Vbias3 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm11 N007 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm6l N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6l} l={L_xm6l}
xm5l N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5l} l={L_xm5l}
xm5r N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5r} l={L_xm5r}
xm8 Vout Vbias2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm7 N001 Vbias2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}

* Load and Fig. 24.34 Stability Feedback Elements
Cload Vout 0 1e-12
Cbig vm 0 0.0001
Rbig vm Vout 100000000.0

* Input Source (Common Mode = 0.9V with AC = 1 for AC analysis, Pulse for Slew Rate)
Vin vp 0 dc 0.9 ac 1 pulse(0.8 1.0 10n 1n 1n 100n 200n)

* Control Block for Automated Measurements
.control
* 1. Operating Point Analysis
op
let p_diss = -i(VDD) * 1.8
print p_diss

* 2. Open-Loop Frequency Response (AC Analysis)
ac dec 100 1 100MEG
let aol_db = vdb(Vout)
let phase_deg = 180/PI * cph(v(Vout))

meas ac gain_dc find aol_db at=10
let gain_3db_val = gain_dc - 3.0
meas ac f_3db when aol_db=gain_3db_val fall=1
meas ac fun when aol_db=0 fall=1
meas ac phase_at_unity find phase_deg when aol_db=0 fall=1
let phase_margin = 180 + phase_at_unity
print gain_dc f_3db fun phase_margin

* 3. Slew Rate Evaluation (Transient Analysis in Buffer Configuration)
* Swap vm feedback for transient tracking
alter Rbig = 1
tran 0.1n 50n
meas tran t_rise_start trig v(Vout) val=0.82 rise=1
meas tran t_rise_end   targ v(Vout) val=0.98 rise=1
let sr = (0.98 - 0.82) / (t_rise_end - t_rise_start) * 1e-6
print sr

quit
.endc
.end
