* Differential Delay Cell / Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5

* Parameters
.param W_xm15=5.0 L_xm15=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm12=5.0 L_xm12=0.5

* DUT
XM15 N1 N7 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM17 N1 N7 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM14 N0 N2 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM13 N2 N0 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM16 N3 N5 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM12 N3 N5 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

* Power Supplies
VVDD VDD 0 1.8
VGND GND 0 0
V_N6 N6 0 1.8
V_N4 N4 0 0

* Tie cross-coupled PMOS drains to inverter outputs
V_tie1 N0 N1 0
V_tie2 N2 N3 0

* Inputs (DC=0.9V for AC symmetry, Pulse for Tran)
V_in_plus N7 0 dc 0.9 ac 0.5 pulse(0 1.8 1n 0.1n 0.1n 4n 10n)
V_in_minus N5 0 dc 0.9 ac -0.5 pulse(1.8 0 1n 0.1n 0.1n 4n 10n)

* Load Capacitors
C1 N1 0 10f
C2 N3 0 10f

.control
  * 1. DC Operating Point
  op
  let power = -i(V_N6) * 1.8
  print power

  * 2. AC Analysis
  ac dec 100 1Meg 10G
  let vout_diff = v(N3) - v(N1)
  let gain_db = 20 * log10(mag(vout_diff))
  meas ac dc_gain find gain_db at=1Meg
  let gain_3db = dc_gain - 3
  meas ac bandwidth when gain_db=gain_3db fall=1

  * 3. Transient Analysis
  tran 10p 10n
  * Measure propagation delay (N5 falling -> N3 rising)
  meas tran prop_delay trig v(N5) val=0.9 fall=1 targ v(N3) val=0.9 rise=1
  * Measure rise time (20% to 80% of 1.8V)
  meas tran rise_time trig v(N3) val=0.36 rise=1 targ v(N3) val=1.44 rise=1
  
  quit
.endc
.end
