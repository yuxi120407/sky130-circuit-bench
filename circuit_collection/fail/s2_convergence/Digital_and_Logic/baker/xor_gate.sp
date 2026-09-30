* XOR Gate Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_nmos=0.5
.param L_pmos=0.5
.param W_nmos=5.0
.param W_pmos=5.0
.global VDD GND
.temp 27

* 2-Input XOR Gate (Transmission Gate Implementation)
* Y = A⊕B

* Transmission gate 1: passes A when B=0
XMP_TG1 N1 B_N A VDD sky130_fd_pr__pfet_01v8 l={L_pmos} w={W_pmos}
XMN_TG1 N1 B A GND sky130_fd_pr__nfet_01v8 l={L_nmos} w={W_nmos}

* Transmission gate 2: passes A' when B=1
XMP_TG2 N2 B A_N VDD sky130_fd_pr__pfet_01v8 l={L_pmos} w={W_pmos}
XMN_TG2 N2 B_N A_N GND sky130_fd_pr__nfet_01v8 l={L_nmos} w={W_nmos}

* Inverter for A
XMP_INVA A_N A VDD VDD sky130_fd_pr__pfet_01v8 l={L_pmos} w={W_pmos}
XMN_INVA A_N A GND GND sky130_fd_pr__nfet_01v8 l={L_nmos} w={W_nmos}

* Inverter for B
XMP_INVB B_N B VDD VDD sky130_fd_pr__pfet_01v8 l={L_pmos} w={W_pmos}
XMN_INVB B_N B GND GND sky130_fd_pr__nfet_01v8 l={L_nmos} w={W_nmos}

* Output stage
XMP_OUT Y N_INT VDD VDD sky130_fd_pr__pfet_01v8 l={L_pmos} w={{{W_pmos}*2}}
XMN_OUT Y N_INT GND GND sky130_fd_pr__nfet_01v8 l={L_nmos} w={{{W_nmos}*2}}

* Combine logic
XMP_COMB1 N_INT N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_pmos} w={W_pmos}
XMN_COMB1 N_INT N1 GND GND sky130_fd_pr__nfet_01v8 l={L_nmos} w={W_nmos}
XMP_COMB2 N_INT N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_pmos} w={W_pmos}
XMN_COMB2 N_INT N2 GND GND sky130_fd_pr__nfet_01v8 l={L_nmos} w={W_nmos}

* Load
CL Y GND 10e-15

* Supply
VDD VDD GND DC 1.8


.control
set noaskquit
op
quit
.endc

.end