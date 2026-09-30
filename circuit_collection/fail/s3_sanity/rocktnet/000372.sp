* Switched-Current MAC Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmcn=0.5
.param L_xmcp=0.5
.param L_xmm1=0.5
.param L_xmm2=0.5
.param L_xmm3=0.5
.param L_xmp1=0.5
.param L_xmp2=0.5
.param L_xmr1=0.5
.param L_xmr2=0.5

.param W_xmm2=5.0 L_xmm2=0.5
.param W_xmp1=5.0 L_xmp1=0.5
.param W_xmcn=5.0 L_xmcn=0.5
.param W_xmm3=5.0 L_xmm3=0.5
.param W_xmcp=5.0 L_xmcp=0.5
.param W_xmm1=5.0 L_xmm1=0.5
.param W_xmr2=5.0 L_xmr2=0.5
.param W_xmr1=5.0 L_xmr1=0.5
.param W_xmp2=5.0 L_xmp2=0.5

VVDD VDD 0 1.8
VVSS VSS 0 0
V_VBIAS VBIAS 0 PWL(0 1.0 1.0u 1.0 1.01u 0.8 2u 0.8)
V_VCASP VCASP 0 0.6
V_VCASN VCASN 0 1.2
V_POS POSITIVE_SUM 0 PWL(0 0 1.0u 0 1.01u 1.8 2u 1.8)
V_NEG NEGATIVE_SUM 0 0.9
V_N3 N3 0 0

V_PHI1 PHI1 0 PWL(0 0 10n 1.8 1.0u 1.8 1.01u 0 2u 0)
V_PHI2 PHI2 0 0
V_WRC WR_C_PLUS 0 0

C_hold N2 0 1p
.ic v(N2)=0

XMM2 N5 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xmm2} w={W_xmm2}
XMP1 N0 PHI1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xmp1} w={W_xmp1}
XMCN NEGATIVE_SUM POSITIVE_SUM N0 GND sky130_fd_pr__nfet_01v8 l={L_xmcn} w={W_xmcn}
XMM3 N0 VCASN N5 GND sky130_fd_pr__nfet_01v8 l={L_xmm3} w={W_xmm3}
XMCP POSITIVE_SUM WR_C_PLUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xmcp} w={W_xmcp}
XMM1 N1 N1 VSS GND sky130_fd_pr__nfet_01v8 l={L_xmm1} w={W_xmm1}
XMR2 N0 VCASP N4 VDD sky130_fd_pr__pfet_01v8 l={L_xmr2} w={W_xmr2}
XMR1 N4 VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmr1} w={W_xmr1}
XMP2 N2 PHI2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xmp2} w={W_xmp2}

.control
tran 1n 2u

* 1. Power Consumption
meas tran avg_current avg i(VVDD) from=0 to=2u
let power_consumption = -avg_current * 1.8
print power_consumption

* 2. Sampled Current
meas tran I_pmos_sample find i(VVDD) at=0.95u
let I_in_sample = -I_pmos_sample
meas tran I_nmos_sample find i(VVSS) at=0.95u
print I_in_sample I_nmos_sample

* 3. Settling Time
meas tran V_N2_final find v(N2) at=0.95u
let V_N2_99 = V_N2_final * 0.99
meas tran settling_time trig v(PHI1) val=0.9 rise=1 targ v(N2) val=$&V_N2_99 rise=1
print settling_time

* 4. Hold Current and Copy Error
meas tran I_nmos_hold find i(VVSS) at=1.5u
let copy_error = abs(I_nmos_hold - I_nmos_sample) / abs(I_nmos_sample) * 100
print I_nmos_hold copy_error

* 5. MAC Output Current (Evaluate Phase)
meas tran mac_output_current find i(V_NEG) at=1.8u
print mac_output_current

quit
.endc
.end