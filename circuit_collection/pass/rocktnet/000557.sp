* T/R Switch Equivalent Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT (with assumed component values for simulation)
L2 BPF_Ant LNA_Rx 2n
C2a BPF_Ant GND 200f
C2b LNA_Rx GND 200f
CsbM1 BPF_Ant N0 300f
CdbM1 PA_Tx N0 300f
Rtx1 N0 GND 50
RsubM1 N0 GND 500

* Port Terminations and Source
R_ant BPF_Ant_src BPF_Ant 50
V_ant BPF_Ant_src 0 dc 0 ac 2 sin(0 1 2.4G)
R_rx LNA_Rx 0 50
R_tx PA_Tx 0 50

.control
ac dec 100 1G 10G
let rx_il_db = db(v(LNA_Rx))
let tx_iso_db = db(v(PA_Tx))

meas ac Rx_Insertion_Loss find rx_il_db at=2.4G
meas ac Tx_Isolation find tx_iso_db at=2.4G

tran 10p 2n
meas tran vout_pp pp v(LNA_Rx)
* The circuit is purely passive and linear, so P1dB is theoretically infinite.
let P1dB_Rx = 999

print Rx_Insertion_Loss Tx_Isolation P1dB_Rx
quit
.endc
.end