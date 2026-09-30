* Testbench for Baker CMOS Op-Amp with CMFB and Offset (Fig. 26.45 / 26.43)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param W_xm1=5.0
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm19=5.0
.param W_xm2=5.0
.param W_xm20=5.0
.param W_xm21=5.0
.param W_xm22=5.0
.param W_xm23=5.0
.param W_xm24=5.0
.param W_xm25=5.0
.param W_xm26=5.0
.param W_xm27=5.0
.param W_xm28=5.0
.param W_xm29=5.0
.param W_xm3=5.0
.param W_xm30=5.0
.param W_xm31=5.0
.param W_xm32=5.0
.param W_xm33=5.0
.param W_xm34=5.0
.param W_xm35=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xma3=5.0
.param W_xma4=5.0
.param W_xmsu1=5.0
.param W_xmsu2=5.0
.param W_xmsu3=5.0

* W/L parameters based on Fig. 26.43 labeling (L=1.0, unlabeled NMOS=10u, PMOS=20u)
.param L_xm2=1.0 W_xm2=10.0
.param L_xm3=1.0 W_xm3=20.0
.param L_xm5=1.0 W_xm5=10.0
.param L_xm6=1.0 W_xm6=20.0
.param L_xm7=1.0 W_xm7=20.0
.param L_xm8=3.0 W_xm8=10.0
.param L_xm9=1.0 W_xm9=20.0
.param L_xm10=1.0 W_xm10=20.0
.param L_xm11=1.0 W_xm11=20.0
.param L_xm12=1.0 W_xm12=10.0
.param L_xm13=1.0 W_xm13=10.0
.param L_xm14=1.0 W_xm14=10.0
.param L_xm15=1.0 W_xm15=10.0
.param L_xm16=1.0 W_xm16=10.0
.param L_xm17=1.0 W_xm17=10.0
.param L_xm18=1.0 W_xm18=10.0
.param L_xm19=1.0 W_xm19=10.0
.param L_xm20=1.0 W_xm20=10.0
.param L_xm21=1.0 W_xm21=40.0
.param L_xm22=1.0 W_xm22=20.0
.param L_xm23=1.0 W_xm23=40.0
.param L_xm24=1.0 W_xm24=20.0
.param L_xm25=1.0 W_xm25=40.0
.param L_xm26=1.0 W_xm26=20.0
.param L_xm27=1.0 W_xm27=40.0
.param L_xm28=1.0 W_xm28=20.0
.param L_xm29=1.0 W_xm29=20.0
.param L_xm30=1.0 W_xm30=10.0
.param L_xm31=1.0 W_xm31=10.0
.param L_xm32=1.0 W_xm32=20.0
.param L_xm33=1.0 W_xm33=20.0
.param L_xm34=1.0 W_xm34=80.0
.param L_xm35=1.0 W_xm35=80.0
.param L_xm1=1.0 W_xm1=10.0
.param L_xm4=1.0 W_xm4=10.0

* Bias subcircuit parameters
.param L_xmsu1=1.0 W_xmsu1=10.0
.param L_xmsu2=1.0 W_xmsu2=20.0
.param L_xmsu3=1.0 W_xmsu3=10.0
.param L_xma3=1.0 W_xma3=20.0
.param L_xma4=1.0 W_xma4=20.0

* Power and Reference Supplies
VDD VDD 0 1.8
VCM VCM 0 900m

* Differential Inputs: DC at 900mV, with Pulse for Transient and AC for Bode
V_vip vip 0 DC 900m AC 0.5 Pulse(800m 1000m 5n 200p 200p 40n 100n)
V_vim vim 0 DC 900m AC -0.5 Pulse(1000m 800m 5n 200p 200p 40n 100n)

* --- Circuit Netlist (DUT from Figure 26.45) ---
xm2 N001 N001 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 vodm N004 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xm6 N001 N004 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 vodp N004 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 N004 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm11 N005 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 vodp N001 ncr 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 vodm N001 ncl 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm5 N009 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm14 N010 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N008 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm16 N008 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 ncr Vm N008 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 ncl N007 N008 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N006 VCM N009 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N004 VCM N010 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}
xm21 vom vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 N013 vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}
xm23 vom N013 N017 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 N013 N013 N016 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
C1 vom ncr 2.5e-14
xm25 vop vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm25} l={L_xm25}
xm26 N014 vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm26} l={L_xm26}
xm27 vop N014 N017 0 sky130_fd_pr__nfet_01v8 w={W_xm27} l={L_xm27}
xm28 N014 N014 N015 0 sky130_fd_pr__nfet_01v8 w={W_xm28} l={L_xm28}
C2 vop ncl 2.5e-14
R1 vop vcma 20000.0
R2 vcma vom 20000.0
C3 vop vcma 1e-14
C4 vcma vom 1e-14
xm29 N011 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm29} l={L_xm29}
xm30 VCMFB N012 0 0 sky130_fd_pr__nfet_01v8 w={W_xm30} l={L_xm30}
xm31 N012 N012 0 0 sky130_fd_pr__nfet_01v8 w={W_xm31} l={L_xm31}
xm32 N012 vcma N011 VDD sky130_fd_pr__pfet_01v8 w={W_xm32} l={L_xm32}
xm33 VCMFB VCM N011 VDD sky130_fd_pr__pfet_01v8 w={W_xm33} l={L_xm33}
xm34 N017 VCMFB 0 0 sky130_fd_pr__nfet_01v8 w={W_xm34} l={L_xm34}
xm35 N017 VCMFB 0 0 sky130_fd_pr__nfet_01v8 w={W_xm35} l={L_xm35}
R3 vop vm 20000.0
R4 vm vip 20000.0
R5 vom vp 20000.0
R6 vp vim 20000.0
C5 vop 0 2.5e-13
C6 vom 0 2.5e-13
xm1 N015 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N016 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
VOS Vp N007 50m

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__pfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  R1 N004 0 4k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
.ends SUB_1

* Control Block for Measurements
.control
* 1. Operating Point Analysis
op
let differential_output_offset = v(vop) - v(vom)
let output_cm_voltage = (v(vop) + v(vom)) / 2
let single_ended_output_vop = v(vop)
let single_ended_output_vom = v(vom)
let op_amp_inverting_input_voltage = v(vm)
let quiescent_current_vdd = -i(VDD)
let power_dissipation = quiescent_current_vdd * 1.8

print differential_output_offset
print output_cm_voltage
print single_ended_output_vop
print single_ended_output_vom
print op_amp_inverting_input_voltage
print quiescent_current_vdd
print power_dissipation

* 2. AC Frequency Response Analysis
ac dec 50 1 10G
let diff_out = v(vop) - v(vom)
let diff_in = v(N007) - v(vm)
let open_loop_gain = diff_out / diff_in
let diff_gain_db = db(open_loop_gain)

meas ac differential_dc_gain find diff_gain_db at=1
meas ac unity_gain_frequency when diff_gain_db=0 fall=1

print differential_dc_gain
print unity_gain_frequency

* 3. Transient Step Response Analysis
tran 50p 90n 0n
let vdiff = v(vop) - v(vom)
let vin_diff = v(vip) - v(vim)

meas tran vfinal find vdiff at=40n
meas tran vstart find vdiff at=4n
let v_thresh = $&vfinal - 0.01 * ($&vfinal - $&vstart)
meas tran settling_time trig vin_diff val=0 rise=1 targ vdiff val=$&v_thresh cross=LAST from=5n to=40n

print settling_time

quit
.endc
.end