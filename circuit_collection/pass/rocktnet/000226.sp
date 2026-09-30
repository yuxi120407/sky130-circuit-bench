* DRAM Offset-Cancellation Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5 W_xm1=5.0
.param L_xm2=0.5 W_xm2=5.0
.param L_xm3=0.5 W_xm3=5.0
.param L_xm4=0.5 W_xm4=5.0
.param L_xm5=0.5 W_xm5=5.0
.param L_xm6=0.5 W_xm6=5.0
.param L_xm7=0.5 W_xm7=5.0
.param L_xm8=0.5 W_xm8=5.0
.param L_xm9=0.5 W_xm9=5.0
.param L_xm10=0.5 W_xm10=5.0
.param L_xm11=0.5 W_xm11=5.0
.param L_xm12=0.5 W_xm12=5.0

XM1 A N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM7 B BITB SX GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM5 A BIT SX GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM3 N2 CONAZ A VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM2 B A VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM11 V_BLP BLP BIT VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 BITB BLP V_BLP VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM9 BITB CONDPRZ A GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM8 B CONBPRZ BIT GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM10 BITB BLP BIT VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM6 BITB CONCZ B GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM4 N2 CONAZ B GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VBLP_SRC V_BLP 0 0.9

VBLP_CTRL BLP 0 PWL(0 0 1.9n 0 2n 1.8)
VCONAZ CONAZ 0 PWL(0 1.8 1.9n 1.8 2n 0 5.9n 0 6n 1.8)
VCONCZ CONCZ 0 PWL(0 0 1.9n 0 2n 1.8 5.9n 1.8 6n 0)
VCONDPRZ CONDPRZ 0 PWL(0 0 7.7n 0 7.8n 1.8)
VCONBPRZ CONBPRZ 0 PWL(0 0 7.7n 0 7.8n 1.8)
VSX SX 0 PWL(0 0.9 1.9n 0.9 2n 0 5.9n 0 6n 0.9 7.9n 0.9 8n 0)

IBIT 0 BIT PWL(0 0 6.9n 0 7n 20u 7.5n 20u 7.6n 0)

CBIT BIT 0 100f
CBITB BITB 0 100f
CA A 0 10f
CB B 0 10f

.ic v(BIT)=0.9 v(BITB)=0.9 v(A)=0.9 v(B)=0.9 v(N2)=0.9

.control
  tran 10p 12n
  
  meas tran t_sense_start when v(SX)=0.45 fall=1 td=7n
  meas tran t_sense_end when v(B)=1.5 rise=1 td=7n
  let sensing_delay = t_sense_end - t_sense_start
  print sensing_delay
  
  meas tran i_integ integ i(VVDD) from=8n to=12n
  let sensing_power = -i_integ * 1.8 / 4n
  print sensing_power
  
  meas tran v_bit_sample find v(BIT) at=5.8n
  meas tran v_bitb_sample find v(BITB) at=5.8n
  let input_offset_voltage = v_bitb_sample - v_bit_sample
  print input_offset_voltage
  
  quit
.endc
.end