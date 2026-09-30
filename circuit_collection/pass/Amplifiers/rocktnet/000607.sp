* Darlington-type Broadband Amplifier Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic NPN model for simulation since the netlist uses 'npn'
.model npn npn (is=1e-16 bf=100 tf=5p cje=20f cjc=20f)

* DUT (Resistor values appended for simulation)
R1 n1 label_net_0 500
R2 n12 GND 1k
R3 n2 GND 1k
R4 n9 GND 1k
R5 n3 label_net_1 500
R6 n5 label_net_2 1k
Q1 n7 n9 n0 npn
Q2 label_net_3 label_net_4 n2 npn
R7 n4 GND 1k
R8 n8 label_net_5 1k
Q3 n3 n2 n9 npn
R9 label_net_7 GND 1k
Q4 n0 label_net_8 GND npn
Q5 n10 n10 n8 npn
Q6 n3 n10 n7 npn
Q7 n1 n10 n6 npn
Q8 n10 n10 n12 npn
Q9 n1 n4 n5 npn
Q10 n6 n5 n0 npn
Q11 label_net_10 label_net_11 n4 npn

* Power Supplies (3.3V)
VCC0 label_net_0 0 3.3
VCC1 label_net_1 0 3.3
VCC3 label_net_3 0 3.3
VCC5 label_net_5 0 3.3
VCC10 label_net_10 0 3.3

* Ground Connections
VGND2 label_net_2 0 0
VGND7 label_net_7 0 0

* Bias Voltage for Tail Current Source (adjusted for ~1.8mA tail current)
VBIAS label_net_8 0 0.79

* Inject bias current into n10 to correct for Q5 NPN/PNP netlist typo and bias the cascodes
I_n10 label_net_0 n10 1.5m

* Differential Inputs (DC=2.7V, AC=0.5V, Tran=5GHz sine)
VINP label_net_4 0 dc 2.7 ac 0.5 sin(2.7 0.1 5G)
VINN label_net_11 0 dc 2.7 ac -0.5 sin(2.7 -0.1 5G)

.control
* 1. DC Operating Point & Power
op
let total_current = -(i(VCC0) + i(VCC1) + i(VCC3) + i(VCC5) + i(VCC10))
let power_consumption = total_current * 3.3
print power_consumption

* 2. AC Analysis for Gain and Bandwidth
ac dec 20 1Meg 100G
let vout_diff = v(n3) - v(n1)
let gain_db = db(vout_diff)
meas ac dc_gain find gain_db at=1Meg
meas ac bandwidth_3db when gain_db=(dc_gain-3) fall=1
print dc_gain bandwidth_3db

* 3. Transient Analysis for Voltage Swing
tran 2p 2n
let vout_diff_tran = v(n3) - v(n1)
meas tran transient_swing pp vout_diff_tran from=1n to=2n
print transient_swing

quit
.endc
.end