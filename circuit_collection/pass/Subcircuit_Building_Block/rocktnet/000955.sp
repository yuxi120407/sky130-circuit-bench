* PMOS Transistor Characterization Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5
XM1 GND LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}

VVDD VDD 0 dc 1.8
VLABEL_NET_0 LABEL_NET_0 0 dc 0 ac 1

.control
  * 1. DC Sweep for I-V characteristics
  dc VLABEL_NET_0 0 1.8 0.01
  
  * Current is measured from VVDD. Since current flows out of VVDD into the circuit, i(VVDD) is negative.
  let id = -i(VVDD)
  
  * I_off: Current when Vgate = 1.8V (Vsg = 0V)
  meas dc I_off find id at=1.8
  
  * I_on: Current when Vgate = 0V (Vsg = 1.8V)
  meas dc I_on find id at=0
  
  * Power consumption when fully on
  let power_on = I_on * 1.8
  print power_on
  
  * Vth: Gate voltage where Id crosses 1uA (falling as Vgate increases)
  meas dc Vg_at_1uA when id=1u fall=1
  let Vth_approx = 1.8 - Vg_at_1uA
  print I_off I_on Vth_approx
  
  * 2. AC Analysis for Gate Capacitance
  ac dec 10 1k 100Meg
  
  * Gate current from VLABEL_NET_0
  let ig = -i(VLABEL_NET_0)
  let omega = 2 * 3.1415926535 * frequency
  let cgate = imag(ig) / omega
  
  * Measure capacitance at 1 MHz
  meas ac C_gate_val find cgate at=1Meg
  print C_gate_val
  
  quit
.endc
.end
