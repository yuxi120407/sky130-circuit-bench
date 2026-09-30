.param C0_val=1p
.param C1_val=1p
* Passive RC Filter Testbench
.param R1_val=22.7k Rx_val=22.7k C0_val=10p C1_val=10p Cx_val=10p

* DUT
R1 VDD N1 {R1_val}
Rx VDD Vcontr Rx_val
C0 VDD 0 {C0_val}
C1 N1 0 {C1_val}
Cx Vcontr 0 Cx_val

* Sources
* VDD includes a DC operating point, an AC source for bandwidth, and a small step for transient settling
VVDD VDD 0 dc 1.8 ac 1 pulse(1.8 1.9 1n 1n 1n 10u 20u)
VVCONTR Vcontr 0 dc 0.9

.control
  * 1. DC Operating Point & Power
  op
  * Power dissipated in the passive network
  let pwr = -i(VVDD)*1.8 - i(VVCONTR)*0.9
  print pwr
  
  * 2. AC Analysis for Bandwidth
  ac dec 100 1k 100Meg
  let gain_db = vdb(N1)
  meas ac bw_3db when gain_db=-3 fall=1
  
  * 3. Transient Analysis for Settling Time
  tran 10n 5u
  * Measure time to reach 90% of the 0.1V step (1.8V + 0.09V = 1.89V)
  meas tran t_settle trig v(VDD) val=1.85 rise=1 targ v(N1) val=1.89 rise=1
  
  quit
.endc
.end