* Testbench for DAC Current Cell
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xmcas=0.5
.param L_xmcs=0.5
.param L_xmsa=0.5
.param L_xmsb=0.5

.param W_xmcs=5.0 L_xmcs=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xmsa=5.0 L_xmsa=0.5
.param W_xmcas=5.0 L_xmcas=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xmsb=5.0 L_xmsb=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5

XMCS N1 LABEL_NET_0 VDD GND sky130_fd_pr__nfet_01v8 l={L_xmcs} w={W_xmcs}
XM2 VDD VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XMSA DUMP VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xmsa} w={W_xmsa}
XMCAS VDD LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xmcas} w={W_xmcas}
XM6 VDD VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XMSB VDD VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xmsb} w={W_xmsb}
XM10 VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 LABEL_NET_3 VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 LABEL_NET_3 VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 VDD VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 CLOCK CLOCK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9
VCLOCK CLOCK 0 0.9
VDUMP DUMP 0 0.9

.control
op
let power_dc = -i(VVDD) * 1.8
print power_dc

tran 10p 2n
meas tran avg_current avg i(VVDD)
.endc
quit
.end
