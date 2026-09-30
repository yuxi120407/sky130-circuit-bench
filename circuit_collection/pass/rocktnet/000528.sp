* Double-Sampling Extended-Counting ADC - Charge Amplifier Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.option rshunt=1e12

* Component Values
.param C1_val=1p C3_val=1p Cp_val=0.1p C2_val=1p CpL_val=0.1p

* DUT (Extracted Netlist)
I1 Vin GND 0
C1 Vin N1 {C1_val}
Cp N1 GND {Cp_val}
C3 N1 Vout {C3_val}
* Replaced A1 with standard subcircuit call X1
X1 N1 GND Vout amplifier
C2 Vout GND {C2_val}
CpL Vout GND {CpL_val}

* Op-amp Macro-model (GBW = 40MHz, DC Gain = 100dB)
.subckt amplifier in_m in_p out
  G1 0 int in_p in_m 1m
  R1 int 0 100MEG
  C1 int 0 3.98p
  E1 out 0 int 0 1
.ends

* Stimulus
* AC: 1V for Bode plot. Tran: 0V to 1V step for settling time.
VVIN Vin GND DC 0 AC 1 PULSE(0 1 10n 1n 1n 80n 200n)

.control
  * 1. AC Analysis
  ac dec 100 1k 1G
  let gain_db = vdb(Vout)
  
  * Measure low frequency gain
  meas ac Closed_Loop_Gain MAX gain_db
  
  * Measure -3dB bandwidth
  meas ac Bandwidth_3dB when gain_db='Closed_Loop_Gain - 3' fall=1

  * 2. Transient Analysis
  tran 0.1n 200n
  
  * Measure settling time (1% of final value)
  meas tran Settling_Time trig v(Vin) val=0.5 rise=1 targ v(Vout) val=-0.99 fall=1

  print Closed_Loop_Gain Bandwidth_3dB Settling_Time
.endc

.end