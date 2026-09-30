* RF Sampling Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_n=0.5

.param W_n=1.0 L_n=0.15

* DUT (Using M instead of T for ngspice compatibility)
M3 clk_i edge_i_bar clk_i GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
M1 clk_i edge_i_minus_1_bar clk_B GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
M2 clk_B edge_i_minus_1 clk_i GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}

* Biasing and Inputs
Vdd vdd GND 1.8
Vin clk_B GND dc 0.9 ac 1

* Clocks (Set up to force switch OFF during transient for charge injection measurement)
Vclk edge_i_minus_1 GND dc 1.8 pulse(1.8 0 2n 10p 10p 4n 10n)
Vclk_b edge_i_minus_1_bar GND dc 1.8 pulse(1.8 0 2n 10p 10p 4n 10n)
Vclk_dummy edge_i_bar GND dc 0 pulse(0 1.8 2n 10p 10p 4n 10n)

* Load Capacitor
Cload clk_i GND 100f

.control
* AC Analysis (Switch is ON due to DC 1.8V on clocks)
op
ac dec 100 1Meg 10Gig
let gain_db = vdb(clk_i)
meas ac insertion_loss find gain_db at=10Meg
meas ac bw_3db when gain_db=-3 fall=1

* Transient Analysis (Switch turns OFF at 2ns)
tran 1p 5n
meas tran v_steady find v(clk_i) at=1.9n
meas tran v_glitch_max max v(clk_i) from=1.9n to=3n
meas tran v_glitch_min min v(clk_i) from=1.9n to=3n

let max_error = v_glitch_max - v_steady
let min_error = v_steady - v_glitch_min
print max_error min_error

quit
.endc
.end