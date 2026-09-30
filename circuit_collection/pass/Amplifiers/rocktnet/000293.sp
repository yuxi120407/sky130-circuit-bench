* Common-Source Amplifier with Miller Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param C1_val=100f
.param C2_val=200f
.param R1_val=2k
.param W_n=20.0
.param L_n=0.15

* DUT
C1 N0 GND {C1_val}
R1 VDD Vout {R1_val}
C2 N0 Vout {C2_val}
X1 N0 Vout amplifier

.subckt amplifier in out
XM1 out in GND GND sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
.ends

* Biasing and Sources
VVDD VDD GND 1.8
Vin N_in GND dc 0.6 ac 1
Rin N_in N0 1k

.control
  * DC Operating Point
  op
  let Power_Consumption = -i(VVDD) * 1.8
  print Power_Consumption

  * AC Analysis
  ac dec 100 1 10G
  let gain_db = db(v(Vout))
  meas ac DC_Gain find gain_db at=1
  meas ac Bandwidth_3dB when gain_db='DC_Gain - 3' fall=1
  
  print DC_Gain
  print Bandwidth_3dB
  
  quit
.endc
.end