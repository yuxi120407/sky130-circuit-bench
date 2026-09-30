* Auto-zeroed Comparator Preamplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.15

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=0.5 L_xm3=0.15

XM1 N1 N2 LABEL_NET_0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_2 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_5 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0
VLABEL_NET_2 LABEL_NET_2 0 0.9

* Switch control: DC 0 for AC analysis, Pulse for Tran
* Pulse: ON (1.8V) for 40ns, then OFF (0V) for 210ns
V_sw LABEL_NET_5 0 DC 0 PULSE(1.8 0 40n 1n 1n 210n 250n)

* Input signal: DC 0.6V, AC 1V, Step 10mV at 150ns
V_in Vin_node 0 DC 0.6 AC 1 PULSE(0.6 0.61 150n 1n 1n 90n 250n)
C_in Vin_node N2 1p

* DC feedback resistor for AC analysis (acts as open circuit for Tran due to 10G * 1p = 10ms time constant)
Rbias N1 N2 10G

* Load capacitor to simulate next stage
C_load N1 0 50f

.control
* 1. DC Operating Point
op
let power_consumption = -i(VVDD) * 1.8 - i(VLABEL_NET_1) * 1.8
print power_consumption

* 2. AC Analysis
ac dec 100 1k 10G
let gain_db = vdb(N1) - vdb(N2)
meas ac dc_gain find gain_db at=1k
meas ac unity_gain_bw when gain_db=0 fall=1
print dc_gain
print unity_gain_bw

* 3. Transient Analysis
tran 0.1n 250n
* Measure auto-zero voltage (switch is ON)
meas tran auto_zero_trip_point find v(N1) at=20n
* Measure output base voltage before step (switch is OFF)
meas tran v_out_base find v(N1) at=145n
* Measure output peak voltage after step (switch is OFF)
meas tran v_out_peak find v(N1) at=190n
print auto_zero_trip_point
print v_out_base
print v_out_peak

quit
.endc
.end