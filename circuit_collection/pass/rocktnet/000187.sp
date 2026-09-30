* V-I Converter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10a=0.5
.param L_xm11a=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14a=0.5
.param L_xm15a=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm13=5.0 L_xm13=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm10a=5.0 L_xm10a=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm11a=5.0 L_xm11a=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm15a=5.0 L_xm15a=0.5
.param W_xm14a=5.0 L_xm14a=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm6=5.0 L_xm6=0.5

VVDD VDD 0 1.8
VVBIAS3 VBIAS3 0 0.4
Iref VDD N4 50u

Vcm Ncm 0 0.9
Vd Nd 0 dc 0 ac 1 sin(0 0.2 10Meg)
E1 VR_PLUS Ncm Nd 0 0.5
E2 Ncm VR_MINUS Nd 0 0.5

VoutL TO_ACSUS_L 0 0.9
VoutR TO_ACSUS_R 0 0.9

XM13 N1 VBIAS3 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM4 N8 VR_PLUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM9 N8 VBIAS3 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM2 N2 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM5 N1 VR_MINUS N13 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM10A N6 N8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10a} w={W_xm10a}
XM8 N9 N8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM12 N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM11A TO_ACSUS_L VBIAS3 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm11a} w={W_xm11a}
XM1 N4 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM3 N13 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM15A TO_ACSUS_R VBIAS3 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm15a} w={W_xm15a}
XM14A N5 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14a} w={W_xm14a}
XM7 N2 VR_MINUS N13 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM6 N13 VR_PLUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

.control
  * DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * DC Sweep for Gm and Linearity
  dc Vd -0.5 0.5 0.01
  let idiff = i(VoutL) - i(VoutR)
  let gm = deriv(idiff)
  meas dc transconductance_gm max gm
  let gm_90 = transconductance_gm * 0.9
  meas dc v_lin_pos when gm=gm_90 fall=last
  meas dc v_lin_neg when gm=gm_90 rise=1
  let linear_input_range = v_lin_pos - v_lin_neg
  print linear_input_range

  * AC Analysis for Bandwidth
  ac dec 20 1Meg 10G
  let idiff_ac = i(VoutL) - i(VoutR)
  let gm_ac = mag(idiff_ac)
  let gm_db = 20*log10(gm_ac)
  meas ac gm_dc find gm_ac at=1Meg
  let gm_db_dc = 20*log10(gm_dc)
  let gm_db_3db = gm_db_dc - 3
  meas ac bandwidth_3db when gm_db=gm_db_3db fall=1
  print bandwidth_3db

  quit
.endc
.end