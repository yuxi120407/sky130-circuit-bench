* Pseudo-differential OTA with CMFF Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_outm=0.5
.param L_outp=0.5
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

* Note: W_xm3 is set to 10u (2x W_xm4) to perfectly balance the CMFF DC currents and maximize CMRR.
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=10.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

* DUT
XM1 VOUTM VIP VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 VIM VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUTM N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 VOUTP VIM VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VOUTP N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 VIP VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

* Supplies
VVDD VDD 0 1.8
VVSS VSS 0 0

* DC Bias for outputs to prevent railing in open-loop
Vbias_out Vbias_out 0 0.9
* Replaced ideal CMFB with low-pass filtered CMFB using idt() to prevent AC loading
B_CM_LP V_CM_LP 0 V='idt( ( (v(VOUTP) + v(VOUTM))/2 - v(V_CM_LP) ) * 1e-3 )'
B_CM_P VOUTP 0 I='2m * (v(V_CM_LP) - v(Vbias_out))'
B_CM_M VOUTM 0 I='2m * (v(V_CM_LP) - v(Vbias_out))'
C_outp VOUTP 0 1p
C_outm VOUTM 0 1p

* Inputs (DC=0.6V, AC diff=1V, Tran=900mVpp diff at 30MHz)
V_in_cm in_cm 0 0.6 ac 0
V_in_d_p VIP in_cm dc 0 ac 0.5 sin(0 0.225 30Meg)
V_in_d_m VIM in_cm dc 0 ac -0.5 sin(0 -0.225 30Meg)

.control
  * 1. Operating Point & Power
  op
  let Power_Consumption = -i(VVDD) * 1.8
  print Power_Consumption
  print v(VOUTP) v(VOUTM) v(N1)

  * 2. Transient Analysis & THD
  tran 0.1n 2u 1.0001u
  let vdiff_tran = v(VOUTP) - v(VOUTM)
  linearize vdiff_tran
  set specwindow=rectangular
  fft vdiff_tran
  let mag_vdiff = mag(vdiff_tran)
  let fund = mag_vdiff[30]
  let h2 = mag_vdiff[60]
  let h3 = mag_vdiff[90]
  let h4 = mag_vdiff[120]
  let h5 = mag_vdiff[150]
  let h6 = mag_vdiff[180]
  let h7 = mag_vdiff[210]
  let h8 = mag_vdiff[240]
  let h9 = mag_vdiff[270]
  let THD = 20 * log10(sqrt(h2*h2 + h3*h3 + h4*h4 + h5*h5 + h6*h6 + h7*h7 + h8*h8 + h9*h9) / fund)
  print THD

  * 3. Differential AC Analysis
  ac dec 100 1 1G
  let vdiff = v(VOUTP) - v(VOUTM)
  let gain_diff_db = db(vdiff)
  let phase_diff = ph(vdiff)
  
  meas ac Differential_Gain find gain_diff_db at=100
  meas ac UGBW when gain_diff_db=0 fall=1
  meas ac phase_at_ugbw find phase_diff when gain_diff_db=0 fall=1

  * 4. Common-Mode AC Analysis
  alter V_in_d_p ac=0
  alter V_in_d_m ac=0
  alter V_in_cm ac=1
  ac dec 100 1 1G
  let vcomm = (v(VOUTP) + v(VOUTM))/2
  let gain_cm_db = db(vcomm)
  meas ac Acm_db find gain_cm_db at=100
  
  let cmrr_vec = ac1.gain_diff_db - gain_cm_db
  meas ac CMRR find cmrr_vec at=100
  
  print Differential_Gain
  print UGBW
  print Acm_db
  print CMRR
  
  quit
.endc
.end