* Voltage-Controlled Oscillator - Multi-point characterization
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_inv_n=0.5
.param L_inv_p=0.5
.param W_inv_n=5.0
.param W_inv_p=5.0
.global VDD GND
.temp 27

*** Stage 0 (10% weaker PMOS for symmetry breaking)
XMPINV0 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_inv_p} w={{{W_inv_p}*0.9}} m=1
XMNINV0 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_inv_n} w={W_inv_n} m=1

*** Stage 1
XMPINV1 N2 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_inv_p} w={W_inv_p} m=1
XMNINV1 N2 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_inv_n} w={W_inv_n} m=1

*** Stage 2
XMPINV2 N3 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_inv_p} w={W_inv_p} m=1
XMNINV2 N3 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_inv_n} w={W_inv_n} m=1

*** Stage 3
XMPINV3 N4 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_inv_p} w={W_inv_p} m=1
XMNINV3 N4 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_inv_n} w={W_inv_n} m=1

*** Stage 4
XMPINV4 N0 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_inv_p} w={W_inv_p} m=1
XMNINV4 N0 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_inv_n} w={W_inv_n} m=1

*** Load capacitors
C0 N0 GND cap_total
C1 N1 GND cap_total
C2 N2 GND cap_total
C3 N3 GND cap_total
C4 N4 GND cap_total

*** Power supply
VSUP VDD GND PWL(0 0 10n 1.8)

*** Symmetry breaking resistor
RBREAK N0 GND 10G


.control
* VCO characterization: sweep v_ctrl and measure frequency
let v_ctrl_points = 10
let v_ctrl_min = 0.0
let v_ctrl_max = 1.8
let v_ctrl_step = (v_ctrl_max - v_ctrl_min) / (v_ctrl_points - 1)

* Output file for results
set wr_singlescale
set wr_vecnames

* Loop over v_ctrl values
let i = 0
while i < v_ctrl_points
  * Calculate current v_ctrl
  let v_ctrl_current = v_ctrl_min + i * v_ctrl_step
  
  * Update capacitors based on v_ctrl
  let cap_base = 5e-15
  let cap_variable = (v_ctrl_current / 1.8) * 50e-15
  let cap_total_val = cap_base + cap_variable
  
  alter C0 = cap_total_val
  alter C1 = cap_total_val
  alter C2 = cap_total_val
  alter C3 = cap_total_val
  alter C4 = cap_total_val
  
  * Run transient simulation
  tran 1n 20u
  
  * Save results to files with index
  print v(N3) > vco_tran_$&i.txt
  print i(VSUP) > vco_current_$&i.txt
  
  * Increment counter
  let i = i + 1
end

quit
.endc

.end