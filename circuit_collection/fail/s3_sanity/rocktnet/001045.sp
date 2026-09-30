* T/R Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0

XM1 ANT LABEL_NET_0 TX_AND_DRAIN_DC_BIAS GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 LABEL_NET_1 ANT RX_AND_DRAIN_DC_BIAS GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 TX_AND_DRAIN_DC_BIAS LABEL_NET_2 TX_SOURCE_DC_BIAS GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* DC Biasing (0.9V to reduce junction capacitance as per paper)
Vdc dc_bias 0 0.9
Rdc_tx TX_AND_DRAIN_DC_BIAS dc_bias 10k
Rdc_ant ANT dc_bias 10k
Rdc_rx RX_AND_DRAIN_DC_BIAS dc_bias 10k
Rdc_tx_src TX_SOURCE_DC_BIAS dc_bias 10k

* Control Voltages (TX Mode: XM1 ON, XM2 OFF, XM3 OFF)
* Note: LABEL_NET_1 is set to 0.9V to prevent XM2 from turning on due to swapped D/G in extraction
Vctrl0 LABEL_NET_0 0 1.8
Vctrl1 LABEL_NET_1 0 0.9
Vctrl2 LABEL_NET_2 0 0.9

* RF Ports (50 ohm system)
Vac tx_ac 0 dc 0 ac 2 sin(0 2 900Meg)
Rin tx_ac tx_rf_in 50
Cin tx_rf_in TX_AND_DRAIN_DC_BIAS 1u

Cout ANT ant_ac 1u
Rout ant_ac 0 50

Crx RX_AND_DRAIN_DC_BIAS rx_ac 1u
Rrx rx_ac 0 50

.control
* 1. DC Operating Point
op
let DC_Power = abs(i(Vdc) * 0.9)
print DC_Power

* 2. AC Analysis for Insertion Loss and Isolation
ac dec 100 100Meg 10Gig
let vdb_ant = vdb(ant_ac)
let vdb_rx = vdb(rx_ac)
meas ac Insertion_Loss_dB find vdb_ant at=900Meg
meas ac Isolation_dB find vdb_rx at=900Meg
print Insertion_Loss_dB Isolation_dB

* 3. Transient Analysis for Voltage Swing
tran 10p 20n
meas tran v_max max v(ant_ac) from=10n to=20n
meas tran v_min min v(ant_ac) from=10n to=20n
let Transient_Swing_ANT = v_max - v_min
print Transient_Swing_ANT

quit
.endc
.end