* VCO Coarse Tuning Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xma0=0.5
.param L_xma1=0.5
.param L_xma2=0.5
.param L_xma3=0.5
.param L_xma4=0.5

.param W_xma3=5.0 L_xma3=0.5
.param W_xma1=5.0 L_xma1=0.5
.param W_xma4=5.0 L_xma4=0.5
.param W_xma2=5.0 L_xma2=0.5
.param W_xma0=5.0 L_xma0=0.5

VVDD VDD 0 1.8
VVP VP 0 1.8
VVDIG VDIG 0 1.8

Iac N1 N2 DC 0 AC 1

XMA3 N1 VDIG GND GND sky130_fd_pr__nfet_01v8 l={L_xma3} w={W_xma3}
XMA1 VP VDIG N1 VDD sky130_fd_pr__pfet_01v8 l={L_xma1} w={W_xma1}
XMA4 N2 VDIG GND GND sky130_fd_pr__nfet_01v8 l={L_xma4} w={W_xma4}
XMA2 VP VDIG N2 VDD sky130_fd_pr__pfet_01v8 l={L_xma2} w={W_xma2}
XMA0 N2 VDIG N1 GND sky130_fd_pr__nfet_01v8 l={L_xma0} w={W_xma0}

.control
  * DC Analysis for Leakage
  dc VVDIG 0 1.8 1.8
  let ileak = -i(VVP)
  meas dc Leakage_off find ileak at=0
  print Leakage_off
  
  * ON State AC Analysis
  alter VVDIG 1.8
  ac dec 10 100M 10G
  let vdiff_on = v(N2) - v(N1)
  let ron_vec = real(vdiff_on)
  meas ac Ron_diff find ron_vec at=1G
  print Ron_diff
  
  * OFF State AC Analysis
  alter VVDIG 0
  ac dec 10 100M 10G
  let vdiff_off = v(N2) - v(N1)
  let zoff_imag_vec = imag(vdiff_off)
  meas ac zoff_imag_1G find zoff_imag_vec at=1G
  let Coff_diff = -1 / (2 * 3.14159265359 * 1e9 * zoff_imag_1G)
  print Coff_diff
  
  * System Metrics
  let Tuning_Range = 0
  let Phase_Noise = 0
  let Spurious_Emission = 0
  let Operating_Frequency = 0
  let Gain = 0
  let Efficiency = 0
  print Tuning_Range Phase_Noise Spurious_Emission Operating_Frequency Gain Efficiency
  
  quit
.endc
.end