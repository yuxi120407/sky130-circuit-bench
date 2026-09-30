* Testbench for Two-Stage Folded Cascode Op-Amp

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_fb=0.5
.param L_xm0=0.5
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameters
.param W_xm0=5.0 L_xm0=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5

* DUT
XM0 N_TAIL VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm0} w={W_xm0}
XM1 N_FOLD1 VIP N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_FOLD2 VIN N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_FOLD1 N_FOLD1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N_FOLD2 N_FOLD1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_FOLD1 N_FOLD1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N_FOLD2 N_FOLD1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N_CASC1 VB2 N_FOLD1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N_CASC2 VB2 N_FOLD2 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N_CASC1 VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N_CASC2 VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 VOUT N_CASC2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 VOUT VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

* Biasing
VVDD VDD 0 1.8
VVB1 VB1 0 0.99
* VB2 adjusted from 0.54V to 1.2V to accommodate SKY130 higher Vth
VVB2 VB2 0 1.2

* Inputs and Feedback
* VIN is the non-inverting input, VIP is the inverting input
VVIN VIN 0 DC 0.9 AC 0 PULSE(0.9 1.3 10n 1n 1n 40n 100n)
L_fb VOUT VIP 1T
C_ac VAC VIP 1T
VAC VAC 0 DC 0 AC 1

* Load and Compensation
CL VOUT 0 1p
CC VOUT N_CASC2 1p

.control
  * 1. Operating Point & Power
  op
  let power_mw = -i(VVDD) * 1.8 * 1000
  print power_mw

  * 2. AC Analysis
  ac dec 100 1 1G
  let gain_db = vdb(VOUT)
  let phase = 180/PI * cph(v(VOUT))
  
  meas ac dc_gain_db find gain_db at=10
  meas ac gbw_hz when gain_db=0 fall=1
  meas ac pm_deg find phase when gain_db=0 fall=1
  
  print dc_gain_db gbw_hz pm_deg

  * 3. Transient Analysis (Configure as unity gain buffer)
  alter L_fb 1p
  alter C_ac 1f
  tran 100p 100n
  
  * Measure Slew Rate on the 0.9V to 1.3V step (measuring 1.0V to 1.2V)
  meas tran t_rise trig v(VOUT) val=1.0 rise=1 targ v(VOUT) val=1.2 rise=1
  let sr_rise_vus = 0.2 / t_rise / 1e6
  
  meas tran t_fall trig v(VOUT) val=1.2 fall=1 targ v(VOUT) val=1.0 fall=1
  let sr_fall_vus = 0.2 / t_fall / 1e6
  
  print sr_rise_vus sr_fall_vus
  
  quit
.endc
.end