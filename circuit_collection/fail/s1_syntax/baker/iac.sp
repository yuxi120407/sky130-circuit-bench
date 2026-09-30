* IAC Amplifier Testbench (Indirect Amplifier Compensation)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_FB=0.5
.param W_xm0=5.0
.param W_xm1=5.0
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm19=5.0
.param W_xm2=5.0
.param W_xm20=5.0
.param W_xm23=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm57=5.0
.param W_xm58=5.0
.param W_xm6=5.0
.param W_xm61=5.0
.param W_xm62=5.0
.param W_xm63=5.0
.param W_xm64=5.0
.param W_xm65=5.0
.param W_xm66=5.0
.param W_xm67=5.0
.param W_xm68=5.0
.param W_xm69=5.0
.param W_xm7=5.0
.param W_xm70=5.0
.param W_xm8=5.0
.param W_xm9=5.0

* DUT definition
.subckt IAC GNDA VDDA VINN VINP VOUT
.param L_xm65=0.15 W_xm65=1.0
.param L_xm0=0.15 W_xm0=1.0
.param L_xm57=0.15 W_xm57=1.0
.param L_xm1=0.15 W_xm1=1.0
.param L_xm58=0.15 W_xm58=1.0
.param L_xm3=0.15 W_xm3=1.0
.param L_xm62=0.15 W_xm62=1.0
.param L_xm2=0.15 W_xm2=1.0
.param L_xm61=0.15 W_xm61=1.0
.param L_xm4=0.15 W_xm4=1.0
.param L_xm5=0.15 W_xm5=1.0
.param L_xm6=0.15 W_xm6=1.0
.param L_xm7=0.15 W_xm7=1.0
.param L_xm66=0.15 W_xm66=1.0
.param L_xm8=0.15 W_xm8=1.0
.param L_xm9=0.15 W_xm9=1.0
.param L_xm19=0.15 W_xm19=1.0
.param L_xm20=0.15 W_xm20=1.0
.param L_xm15=0.15 W_xm15=1.0
.param L_xm16=0.15 W_xm16=1.0
.param L_xm14=0.15 W_xm14=1.0
.param L_xm17=0.15 W_xm17=1.0
.param L_xm12=0.15 W_xm12=1.0
.param L_xm18=0.15 W_xm18=1.0
.param L_xm13=0.15 W_xm13=1.0
.param L_xm64=0.15 W_xm64=1.0
.param L_xm63=0.15 W_xm63=1.0
.param L_xm10=0.15 W_xm10=1.0
.param L_xm70=0.15 W_xm70=1.0
.param L_xm69=0.15 W_xm69=1.0
.param L_xm67=0.15 W_xm67=1.0
.param L_xm68=0.15 W_xm68=1.0
.param L_xm23=0.15 W_xm23=1.0
.param L_xm11=0.15 W_xm11=1.0

* PMOS BIAS CURRENT MIRROR - Cascoded structure
xm65 VB2 VB2 VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm65} w={W_xm65} m=46
xm0 NET2 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm0} w={W_xm0} m=184
xm57 VB1 VB2 NET2 VDDA sky130_fd_pr__pfet_01v8 l={L_xm57} w={W_xm57} m=184
xm1 NET3 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1} m=184
xm58 VB4 VB2 NET3 VDDA sky130_fd_pr__pfet_01v8 l={L_xm58} w={W_xm58} m=184
xm3 NET8 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3} m=184
xm62 VB3 VB2 NET8 VDDA sky130_fd_pr__pfet_01v8 l={L_xm62} w={W_xm62} m=184
xm2 NET6 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2} m=184
xm61 NET7 VB2 NET6 VDDA sky130_fd_pr__pfet_01v8 l={L_xm61} w={W_xm61} m=184
xm4 TAIL VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4} m=368
xm5 VOUTN VOUTN VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5} m=184
xm6 VOUTP VOUTN VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6} m=184
xm7 NET049 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7} m=736
xm66 NET10 VB2 NET049 VDDA sky130_fd_pr__pfet_01v8 l={L_xm66} w={W_xm66} m=7

* FIRST STAGE - PMOS Differential Pair with NMOS Folded Cascode
xm8 DM_2 VINN TAIL TAIL sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8} m=11
xm9 NET063 VINP TAIL TAIL sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9} m=11
xm19 DM_2 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19} m=184
xm20 NET063 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20} m=184
xm15 VOUTN VB3 DM_2 GNDA sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15} m=184
xm16 VOUTP VB3 NET063 GNDA sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16} m=184

* NMOS BIAS GENERATION
xm14 VB3 VB3 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14} m=23
xm17 NET54 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17} m=92
xm12 VB4 VB3 NET54 GNDA sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12} m=92
xm18 NET56 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18} m=92
xm13 NET7 VB3 NET56 GNDA sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13} m=92
xm64 NET9 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm64} w={W_xm64} m=92
xm63 VB2 VB3 NET9 GNDA sky130_fd_pr__nfet_01v8 l={L_xm63} w={W_xm63} m=92

* SECOND STAGE
xm10 NET043 VOUTP VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10} m=43
xm70 NET1 NET043 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm70} w={W_xm70} m=33
xm69 NET10 NET043 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm69} w={W_xm69} m=33
xm67 NET043 VB3 NET1 GNDA sky130_fd_pr__nfet_01v8 l={L_xm67} w={W_xm67} m=736
xm68 NET1 VB4 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm68} w={W_xm68} m=50

* OUTPUT STAGE
xm23 VOUT NET10 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm23} w={W_xm23} m=11
xm11 VOUT VOUTP VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11} m=9

* COMPENSATION (Indirect Amplifier)
C0 VOUTP VOUT 1.3e-12
C1 NET10 NET4 45e-12
R0 NET4 GNDA 40e3

* BIAS CURRENT SOURCE
I0 VB1 GNDA 47e-6
.ends IAC

* Power Supplies
VDD VDD 0 DC 1.8
VSS VSS 0 DC 0

* DUT Instantiation
XDUT VSS VDD VINN VINP VOUT IAC

* Output Load
CLOAD VOUT 0 15e-9
RLOAD VOUT 0 25e3

* Input DC Biasing & AC Stimulus
* Differential AC using large inductor feedback for closed-loop DC / open-loop AC (Middlebrook loop)
VCM VINP 0 DC 0.9 AC 1
L_FB VOUT VINN 1000
C_FB VINN 0 1000

.control
* 1. DC Operating Point & Power Dissipation
op
let p_diss = -i(VDD) * 1.8
print p_diss

* 2. AC Analysis (Open-Loop Gain, Bandwidth, Phase Margin)
ac dec 100 1 100MEG
let aol_db = vdb(VOUT)
let phase_deg = 180/PI * cph(v(VOUT))

meas ac dc_gain find aol_db at=10
meas ac ugbw when aol_db=0 fall=1
meas ac pm_deg find phase_deg when aol_db=0 fall=1

* 3. DC Sweep for Output Voltage Swing
alter L_FB 0
alter C_FB 1p
* Break feedback for DC transfer
alter input VCM dc=0.9
dc VCM 0.0 1.8 0.01
meas dc vout_max max v(VOUT)
meas dc vout_min min v(VOUT)

* 4. Transient Analysis for Slew Rate
alter VCM dc=0.9
VSTEP VINP 0 PULSE(0.4 1.4 100n 1n 1n 1u 2u)
tran 1n 2u
meas tran v_max max v(VOUT)
meas tran v_min min v(VOUT)
meas tran sr_rise trig v(VOUT) val=0.6 rise=1 targ v(VOUT) val=1.2 rise=1
let sr = (1.2 - 0.6) / (sr_rise * 1e-6)
print sr

quit
.endc
.end