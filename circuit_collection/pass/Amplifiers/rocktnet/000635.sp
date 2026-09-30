* Testbench for Interpolating Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_m=0.5

.param W_m=10 L_m=0.15
.param I_tail1=400u I_sf1=200u I_tail2=400u I_sf2=200u
.param R_val=1k

VVDD VDD 0 1.8
VVSS VSS 0 0

* Inputs
VCM_src VCM 0 dc 0.6
ETa Ta Ta_ac VCM 0 1
VTa_ac Ta_ac 0 ac 1 pulse(-0.1 0.1 100p 20p 20p 400p 1n)
ETb Tb 0 VCM 0 1
ETc Tc 0 VCM 0 1

* Current sources
I1 Bo VSS I_sf2
I2 N13 VSS I_sf1
I3 N0 VSS I_tail2
I4 N6 VSS I_tail1
I5 N11 VSS I_tail1
I6 N4 VSS I_tail1
I7 N8 VSS I_sf2
I8 N12 VSS I_sf1

* Transistors (Mapped from NPN to NMOS for SKY130)
XM1 VDD N5 N8 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM2 N7 N13 N4 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM3 N9 Tb N11 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM4 N5 N12 N0 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM5 N9 Ta N4 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM6 VDD N10 Bo VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM7 N10 N13 N0 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM8 N9 Tc N6 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM9 VDD N9 N12 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM10 N7 N13 N6 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM11 VDD N7 N13 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}
XM12 N7 N13 N11 VSS sky130_fd_pr__nfet_01v8 L={L_m} W={W_m}

* Resistors
R1 VDD N7 {R_val}
R2 VDD N5 {R_val}
R3 VDD N9 {R_val}
R4 VDD N10 {R_val}

* Differential output conversion for AC measurement
E1 out 0 N8 Bo 1

.control
dc VCM_src 0.2 1.0 0.001
meas dc vcm_opt find v(VCM) when v(out)=0
alter VCM_src $&vcm_opt

op
let power = -i(VVDD) * 1.8
print power

ac dec 100 1M 100G
meas ac max_gain max vdb(out)
let gain_3db = $&max_gain - 3
meas ac bw when vdb(out)=gain_3db fall=1

tran 1p 2n
meas tran t_delay trig v(Ta_ac) val=0 rise=1 targ v(out) val=0.05 rise=1
meas tran v_max max v(out)
meas tran v_min min v(out)
quit
.endc
.end