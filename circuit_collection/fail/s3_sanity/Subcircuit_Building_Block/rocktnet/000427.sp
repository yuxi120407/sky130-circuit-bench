* Constant-gm Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmi1=0.5
.param L_xmi2=0.5
.param L_xmq=0.5
.param L_xmq1=0.5
.param L_xmq2=0.5
.param L_xmq3=0.5
.param L_xmq4=0.5

.param W_xmq2=5.0 L_xmq2=0.5
.param W_xmi2=5.0 L_xmi2=0.5
.param W_xmi1=5.0 L_xmi1=0.5
.param W_xmq3=5.0 L_xmq3=0.5
.param W_xmq4=5.0 L_xmq4=0.5
.param W_xmq1=5.0 L_xmq1=0.5
.param W_xmq=5.0 L_xmq=0.5

VVDD VDD 0 dc 1.8 ac 1 pulse(0 1.8 10n 1n 1n 10m 20m)
Iref VA 0 10u
VCM VCM 0 dc 0.9

XMQ2 N3 N2 0 0 sky130_fd_pr__nfet_01v8 l={L_xmq2} w={W_xmq2}
XMI2 VQ VQ 0 0 sky130_fd_pr__nfet_01v8 l={L_xmi2} w={W_xmi2}
XMI1 VQ N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmi1} w={W_xmi1}
XMQ3 VDD VA N2 0 sky130_fd_pr__nfet_01v8 l={L_xmq3} w={W_xmq3}
XMQ4 N2 VQ 0 0 sky130_fd_pr__nfet_01v8 l={L_xmq4} w={W_xmq4}
XMQ1 N3 VA VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmq1} w={W_xmq1}
XMQ VA VA VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmq} w={W_xmq}

.control
save all @m.xmi2.msky130_fd_pr__nfet_01v8[gm] @m.xmi1.msky130_fd_pr__pfet_01v8[gm]

* DC Operating Point
op
let power_consumption = -i(VVDD) * 1.8
let v_vq_bias = v(VQ)
let v_n3_bias = v(N3)
print power_consumption
print v_vq_bias
print v_n3_bias

* AC Analysis for PSRR
ac dec 100 1 1G
meas ac gain_vq find vdb(VQ) at=1k
let psrr_vq = -gain_vq
print psrr_vq

* Transient Analysis for Startup Time
tran 1n 20u
meas tran vq_final find v(VQ) at=15u
meas tran startup_time trig v(VDD) val=0.9 rise=1 targ v(VQ) val='0.9*vq_final' cross=1
print startup_time

* DC Analysis for gm_variation
dc VCM 0 1.8 0.1
let gm_val = @m.xmi2.msky130_fd_pr__nfet_01v8[gm] + @m.xmi1.msky130_fd_pr__pfet_01v8[gm]
meas dc gm_max max gm_val
meas dc gm_min min gm_val
let gm_variation = (gm_max - gm_min) / (gm_max + 1e-15) * 100
print gm_variation

quit
.endc
.end