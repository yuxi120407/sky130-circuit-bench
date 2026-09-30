* Testbench for Pseudo-Differential Op-Amp

.param W_xm10=5.0 L_xm10=0.5
.param W_xm11p=5.0 L_xm11p=0.5
.param W_xm9p=5.0 L_xm9p=0.5
.param W_xm5p=5.0 L_xm5p=0.5
.param W_xm7p=5.0 L_xm7p=0.5
.param W_xm7n=5.0 L_xm7n=0.5
.param W_xm5n=5.0 L_xm5n=0.5
.param W_xm9n=5.0 L_xm9n=0.5
.param W_xm11n=5.0 L_xm11n=0.5
.param W_xm12p=5.0 L_xm12p=0.5
.param W_xm8p=5.0 L_xm8p=0.5
.param W_xm2p=5.0 L_xm2p=0.5
.param W_xm1p=5.0 L_xm1p=0.5
.param W_xm3p=5.0 L_xm3p=0.5
.param W_xm4p=5.0 L_xm4p=0.5
.param W_xm6p=5.0 L_xm6p=0.5
.param W_xm6n=5.0 L_xm6n=0.5
.param W_xm1n=5.0 L_xm1n=0.5
.param W_xm2n=5.0 L_xm2n=0.5
.param W_xm3n=5.0 L_xm3n=0.5
.param W_xm4n=5.0 L_xm4n=0.5
.param W_xm8n=5.0 L_xm8n=0.5
.param W_xm12n=5.0 L_xm12n=0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT
XM10 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11P VOUTN N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11p} w={W_xm11p}
XM9P N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9p} w={W_xm9p}
XM5P N4 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5p} w={W_xm5p}
XM7P N5 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7p} w={W_xm7p}
XM7N N6 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7n} w={W_xm7n}
XM5N N7 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5n} w={W_xm5n}
XM9N N8 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9n} w={W_xm9n}
XM11N VOUTP N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11n} w={W_xm11n}
XM12P VOUTN N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12p} w={W_xm12p}
XM8P N3 VDD N10 GND sky130_fd_pr__nfet_01v8 l={L_xm8p} w={W_xm8p}
XM2P N10 GND N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm2p} w={W_xm2p}
XM1P N11 VINP N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm1p} w={W_xm1p}
XM3P N11 N11 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3p} w={W_xm3p}
XM4P N10 N11 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4p} w={W_xm4p}
XM6P N5 VDD N11 GND sky130_fd_pr__nfet_01v8 l={L_xm6p} w={W_xm6p}
XM6N N6 VDD N12 GND sky130_fd_pr__nfet_01v8 l={L_xm6n} w={W_xm6n}
XM1N N12 VINN N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm1n} w={W_xm1n}
XM2N N13 GND N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm2n} w={W_xm2n}
XM3N N12 N12 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3n} w={W_xm3n}
XM4N N13 N12 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4n} w={W_xm4n}
XM8N N8 VDD N13 GND sky130_fd_pr__nfet_01v8 l={L_xm8n} w={W_xm8n}
XM12N VOUTP N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12n} w={W_xm12n}

* Power and Bias
VVDD VDD 0 1.8
IBIAS N1 0 50u

* Reference Voltage for Output Common Mode
VREF VREF 0 0.9

* P-half DC bias loop and AC/Tran injection
E_bias_P VINP_DC 0 VOUTN VREF 1000
R_lp_P VINP_DC VINP_LF 1Meg
C_lp_P VINP_LF 0 1
V_INP_AC VINP_AC 0 DC 0 AC 1 PWL(0 0 10n 0 11n 0.5 1.011u 0.5 1.012u -0.5 2.012u -0.5 2.013u 0)
E_comb_P VINP VINP_AC VINP_LF 0 1

* N-half DC bias loop and AC/Tran injection
E_bias_N VINN_DC 0 VOUTP VREF 1000
R_lp_N VINN_DC VINN_LF 1Meg
C_lp_N VINN_LF 0 1
V_INN_AC VINN_AC 0 DC 0 AC -1 PWL(0 0 10n 0 11n -0.5 1.011u -0.5 1.012u 0.5 2.012u 0.5 2.013u 0)
E_comb_N VINN VINN_AC VINN_LF 0 1

* Load Capacitors
CLOAD_P VOUTN 0 1p
CLOAD_N VOUTP 0 1p

.control
  * DC Operating Point
  op
  let Power = -i(VVDD) * 1.8
  print Power

  * AC Analysis
  ac dec 20 1 1G
  let vd = v(VOUTP) - v(VOUTN)
  let gain_db = db(vd) - 6.0206
  let phase_deg = 180/PI * ph(vd)
  
  meas ac DC_Gain find gain_db at=10
  meas ac GBW when gain_db=0 fall=1
  meas ac phase_at_gbw find phase_deg when gain_db=0 fall=1
  meas ac Phase_Margin param='180 + phase_at_gbw'
  print DC_Gain GBW Phase_Margin

  * Transient Analysis
  tran 1n 3u
  meas tran t_fall TRIG v(VOUTN) VAL=0.7 FALL=1 TARG v(VOUTN) VAL=0.2 FALL=1
  meas tran sr_fall param='0.5 / t_fall'
  
  meas tran t_rise TRIG v(VOUTN) VAL=0.2 RISE=1 TARG v(VOUTN) VAL=0.7 RISE=1
  meas tran sr_rise param='0.5 / t_rise'
  
  meas tran Slew_Rate param='(sr_rise + sr_fall) / 2'
  print Slew_Rate
  
  quit
.endc
.end