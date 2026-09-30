* Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

VVDD VDD 0 1.8
VN4 N4 0 1.8
VN5 N5 0 0

VCLK CLK 0 DC 1.8 PULSE(0 1.8 1n 0.1n 0.1n 10n 20n)
VIN IN 0 DC 0.9 AC 1
I_test OUT 0 10u
CLOAD OUT 0 1p

XM1 N6 CLK N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N6 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N6 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 CLK N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 IN N3 OUT GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT N6 IN GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

.control
  * AC Analysis for Bandwidth
  ac dec 10 1Meg 10G
  let gain_db = vdb(OUT)
  meas ac bw_high when gain_db=-3 fall=1
  
  * Transient Analysis for Ron and Power
  tran 0.1n 40n
  
  * Measure Ron when CLK is high (t=5n)
  meas tran v_in_high find v(IN) at=5n
  meas tran v_out_high find v(OUT) at=5n
  let ron_high = (v_in_high - v_out_high) / 10u
  print ron_high
  
  * Measure Ron when CLK is low (t=15n)
  meas tran v_in_low find v(IN) at=15n
  meas tran v_out_low find v(OUT) at=15n
  let ron_low = (v_in_low - v_out_low) / 10u
  print ron_low
  
  * Measure dynamic power of the clock buffer
  meas tran i_vdd_integ integ i(VN4) from=0 to=40n
  let avg_power = - (i_vdd_integ / 40n) * 1.8
  print avg_power
  
  quit
.endc
.end