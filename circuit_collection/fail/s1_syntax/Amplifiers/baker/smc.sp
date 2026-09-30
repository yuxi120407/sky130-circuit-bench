* SMC Amplifier Testbench (Simple Miller Compensation)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param W_BIAS_N=5.0
.param W_BIAS_P=5.0
.param W_GM1=5.0
.param W_GM2=5.0
.param W_GM3=5.0
.param W_GMF2=5.0
.param W_LOAD2=5.0

.subckt SMC GNDA VDDA VINN VINP VOUT
* PMOS BIAS CURRENT MIRROR
xm0 VBIAS VBIAS VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS_P} m=8
xm1 VB4 VBIAS VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS_P} m=8
xm2 DM_1 VBIAS VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS_P} m=8
xm3 VB3 VBIAS VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS_P} m=8
xm4 TAIL VBIAS VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS_P} m=32
xm5 VOUTN VOUTN VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS_P} m=8
xm6 V1OUT VOUTN VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS_P} m=8
xm7 V2OUT VBIAS VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_BIAS_P} m=8

* FIRST STAGE - PMOS Differential Pair with NMOS Folded Cascode
xm8 DM_2 VINN TAIL TAIL sky130_fd_pr__pfet_01v8 l=L w={W_GM1} m=8
xm9 DM_P VINP TAIL TAIL sky130_fd_pr__pfet_01v8 l=L w={W_GM1} m=8
xm19 DM_2 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_BIAS_N} m=64
xm20 DM_P VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_BIAS_N} m=64
xm15 VOUTN VB3 DM_2 GNDA sky130_fd_pr__nfet_01v8 l=L w={W_BIAS_N} m=32
xm16 V1OUT VB3 DM_P GNDA sky130_fd_pr__nfet_01v8 l=L w={W_BIAS_N} m=32

* NMOS BIAS GENERATION
xm14 VB3 VB3 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_BIAS_N} m=8
xm17 NET54 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_BIAS_N} m=32
xm12 VB4 VB3 NET54 GNDA sky130_fd_pr__nfet_01v8 l=L w={W_BIAS_N} m=32
xm18 NET56 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_BIAS_N} m=32
xm13 DM_1 VB3 NET56 GNDA sky130_fd_pr__nfet_01v8 l=L w={W_BIAS_N} m=32

* SECOND STAGE
xm10 V2IN V1OUT VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_GM2} m=8
xm21 V2IN V2IN GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_LOAD2} m=8
xm22 V2OUT V2IN GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_LOAD2} m=8

* OUTPUT STAGE
xm23 VOUT V2OUT GNDA GNDA sky130_fd_pr__nfet_01v8 l=L w={W_GM3} m=16
xm11 VOUT V1OUT VDDA VDDA sky130_fd_pr__pfet_01v8 l=L w={W_GMF2} m=8

* COMPENSATION
C0 V1OUT VOUT 2e-12

* BIAS CURRENT SOURCE
I0 VBIAS GNDA 20e-6

.ends SMC


VDD VDD 0 DC 1.8
VSS VSS 0 DC 0
VINP VINP 0 DC 0.9 AC 0.5
VINN VINN 0 DC 0.9 AC -0.5

XDUT VSS VDD VINN VINP VOUT subckt_name

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