* Testbench for Reconfigurable Analog FIR Filter Stage
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmcm1=0.5
.param L_xmcm2=0.5
.param L_xmcm3=0.5
.param L_xmcm4=0.5
.param L_xmin1=0.5
.param L_xmin2=0.5
.param L_xmip1=0.5
.param L_xmip2=0.5
.param L_xmn1=0.5
.param L_xmn2=0.5
.param L_xmn3=0.5
.param L_xmn4=0.5
.param L_xmp1=0.5
.param L_xmp2=0.5
.param L_xmp3=0.5
.param L_xmp4=0.5

.param W_xmp1=5.0 L_xmp1=0.5
.param W_xmp2=5.0 L_xmp2=0.5
.param W_xmp3=5.0 L_xmp3=0.5
.param W_xmp4=5.0 L_xmp4=0.5
.param W_xmcm1=5.0 L_xmcm1=0.5
.param W_xmcm2=5.0 L_xmcm2=0.5
.param W_xmcm3=5.0 L_xmcm3=0.5
.param W_xmcm4=5.0 L_xmcm4=0.5
.param W_xmip1=5.0 L_xmip1=0.5
.param W_xmip2=5.0 L_xmip2=0.5
.param W_xmin2=5.0 L_xmin2=0.5
.param W_xmin1=5.0 L_xmin1=0.5
.param W_xmn1=5.0 L_xmn1=0.5
.param W_xmn2=5.0 L_xmn2=0.5
.param W_xmn3=5.0 L_xmn3=0.5
.param W_xmn4=5.0 L_xmn4=0.5

XMP1 NET_MP1_D ENABLEB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp1} w={W_xmp1}
XMP2 NET_MP2_D ENABLEB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp2} w={W_xmp2}
XMP3 NET_MP3_D ENABLEB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp3} w={W_xmp3}
XMP4 NET_MP4_D ENABLEB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp4} w={W_xmp4}
XMCM1 ON ON NET_MP1_D VDD sky130_fd_pr__pfet_01v8 l={L_xmcm1} w={W_xmcm1}
XMCM2 ON OP NET_MP2_D VDD sky130_fd_pr__pfet_01v8 l={L_xmcm2} w={W_xmcm2}
XMCM3 OP ON NET_MP3_D VDD sky130_fd_pr__pfet_01v8 l={L_xmcm3} w={W_xmcm3}
XMCM4 OP OP NET_MP4_D VDD sky130_fd_pr__pfet_01v8 l={L_xmcm4} w={W_xmcm4}
XMIP1 ON IP NET_MN1_D GND sky130_fd_pr__nfet_01v8 l={L_xmip1} w={W_xmip1}
XMIP2 ON IP NET_MN2_D GND sky130_fd_pr__nfet_01v8 l={L_xmip2} w={W_xmip2}
XMIN2 OP IN NET_MN3_D GND sky130_fd_pr__nfet_01v8 l={L_xmin2} w={W_xmin2}
XMIN1 OP IN NET_MN4_D GND sky130_fd_pr__nfet_01v8 l={L_xmin1} w={W_xmin1}
XMN1 NET_MN1_D ENABLE GND GND sky130_fd_pr__nfet_01v8 l={L_xmn1} w={W_xmn1}
XMN2 NET_MN2_D ENABLE GND GND sky130_fd_pr__nfet_01v8 l={L_xmn2} w={W_xmn2}
XMN3 NET_MN3_D ENABLE GND GND sky130_fd_pr__nfet_01v8 l={L_xmn3} w={W_xmn3}
XMN4 NET_MN4_D ENABLE GND GND sky130_fd_pr__nfet_01v8 l={L_xmn4} w={W_xmn4}

VVDD VDD 0 1.8
VENABLE ENABLE 0 1.8
VENABLEB ENABLEB 0 0

VCM NCM 0 0.9
VIP IP NCM DC 0 AC 0.5 PULSE(-0.1 0.1 1n 50p 50p 2n 4n)
VIN IN NCM DC 0 AC -0.5 PULSE(0.1 -0.1 1n 50p 50p 2n 4n)

B1 out_diff 0 V='v(OP)-v(ON)'

.control
  op
  let power = -i(VVDD) * 1.8
  print power

  ac dec 50 1Meg 10G
  let gain_db = vdb(out_diff)
  meas ac dc_gain find gain_db at=1Meg
  let gain_3db = dc_gain - 3
  meas ac bw_3db when gain_db=gain_3db fall=1

  tran 10p 10n
  meas tran delay trig v(IP) val=0.9 rise=1 targ v(out_diff) val=0 rise=1
  quit
.endc
.end
