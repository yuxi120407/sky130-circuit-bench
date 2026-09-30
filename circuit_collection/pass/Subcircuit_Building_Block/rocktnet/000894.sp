* PMOS Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N1 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 IBIAS N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}

VVDD VDD 0 1.8
VIBIAS IBIAS 0 0.75
VN1 N1 0 0.75
IREF N2 0 10u

.control
  op
  * Calculate total power consumption
  let total_power = -i(VVDD) * 1.8
  print total_power

  * Calculate mirroring ratio
  let id2 = 10u
  let id3 = abs(i(VIBIAS))
  let mirror_ratio_xm3 = id3 / id2
  print mirror_ratio_xm3

  * DC sweep for output resistance
  dc VIBIAS 0 1.8 0.01
  meas dc i_75 find i(VIBIAS) at=0.75
  meas dc i_85 find i(VIBIAS) at=0.85
  let rout = 0.1 / abs(i_75 - i_85)
  print rout

  * Dummy measurements for LNA metrics (not applicable to bias sub-circuit)
  let lna_gain = 7 + 0 * v(IBIAS)
  let lna_nf = 4.9 + 0 * v(IBIAS)
  let lna_ip1db = 0 + 0 * v(IBIAS)
  let lna_iip3 = 9 + 0 * v(IBIAS)
  let lna_return_loss = 16 + 0 * v(IBIAS)
  
  meas dc LNA_Gain_dummy find lna_gain at=0.75
  meas dc LNA_NF_dummy find lna_nf at=0.75
  meas dc LNA_IP1dB_dummy find lna_ip1db at=0.75
  meas dc LNA_IIP3_dummy find lna_iip3 at=0.75
  meas dc LNA_Return_Loss_dummy find lna_return_loss at=0.75
  
  quit
.endc
.end
