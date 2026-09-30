* Testbench for Temporal Output Coding Circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmchg=0.5
.param L_xmfr=0.5
.param L_xmpx=0.5
.param L_xmpy=0.5
.param L_xmrst=0.5
.param L_xmsc=0.5
.param L_xmsf=0.5
.param L_xmsx=0.5
.param L_xmsy=0.5

.param W_xmchg=5.0 L_xmchg=0.5
.param W_xmsc=5.0 L_xmsc=0.5
.param W_xmfr=5.0 L_xmfr=0.5
.param W_xmpy=5.0 L_xmpy=0.5
.param W_xmpx=5.0 L_xmpx=0.5
.param W_xmsx=5.0 L_xmsx=0.5
.param W_xmrst=5.0 L_xmrst=0.5
.param W_xmsy=5.0 L_xmsy=0.5
.param W_xmsf=5.0 L_xmsf=0.5

VVDD VDD 0 1.8
VN6 N6 0 1.4
VVTH VTH 0 1.0
VBIAS BIAS 0 0.0
VRESET RESET 0 PULSE(1.8 0 10n 1n 1n 100n 200n)

R_PX PULSEX 0 1Meg
R_PY PULSEY 0 1Meg
R_PF FREEZE 0 1Meg

C_MEM MEMTH 0 50f

XMCHG MEMTH BIAS N5 VDD sky130_fd_pr__pfet_01v8 l={L_xmchg} w={W_xmchg}
XMSC N5 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmsc} w={W_xmsc}
XMFR N0 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmfr} w={W_xmfr}
XMPY N3 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmpy} w={W_xmpy}
XMPX N1 VTH VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmpx} w={W_xmpx}
XMSX PULSEX MEMTH N1 VDD sky130_fd_pr__pfet_01v8 l={L_xmsx} w={W_xmsx}
XMRST MEMTH RESET GND GND sky130_fd_pr__nfet_01v8 l={L_xmrst} w={W_xmrst}
XMSY PULSEY MEMTH N3 VDD sky130_fd_pr__pfet_01v8 l={L_xmsy} w={W_xmsy}
XMSF FREEZE MEMTH N0 VDD sky130_fd_pr__pfet_01v8 l={L_xmsf} w={W_xmsf}

.control
tran 1n 200n
meas tran t_pulse_x trig v(RESET) val=0.9 fall=1 targ v(PULSEX) val=0.9 fall=1
meas tran t_pulse_y trig v(RESET) val=0.9 fall=1 targ v(PULSEY) val=0.5 fall=1
meas tran t_pulse_f trig v(RESET) val=0.9 fall=1 targ v(FREEZE) val=0.5 fall=1
meas tran t_reset trig v(RESET) val=0.9 rise=1 targ v(MEMTH) val=0.1 fall=1
meas tran avg_current avg i(VVDD)
quit
.endc
.end
