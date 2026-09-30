* Testbench for Pre-amp and Decision Circuit (Baker Fig. 27.5)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm31=0.5
.param L_xm4=0.5
.param L_xm41=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions matching Fig. 27.5 / Ex. 27.1
.param W_xmsu3=20.0 L_xmsu3=2.0
.param W_xm31=30.0  L_xm31=2.0
.param W_xm41=30.0  L_xm41=2.0
.param W_xm2=10.0   L_xm2=2.0
.param W_xm1=10.0   L_xm1=2.0
.param W_xm3=30.0   L_xm3=2.0
.param W_xm4=30.0   L_xm4=2.0
.param W_xm5=10.0   L_xm5=1.0
.param W_xm6=12.0   L_xm6=1.0
.param W_xm7=12.0   L_xm7=1.0
.param W_xm8=10.0   L_xm8=1.0

* Parameters for SUB_1 reference
.param W_xmsu2=5.0  L_xmsu2=2.0
.param W_xmsu1=5.0  L_xmsu1=2.0

* Circuit Netlist (DUT)
VDD VDD 0 1.8
xmsu3 N003 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xm31 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm31} l={L_xm31}
xm41 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}
xm2 N001 vm N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N002 vp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
Vp vp 0 0.9
Vm vm 0 0.9
xm3 vop N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 vom N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 vop vop 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 vop vom 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 vom vop 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 vom vom 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 VDD N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 Vbiasp Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 Vbiasp Vbiasn N002 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N002 GND 6.5k
.ends SUB_1

* Dynamic stimulus for hysteresis extraction via slow triangular wave
Vp_dyn vp_dyn 0 PWL(0 0.8 100u 1.0 200u 0.8)
Bvp vp 0 V = v(vp_dyn)

.control
* 1. Operating Point to check Iss tail current
op
let iss_val = @m.xmsu3.msky130_fd_pr__nfet_01v8[id]
print iss_val

* 2. Transient analysis over triangular sweep to capture hysteresis
tran 100n 200u

* Differential output
let vdiff = v(vop) - v(vom)
let vid = v(vp) - v(vm)

* Forward switching (vp ramping up: 0 to 100us)
meas tran vsph_time when vdiff=0 rise=1
meas tran vsph find vid at=vsph_time

* Reverse switching (vp ramping down: 100us to 200us)
meas tran vspl_time when vdiff=0 fall=1
meas tran vspl find vid at=vspl_time

* Hysteresis calculation
let vhys = vsph - vspl
print vsph vspl vhys

* 3. Max output high level of decision circuit
meas tran voh_max max v(vop)
print voh_max

quit
.endc
.end
