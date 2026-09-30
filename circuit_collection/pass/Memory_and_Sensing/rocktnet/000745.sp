* High-Performance Very Low-Voltage Current Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

* DUT
XM1 BL BL GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT1 BL GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 VREF GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 BL N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT1 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

* Power and Bias
VVDD VDD 0 1.8
VVREF VREF 0 0.9

* Reference Current at OUT1 (40uA sink to GND)
I_REF OUT1 0 40u

* Memory Cell Current at BL (Controlled by V_CELL_CTRL)
* 1V on ctrl = 100uA cell current sinking from BL
V_CELL_CTRL ctrl 0 PWL(0 0.0 1n 0.0 2n 0.8 10n 0.8 11n 0.0)
G_CELL BL 0 ctrl 0 100u

* Load Capacitance at Output
C_LOAD OUT1 0 50f

.control
  * 1. DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption
  let bitline_voltage = v(BL)
  print bitline_voltage

  * 2. DC Sweep for Switching Threshold
  dc V_CELL_CTRL 0 0.8 0.01
  meas dc switch_threshold_v when v(OUT1)=0.9
  let switching_threshold = switch_threshold_v * 100u
  print switching_threshold

  * 3. Transient Analysis for Delay
  tran 10p 20n
  * Measure delay from cell current crossing 40uA (ctrl=0.4V) to OUT1 crossing VDD/2 (0.9V)
  meas tran read_delay trig v(ctrl) val=0.4 rise=1 targ v(OUT1) val=0.9 rise=1
  print read_delay
  
  quit
.endc
.end