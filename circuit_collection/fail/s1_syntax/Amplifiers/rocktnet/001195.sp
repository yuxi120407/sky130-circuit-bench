* Differential Emitter Follower Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic NPN model (since SKY130 is CMOS, we define a basic NPN for the netlist)
.model npn npn (is=1e-16 bf=100 cje=10f cjc=10f tf=10p)

.param I_bias=1m

* DUT
Q1 VCC IN+ N1 npn
Q2 VCC IN- N2 npn

* Bias Current Sources
I1 N1 0 I_bias
I2 N2 0 I_bias

* Voltage Sources
VCC VCC 0 1.8
VINp IN+ 0 DC 0.9 AC 1 SIN(0.9 0.1 10MEG 0 0)
VINn IN- 0 DC 0.9 AC 0 SIN(0.9 0.1 10MEG 180 0)

* Load Capacitance
C1 N1 0 10f
C2 N2 0 10f

.control
  * DC Operating Point
  op
  let power = -i(VCC) * 1.8
  print power
  let dc_offset = v(IN+) - v(N1)
  print dc_offset

  * AC Analysis
  ac dec 20 1k 100G
  meas ac low_freq_gain_db find vdb(N1) at=10k
  * Assuming near 0dB DC gain, measure -3dB bandwidth
  meas ac bw_3db when vdb(N1)=-3 fall=1

  * Transient Analysis
  tran 1n 200n
  meas tran vout_max max v(N1)
  meas tran vout_min min v(N1)
  meas tran vin_max max v(IN+)
  meas tran vin_min min v(IN+)
  let tran_gain = (vout_max - vout_min) / (vin_max - vin_min)
  print tran_gain
  
  quit
.endc
.end