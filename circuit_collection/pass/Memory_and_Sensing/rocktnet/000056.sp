* 10T CAM Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT
XM1 N5 SL GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
XM2 BLB WL N2 GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
XM3 N4 SLB GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
XM4 N3 N2 N5 GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
XM5 N3 N1 N4 GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
XM6 N1 N2 GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
XM7 N1 WL BL GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
XM8 N2 N1 GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
XM9 N2 N1 VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.5
XM10 N1 N2 VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.5

* Power supply
V_VDD VDD 0 1.8

* Matchline pull-up and load
R_ML N3 VDD 50k
C_ML N3 0 10f

* Initial conditions to ensure write flips the state
.ic v(N1)=0 v(N2)=1.8 v(N3)=1.8

* Stimulus
V_WL WL 0 PWL(0 0 1n 0 1.1n 1.8 4n 1.8 4.1n 0 20n 0)
V_BL BL 0 PWL(0 1.8 20n 1.8)
V_BLB BLB 0 PWL(0 0 20n 0)

* Search lines
* 0-5n: idle
* 6-9n: search 1 (Match, since Q=1)
* 12-15n: search 0 (Mismatch, since Q=1)
V_SL SL 0 PWL(0 0 5.9n 0 6n 1.8 9n 1.8 9.1n 0 20n 0)
V_SLB SLB 0 PWL(0 0 11.9n 0 12n 1.8 15n 1.8 15.1n 0 20n 0)

.control
tran 10p 20n
meas tran t_write trig v(WL) val=0.9 rise=1 targ v(N1) val=0.9 rise=1
meas tran v_ml_match min v(N3) from=6n to=9n
meas tran v_ml_mismatch min v(N3) from=12n to=15n
meas tran t_delay_mismatch trig v(SLB) val=0.9 rise=1 targ v(N3) val=0.9 fall=1
let p_total = -i(V_VDD)*1.8
meas tran p_avg_search avg p_total from=12n to=15n
print t_write v_ml_match v_ml_mismatch t_delay_mismatch p_avg_search
quit
.endc
.end