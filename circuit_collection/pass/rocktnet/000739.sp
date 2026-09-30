* LVDS Driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT Transistors
XM1 N_TOP LABEL_NET_5 VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM2 N1 LABEL_NET_0 N_TOP VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM3 N0 LABEL_NET_3 N_TOP VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM4 N0 LABEL_NET_4 N_BOT 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM5 N1 LABEL_NET_1 N_BOT 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM6 N_BOT LABEL_NET_2 0 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15

* VDD
VVDD VDD 0 1.8

* Biases (VBP for top PMOS source, VBN for bottom NMOS source)
V_VBP LABEL_NET_5 0 DC 0.4
V_VBN LABEL_NET_2 0 DC 1.0

* Inputs (500 MHz for 1 Gbps data rate)
* LABEL_NET_4 = INP (NMOS switch), LABEL_NET_0 = INP_B (PMOS switch)
* LABEL_NET_1 = INN (NMOS switch), LABEL_NET_3 = INN_B (PMOS switch)
V_INP LABEL_NET_4 0 PULSE(0 1.8 0.5n 50p 50p 0.95n 2n)
V_INP_B LABEL_NET_0 0 PULSE(1.8 0 0.5n 50p 50p 0.95n 2n)
V_INN LABEL_NET_1 0 PULSE(1.8 0 0.5n 50p 50p 0.95n 2n)
V_INN_B LABEL_NET_3 0 PULSE(0 1.8 0.5n 50p 50p 0.95n 2n)

* Load (Center-tapped 100 ohm differential termination)
R1 N1 VCM 50
R2 N0 VCM 50
VVCM VCM 0 1.25

* Parasitic Capacitance (Receiver + routing)
C1 N1 0 2p
C2 N0 0 2p

.control
  tran 10p 10n
  
  * Calculate differential and common-mode signals
  let vdiff = v(N1) - v(N0)
  let vcm_out = (v(N1) + v(N0)) / 2
  
  * Measure Vod (Differential Swing)
  meas tran vod_max max vdiff from=5n to=10n
  meas tran vod_min min vdiff from=5n to=10n
  let vod = (vod_max - vod_min) / 2
  print vod
  
  * Measure Vocm
  meas tran vocm_avg avg vcm_out from=5n to=10n
  print vocm_avg
  
  * Measure Power
  meas tran i_vdd avg i(VVDD) from=5n to=10n
  let power = -i_vdd * 1.8
  print power
  
  * Measure Rise and Fall times
  meas tran t_rise trig vdiff val=-0.02 rise=1 targ vdiff val=0.02 rise=1 from=5n
  meas tran t_fall trig vdiff val=0.02 fall=1 targ vdiff val=-0.02 fall=1 from=5n
  print t_rise
  print t_fall
  
  quit
.endc
.end