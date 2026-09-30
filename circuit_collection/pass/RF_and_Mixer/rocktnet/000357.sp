* RF T/R Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM4 N2 N1 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM3 N3 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM1 RX N9 ANT GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 ANT N7 TX GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

VVDD VDD 0 1.8

* RF Ports and Terminations (50 ohms)
V_TX_src TX_src 0 dc 0 ac 1 sin(0 0.2 2.4G)
R_TX TX_src TX 50
R_ANT ANT 0 50
R_RX RX 0 50

* Control Signals (TX Mode: TX ON, RX OFF)
V_N7 N7 0 dc 1.8
V_N9 N9 0 dc 0

* Auxiliary Nodes (Prevent floating)
V_N0 N0 0 dc 1.8
V_N1 N1 0 dc 0
R_N2 N2 0 1Meg
R_N3 N3 0 1Meg

.control
  * AC Analysis for Insertion Loss and Isolation
  ac dec 50 1G 10G
  let s21_tx_ant = vdb(ANT) + 6.0206
  let s21_tx_rx = vdb(RX) + 6.0206
  meas ac insertion_loss_tx_ant find s21_tx_ant at=2.4G
  meas ac isolation_tx_rx find s21_tx_rx at=2.4G

  * Transient Analysis
  tran 10p 5n
  meas tran tran_v_out_pp pp v(ANT)
  meas tran tran_v_in_pp pp v(TX)
  
  print insertion_loss_tx_ant isolation_tx_rx tran_v_out_pp
  quit
.endc
.end
