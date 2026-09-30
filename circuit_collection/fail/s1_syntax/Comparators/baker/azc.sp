* AZC_OTA Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param W_AZC1=5.0
.param W_AZC23=5.0
.param W_BIAS=5.0
.param W_GM1=5.0
.param W_GM2=5.0
.param W_GMFOUT=5.0
.param W_LOAD=5.0

.subckt AZC_OTA GNDA VDDA VINN VINP VOUT
* PMOS BIAS CURRENT MIRROR Active_Zero_Compensated_Miller_OTA
xm0 VB1 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS} m=4
xm1 VB4 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS} m=4
xm2 TAIL VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS} m=8
xm4 VOUTN VOUTN VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS} m=4
xm5 NET050 VOUTN VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS} m=4
xm3 NET078 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS} m=24
xm8 NET049 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS} m=8

* AZC2 - PMOS
xm6 NET055 NET055 VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_AZC23} m=4
xm7 NET057 NET055 VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_AZC23} m=8

* FIRST STAGE
xm9 DM_2 VINN TAIL TAIL sky130_fd_pr__pfet_01v8 l=L w={W_GM1} m=4
xm10 NET063 VINP TAIL TAIL sky130_fd_pr__pfet_01v8 l=L w={W_GM1} m=4

* NMOS BIAS AND LOADS
xm19 VB4 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={2*W_BIAS} m=4
xm20 DM_2 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={7*W_BIAS} m=4
xm21 NET063 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={7*W_BIAS} m=4

* FIRST STAGE LOAD
xm16 NET077 DM_2 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_LOAD} m=4
xm17 NET082 NET063 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_LOAD} m=4
xm14 VOUTN NET077 DM_2 GNDA sky130_fd_pr__nfet_01v8 l=L w={W_LOAD} m=4
xm15 NET050 NET082 NET063 GNDA sky130_fd_pr__nfet_01v8 l=L w={W_LOAD} m=4

* SECOND STAGE
xm11 NET094 NET050 VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_GM2} m=4
xm12 NET055 NET094 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_AZC1} m=4
xm22 NET094 NET051 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_AZC23} m=16
xm23 NET057 NET043 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_AZC23} m=12
xm24 NET049 NET057 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_AZC23} m=4

* OUTPUT STAGE
xm18 VOUT NET049 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_GMFOUT} m=4
xm13 VOUT NET050 VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_GMFOUT} m=4


* COMPENSATION NETWORK
R0 NET078 NET077 35e3
R1 NET078 NET082 35e3
R2 NET057 NET051 350e3
R3 NET057 NET043 40e3
C0 NET063 VOUT 810e-15
C1 NET051 GNDA 404e-15
C2 NET043 GNDA 310e-15

* BIAS CURRENT SOURCE
I0 VB1 GNDA 1e-6

.ends AZC_OTA


VDD VDD 0 DC 1.8
VSS VSS 0 DC 0
VINP VINP 0 DC 0.3 AC 0.5
VINN VINN 0 DC 0.3 AC -0.5

XDUT VSS VDD VINN VINP VOUT AZC_OTA

CLOAD VOUT 0 15e-9
RLOAD VOUT 0 25e3

.control
op
let vdd_current = abs(i(VDD))
let power_dc = vdd_current * 1.8
print power_dc

ac dec 100 1 10g
let gain_db = vdb(VOUT)
let dc_gain_db = gain_db[0]
print dc_gain_db

if dc_gain_db > 0
  meas ac ugbw WHEN gain_db=0 CROSS=1
end
quit
.endc
.end
