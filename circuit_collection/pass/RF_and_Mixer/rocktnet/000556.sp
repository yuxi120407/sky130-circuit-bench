* T/R Switch Equivalent Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Component values for the equivalent circuit
.param Rrx_val=50
.param rdsM1_val=3
.param CsbM1_val=0.5p
.param CdbM1_val=0.5p
.param Rtx1_val=200
.param RsubM1_val=200

* AC Source (2V peak to get 0dB at matched load)
Vac PA_Tx_src GND dc 0 ac 2
Rsrc PA_Tx_src PA_Tx 50

* DUT (Values appended to the provided netlist topology)
Rrx BPF_Ant GND Rrx_val
rdsM1 BPF_Ant PA_Tx rdsM1_val
CsbM1 BPF_Ant N0 CsbM1_val
CdbM1 PA_Tx N0 CdbM1_val
Rtx1 N0 GND Rtx1_val
RsubM1 N0 GND RsubM1_val

.control
ac dec 100 100Meg 10G
let IL_dB = vdb(BPF_Ant)
meas ac IL_2_4G find IL_dB at=2.4G
meas ac IL_5_2G find IL_dB at=5.2G
print IL_2_4G IL_5_2G
quit
.endc
.end