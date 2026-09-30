* Testbench for DAC cell
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_n=10.0
.param L_n=0.15
.param R_load=500
.param I_tail=1m

VDD VDD 0 DC 1.8

R1 VDD OUT1 {R_load}
R2 VDD OUT2 {R_load}

I1 N0 0 I_tail
I2 N1 0 I_tail

M1 OUT2 IN2 N1 0 sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
M2 OUT1 IN2X N1 0 sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
M3 OUT1 IN1 N0 0 sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
M4 OUT2 IN1X N0 0 sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}

VIN1 IN1 0 DC 0.9 AC 1 PULSE(0.7 1.1 100p 50p 50p 400p 1n)
VIN1X IN1X 0 DC 0.9 AC -1 PULSE(1.1 0.7 100p 50p 50p 400p 1n)
VIN2 IN2 0 DC 0.9 AC 0 PULSE(1.1 0.7 100p 50p 50p 400p 1n)
VIN2X IN2X 0 DC 0.9 AC 0 PULSE(0.7 1.1 100p 50p 50p 400p 1n)

E1 diff_out 0 OUT1 OUT2 1.0

.control
  * DC Operating Point
  op
  let power = -i(VDD) * 1.8
  print power

  * AC Analysis
  ac dec 50 1Meg 100G
  let gain_db = vdb(diff_out)
  meas ac dc_gain find gain_db at=1Meg
  meas ac bw when gain_db='dc_gain - 3' fall=1

  * Transient Analysis
  tran 1p 2n
  meas tran v_max max v(OUT1)
  meas tran v_min min v(OUT1)
  * Measure rise and fall times between 1.1V and 1.5V to ensure crossing
  meas tran t_fall trig v(OUT1) val=1.5 fall=1 targ v(OUT1) val=1.1 fall=1
  meas tran t_rise trig v(OUT1) val=1.1 rise=1 targ v(OUT1) val=1.5 rise=1
  
  quit
.endc
.end