* Level-Sensitive Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.subckt latch D CLK CLK_B Q VDD GND
XM1 N1 D CLK GND sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
XM2 N1 D CLK_B VDD sky130_fd_pr__pfet_01v8 w=2.0 l=0.15
XM3 Q_B N1 GND GND sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
XM4 Q_B N1 VDD VDD sky130_fd_pr__pfet_01v8 w=2.0 l=0.15
XM5 Q Q_B GND GND sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
XM6 Q Q_B VDD VDD sky130_fd_pr__pfet_01v8 w=2.0 l=0.15
XM7 N1 Q CLK_B GND sky130_fd_pr__nfet_01v8 w=1.0 l=0.15
XM8 N1 Q CLK VDD sky130_fd_pr__pfet_01v8 w=2.0 l=0.15
.ends

X1 D CLK CLK_B Q VDD 0 latch
X2 0 0 VDD Q_meta VDD 0 latch

VDD VDD 0 1.8
VCLK CLK 0 DC 1.8 PULSE(0 1.8 0 50p 50p 2n 4n)
VCLKB CLK_B 0 DC 0 PULSE(1.8 0 0 50p 50p 2n 4n)
VD D 0 DC 0 AC 1 PULSE(0 1.8 0.5n 50p 50p 2n 4n)

.control
* 1. AC Analysis for input capacitance
ac dec 10 1G 10G
let omega = 2 * 3.14159265359 * frequency
let c_in = mag(i(VD)) / omega
meas ac input_capacitance MAX c_in

* 2. Delay D to Q
alter @VCLK[pulse] = [ 1.8 1.8 0 0 0 20n 20n ]
alter @VCLKB[pulse] = [ 0 0 0 0 0 20n 20n ]
alter @VD[pulse] = [ 0 1.8 2n 50p 50p 5n 10n ]
tran 10p 8n
meas tran delay_d_to_q TRIG v(D) VAL=0.9 RISE=1 TARG v(Q) VAL=0.9 RISE=1

* 3. Setup Time
let t_fall = 3n
let t_d = 2.5n
let step = 10p
let setup_time = 0
while t_d <= 3.0n
  alter @VD[pulse] = [ 0 1.8 $&t_d 50p 50p 5n 10n ]
  alter @VCLK[pulse] = [ 1.8 0 $&t_fall 50p 50p 5n 10n ]
  alter @VCLKB[pulse] = [ 0 1.8 $&t_fall 50p 50p 5n 10n ]
  tran 10p 6n
  meas tran q_end FIND v(Q) AT=6n
  if $&q_end > 1.6
    let setup_time = t_fall - t_d
  else
    break
  end
  let t_d = t_d + step
end

* 4. Hold Time
let t_fall = 3n
let t_d_fall = 3.5n
let step = 10p
let hold_time = 0
while t_d_fall >= 2.5n
  let pw = t_d_fall - 1n - 50p
  alter @VD[pulse] = [ 0 1.8 1n 50p 50p $&pw 10n ]
  alter @VCLK[pulse] = [ 1.8 0 $&t_fall 50p 50p 5n 10n ]
  alter @VCLKB[pulse] = [ 0 1.8 $&t_fall 50p 50p 5n 10n ]
  tran 10p 6n
  meas tran q_end FIND v(Q) AT=6n
  if $&q_end > 1.6
    let hold_time = t_d_fall - t_fall
  else
    break
  end
  let t_d_fall = t_d_fall - step
end

* 5. Metastability Delay
alter @VD[pulse] = [ 0 0 0 0 0 20n 20n ]
alter @VCLK[pulse] = [ 0 0 0 0 0 20n 20n ]
alter @VCLKB[pulse] = [ 1.8 1.8 0 0 0 20n 20n ]
ic v(X2.N1)=0.85 v(X2.Q_B)=0.95 v(Q_meta)=0.85
tran 10p 5n uic
meas tran metastability_delay WHEN v(Q_meta)=0.2 FALL=1

print delay_d_to_q setup_time hold_time metastability_delay input_capacitance
.endc
.end