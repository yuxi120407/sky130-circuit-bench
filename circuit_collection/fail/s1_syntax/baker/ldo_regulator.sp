* LDO Regulator - 2-Stage
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_amp=0.5
.param L_pass=0.5
.param W_bias=5.0
.param W_diff=5.0
.param W_load=5.0
.param W_pass=5.0
.global VDD GND
.temp 27

* LDO Voltage Regulator - 2-Stage Topology
* Architecture: Error amp directly drives PMOS pass gate (no driver stage)
* Feedback: VFB on M1, VREF on M2 for negative feedback
*
*   VDD ──────────────────────────────┐
*         |        |        |         |
*        XM3      XM4    XMPASS      RBIAS
*       (diode)  (mirror)  (pass)     |
*         |        |        |        VBIAS
*        VD1──────VD2───CC──VOUT      |
*         |        |        |        XMBIAS
*        XM1      XM2     XR1        |
*       (VFB)   (VREF)     |        GND
*         |        |       VFB
*        VTAIL   VTAIL     |
*         |                XR2
*       XMTAIL              |
*         |                GND
*        GND

* ====== Pass Transistor ======
XMPASS VOUT VD2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_pass} w={W_pass} m=10

* ====== Error Amplifier - Differential Pair ======
* VFB on M1 (diode-load side), VREF on M2 -> negative feedback for 2-stage
XM1 VD1 VFB VTAIL GND sky130_fd_pr__nfet_01v8 l={L_amp} w={W_diff} m=4
XM2 VD2 VREF VTAIL GND sky130_fd_pr__nfet_01v8 l={L_amp} w={W_diff} m=4
XMTAIL VTAIL VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_amp*2} w={W_bias} m=4

* ====== Error Amplifier - Active Load ======
XM3 VD1 VD1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_amp} w={W_load} m=4
XM4 VD2 VD1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_amp} w={W_load} m=4

* ====== Miller Compensation ======
CC VD2 VOUT 1p

* ====== Feedback Network ======
XR1 VOUT VFB VDD sky130_fd_pr__res_high_po_1p41 w=1.41 l=156
XR2 VFB GND VDD sky130_fd_pr__res_high_po_1p41 w=1.41 l=156

* ====== Bias Circuit ======
XMBIAS VBIAS VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_amp*4} w={W_bias} m=1
RBIAS VDD VBIAS {vdd/ibias/10}

* ====== Load and Output Cap ======
ILOAD VOUT GND DC 0.01
CLOAD VOUT GND 1u

* ====== Supply and Reference ======
VREF VREF GND DC 0.6
VDD VDD GND DC 1.8


.control
set noaskquit
op
quit
.endc

.end
