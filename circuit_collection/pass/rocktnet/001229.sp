* Charge Pump Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

* NOTE: In this extracted netlist, VSS is the positive supply and VDD is ground
* based on the PMOS/NMOS bulk connections.
VVDD VDD 0 0
VVSS VSS 0 1.8

* Bias currents (50uA)
I_UP_BIAS IREF_SOURCE VDD 50u
I_DN_BIAS VSS IREF_SINK 50u

* Switches (Pulse for Tran, DC altered later)
V_VSOURCE VSOURCE 0 dc 1.8 pulse(1.8 0 5n 0.1n 0.1n 10n 40n)
V_VSINK VSINK 0 dc 0 pulse(0 1.8 20n 0.1n 0.1n 10n 40n)

* Output voltage source
V_ICP ICP 0 0.9

* DUT
XM2 IREF_SOURCE IREF_SOURCE VSS VSS sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM1 SOURCE IREF_SOURCE VSS VSS sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM4 ICP VSOURCE SOURCE VSS sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM3 ICP VSINK SINK VDD sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM5 IREF_SINK IREF_SINK VDD VDD sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 SINK IREF_SINK VDD VDD sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

.control
  * 1. Transient analysis
  tran 0.1n 40n
  let i_out = i(V_ICP)
  meas tran i_up_avg avg i_out from=6n to=14n
  meas tran i_down_avg avg i_out from=21n to=29n
  
  * 2. DC sweeps for compliance and leakage
  alter V_VSOURCE 0
  alter V_VSINK 0
  dc V_ICP 0 1.8 0.01
  let i_up = -i(V_ICP)
  meas dc i_up_09 find i_up at=0.9
  
  alter V_VSOURCE 1.8
  alter V_VSINK 1.8
  dc V_ICP 0 1.8 0.01
  let i_down = i(V_ICP)
  meas dc i_down_09 find i_down at=0.9
  
  alter V_VSOURCE 1.8
  alter V_VSINK 0
  dc V_ICP 0 1.8 0.01
  let i_leak = i(V_ICP)
  meas dc i_leak_09 find i_leak at=0.9
  
  quit
.endc
.end
