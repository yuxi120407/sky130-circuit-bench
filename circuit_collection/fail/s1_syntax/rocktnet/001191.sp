* ISFET Readout Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_m5=0.5
.param L_m6=0.5
.param L_m7=0.5
.param L_n=0.5
.param L_p=0.5

.param W_n=2.0 L_n=1.0
.param W_p=4.0 L_p=1.0
.param W_m6=1.0 L_m6=10.0
.param W_m7=1.0 L_m7=10.0
.param W_m5=10.0 L_m5=1.0

VVDD VDD 0 1.8
VVSS Vss 0 0
VGND GND 0 0

Vset Vset 0 DC 1.2 AC 1 SIN(1.2 0.1 1Meg)

* DUT (T replaced with M for valid SPICE syntax)
I1 VDD N5 10u
M7 GND GND VDD VDD sky130_fd_pr__pfet_01v8 w={W_m7} l={L_m7}
Cc N1 GND 1p
M3d N2 N6 VDD VDD sky130_fd_pr__pfet_01v8 w={W_p} l={L_p}
M4a N1 N2 Vss GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
M8 N9 N5 Vss GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
M3a N7 N7 VDD VDD sky130_fd_pr__pfet_01v8 w={W_p} l={L_p}
M3c N1 N7 VDD VDD sky130_fd_pr__pfet_01v8 w={W_p} l={L_p}
M1b N3 Out N9 GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
M9 GND N5 Vss GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
M6 Out GND VDD VDD sky130_fd_pr__pfet_01v8 w={W_m6} l={L_m6}
M5 Vss N1 Out VDD sky130_fd_pr__pfet_01v8 w={W_m5} l={L_m5}
M2a N7 Out Out GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
M4b N2 N2 Vss GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
M3b N6 N6 VDD VDD sky130_fd_pr__pfet_01v8 w={W_p} l={L_p}
M10 N5 N5 Vss GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
M2b N6 Out N3 GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
M1a Out Vset N9 GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
C2 Out N9 1p

* Fix for floating nodes to help convergence
R_n1 N1 GND 1G
R_n7 N7 GND 1G

.control
  * OP Analysis
  op
  let power = -i(VVDD) * 1.8
  let v_out_dc = v(Out)
  let v_offset = v(Vset) - v(Out)
  print power v_out_dc v_offset

  * AC Analysis
  ac dec 100 1 1G
  let gain_db = vdb(Out)
  meas ac dc_gain_db find gain_db at=10
  meas ac bw_3db when gain_db=-3 fall=1

  * Transient Analysis
  tran 10n 5u
  meas tran v_max max v(Out)
  meas tran v_min min v(Out)
  meas tran pk_pk param='v_max - v_min'
  print pk_pk

  * DC Sweep
  dc Vset 0 1.8 0.01
  meas dc out_at_1v find v(Out) at=1.0
  meas dc out_at_1_5v find v(Out) at=1.5
  
  quit
.endc
.end
