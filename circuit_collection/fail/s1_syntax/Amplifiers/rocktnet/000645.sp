* Differential TIA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_n=0.5

.param W_n=40.0 L_n=0.15

* Supply Voltages (Mapping netlist 'GND' to VDD and 'Vee' to 0V)
V_GND GND 0 DC 1.8
V_Vee Vee 0 DC 0

* Differential AC current input (1A total diff for direct Zt measurement in ohms)
I_in IN Vee DC 0 AC 0.5 SIN(0 10u 100MEG)
I_inq INQ Vee DC 0 AC -0.5 SIN(0 -10u 100MEG)

* Modified DUT: 'Q' replaced with 'M', 'npn' replaced with sky130 NMOS model
M1 GND N0 N2 Vee sky130_fd_pr__nfet_01v8 W='W_n' L='L_n'
M2 N2 N2 N7 Vee sky130_fd_pr__nfet_01v8 W='W_n' L='L_n'
I1 N12 Vee 1m
M3 N11 INQ N12 Vee sky130_fd_pr__nfet_01v8 W='W_n' L='L_n'
R1 Vee N10 1k
M4 GND N1 OUT Vee sky130_fd_pr__nfet_01v8 W='W_n' L='L_n'
R2 OUTQ Vee 1k
M5 GND N11 N1 Vee sky130_fd_pr__nfet_01v8 W='W_n' L='L_n'
M6 N1 N1 N10 Vee sky130_fd_pr__nfet_01v8 W='W_n' L='L_n'
R3 Vee N7 1k
R4 OUT Vee 1k
M7 N0 IN N12 Vee sky130_fd_pr__nfet_01v8 W='W_n' L='L_n'
R5 INQ N10 500
R6 N7 IN 500
M8 GND N2 OUTQ Vee sky130_fd_pr__nfet_01v8 W='W_n' L='L_n'
R7 N0 GND 200
R8 GND N11 200

.control
  * DC Operating Point and Power
  op
  let power = -i(V_GND) * 1.8
  print power
  print v(IN) v(N0) v(N12) v(OUT)

  * AC Analysis for Transimpedance Gain and Bandwidth
  ac dec 50 1MEG 100G
  let vdiff = v(OUT) - v(OUTQ)
  let gain_mag = mag(vdiff)
  let gain_db = 20 * log10(gain_mag)
  
  meas ac midband_gain_db find gain_db at=10MEG
  let gain_3db = midband_gain_db - 3
  meas ac bw_3db when gain_db=gain_3db fall=1
  
  * Transient Analysis
  tran 10p 20n
  meas tran vout_pp pp v(OUT)
  meas tran voutq_pp pp v(OUTQ)
  
  quit
.endc
.end