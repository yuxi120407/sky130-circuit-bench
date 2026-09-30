* Fully Differential Current-Mirror OTA Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm_tl=0.5
.param L_xm_tr=0.5
.param L_xmb1=0.5

* Parameters (W_xmb1 set to 10u to balance 10uA tail current with 5uA branches)
.param W_xm_tl=5.0 L_xm_tl=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xmb1=10.0 L_xmb1=0.5
.param W_xm_tr=5.0 L_xm_tr=0.5

* Power supply
VVDD VDD 0 1.8
VGND GND 0 0

* Bias circuit (generates ~10uA)
Ibias BIASING 0 10u
Xbias BIASING BIASING VDD VDD sky130_fd_pr__pfet_01v8 l=0.5 w=5.0

* Common-mode voltage
VCM VCM 0 0.9

* AC and Transient Input sources
VIND VIN_DIFF 0 DC 0 AC 1 PULSE(-0.2 0.2 1n 10p 10p 40n 80n)
E1 VIN_PLUS VCM VIN_DIFF 0 0.5
E2 VIN_MINUS VCM VIN_DIFF 0 -0.5

* Ideal CMFB to set output common-mode to 0.9V
Bcmfb1 VOUT_PLUS 0 I=1e-3*((v(VOUT_PLUS)+v(VOUT_MINUS))/2-0.9)
Bcmfb2 VOUT_MINUS 0 I=1e-3*((v(VOUT_PLUS)+v(VOUT_MINUS))/2-0.9)

* Load capacitors
CL1 VOUT_PLUS 0 1p
CL2 VOUT_MINUS 0 1p

* Differential output (swapped to ensure positive DC gain)
Eout VOUT_DIFF 0 VOUT_MINUS VOUT_PLUS 1

* DUT
XM_TL VOUT_MINUS BIASING VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm_tl} w={W_xm_tl}
XM1 N1 VIN_MINUS N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM4 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM6 VOUT_MINUS N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM5 VOUT_PLUS N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM3 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 N0 VIN_PLUS N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XMB1 N2 BIASING VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmb1} w={W_xmb1}
XM_TR VOUT_PLUS BIASING VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm_tr} w={W_xm_tr}

.control
  * Operating point
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1 1G
  let gain_db = db(v(VOUT_DIFF))
  let phase = 180/3.14159265359 * ph(v(VOUT_DIFF))
  let pm = 180 + phase
  
  meas ac dc_gain find gain_db at=1
  meas ac gbw when gain_db=0 fall=1
  meas ac phase_margin find pm when gain_db=0 fall=1
  
  print dc_gain gbw phase_margin

  * Transient Analysis
  tran 10p 80n
  meas tran sr_rise deriv v(VOUT_DIFF) when v(VOUT_DIFF)=0 rise=1
  meas tran sr_fall deriv v(VOUT_DIFF) when v(VOUT_DIFF)=0 fall=1
  let slew_rate = ($&sr_rise - $&sr_fall) / 2 / 1e6
  print slew_rate
  
  quit
.endc
.end