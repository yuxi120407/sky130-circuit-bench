* Testbench for Folded Cascode Op-Amp
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
.param L_xmfcnl=0.5
.param L_xmfcnr=0.5
.param L_xmfcpl=0.5
.param L_xmfcpr=0.5
.param L_xmon=0.5
.param L_xmop=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm3lb=5.0
.param W_xm3rb=5.0
.param W_xm3rt=5.0
.param W_xm5l=5.0
.param W_xm6=5.0
.param W_xm6l=5.0
.param W_xm6r=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xma1=5.0
.param W_xma10=5.0
.param W_xma11=5.0
.param W_xma2=5.0
.param W_xma3=5.0
.param W_xma4=5.0
.param W_xma5=5.0
.param W_xma6=5.0
.param W_xma7=5.0
.param W_xma9=5.0
.param W_xmfcnl=5.0
.param W_xmfcnr=5.0
.param W_xmfcpr=5.0
.param W_xmon=5.0
.param W_xmsu1=5.0
.param W_xmsu3=5.0

* Include the DUT (Replace with actual netlist file if needed)
* .include "dut.spice"

* Biasing and sources
* VDD is already defined in the netlist as: VDD VDD 0 1.8
Vcm vp 0 0.9
Vin_src Vin 0 dc 0.9 ac 1 pulse(0.4 1.4 10n 1n 1n 500n 1u)

* Dummy params to make the parameterized netlist compile
.param W_xm1=10 L_xm1=1 W_xm2=10 L_xm2=1 W_xm3rt=10 L_xm3rt=1 W_xm3rb=10 L_xm3rb=1
.param W_xm3lt=10 L_xm3lt=1 W_xm3lb=10 L_xm3lb=1 W_xm10=10 L_xm10=1 W_xm12=10 L_xm12=1
.param W_xm9=10 L_xm9=1 W_xm11=10 L_xm11=1 W_xm6l=20 L_xm6l=1 W_xm5l=20 L_xm5l=1
.param W_xm5r=20 L_xm5r=1 W_xm6r=20 L_xm6r=1 W_xm8=20 L_xm8=1 W_xm7=20 L_xm7=1
.param W_xmfcpl=10 L_xmfcpl=1 W_xmfcpr=10 L_xmfcpr=1 W_xmfcnr=5 L_xmfcnr=1 W_xmfcnl=5 L_xmfcnl=1
.param W_xmop=100 L_xmop=1 W_xmon=50 L_xmon=1
.param W_xmsu2=10 L_xmsu2=1 W_xmsu1=5 L_xmsu1=1 W_xmsu3=5 L_xmsu3=1 W_xm3=10 L_xm3=1
.param W_xm4=10 L_xm4=1 W_xma4=10 L_xma4=1 W_xma3=10 L_xma3=1
.param W_xm5=5 L_xm5=1 W_xm6=5 L_xm6=1 W_xma1=10 L_xma1=1 W_xma2=10 L_xma2=1
.param W_xmsu4=5 L_xmsu4=1 W_xma5=10 L_xma5=1 W_xma6=10 L_xma6=1 W_xma7=10 L_xma7=1
.param W_xma8=10 L_xma8=1 W_xma9=10 L_xma9=1 W_xma10=10 L_xma10=1 W_xma11=10 L_xma11=1
.param W_xma12=10 L_xma12=1 W_xm16=5 L_xm16=1 W_xm17=5 L_xm17=1 W_xm18=5 L_xm18=1
.param W_xm13=5 L_xm13=1 W_xm14=5 L_xm14=1 W_xm15=5 L_xm15=1

.control
  * 1. DC Operating Point
  op
  let power = -i(VDD) * 1.8
  print power

  * 2. AC Analysis (Extracting Open-Loop Gain from Closed-Loop)
  ac dec 100 1 1G
  * Open loop gain = Vout / (Vp - Vm). Since Vp is AC ground, it's Vout / (-Vm)
  let mag_vout = mag(v(Vout))
  let mag_vm = mag(v(vm))
  let gain_db = 20 * log10(mag_vout / mag_vm)
  let phase_deg = 180/PI * (cph(v(Vout)) - cph(v(vm)))
  
  meas ac dc_gain find gain_db at=10
  meas ac unity_gain_freq when gain_db=0 fall=1
  meas ac phase_at_ugf find phase_deg when gain_db=0 fall=1
  
  * Phase margin calculation (assuming phase_deg starts near 180 or -180 at DC)
  let pm = phase_at_ugf
  print pm

  * 3. Transient Analysis
  tran 1n 2u
  meas tran slew_rate_fall deriv v(Vout) when v(Vout)=0.9 fall=1
  meas tran slew_rate_rise deriv v(Vout) when v(Vout)=0.9 rise=1
  
  quit
.endc
.end