* Digital-IF WCDMA Transmitter RF Amplifier
.lib "/home/ubuntu/sky130_fd_pr/models/sky130.lib.spice" tt

* DUT (npn replaced with sky130 nfet for CMOS compatibility)
I1 N4 0 1m
I2 N5 0 1m
XM1 N2 Vbias N1 0 sky130_fd_pr__nfet_01v8 w=10 l=0.15
XM2 N0 Vbias N6 0 sky130_fd_pr__nfet_01v8 w=10 l=0.15
RE N4 N5 100
XM3 N1 vip N5 0 sky130_fd_pr__nfet_01v8 w=10 l=0.15
XM4 VDD Vctrl N1 0 sky130_fd_pr__nfet_01v8 w=5 l=0.15
CL N0 N2 100f
XM5 VDD Vctrl N6 0 sky130_fd_pr__nfet_01v8 w=5 l=0.15
RL2 N0 VDD 500
XM6 N6 vin N4 0 sky130_fd_pr__nfet_01v8 w=10 l=0.15
RL1 N2 VDD 500

* Sources
VVDD VDD 0 1.8
VVBIAS Vbias 0 1.2
VVCTRL Vctrl 0 0.5
VVIP vip 0 DC 0.9 AC 0.5 SIN(0.9 0.05 1G 0 0)
VVIN vin 0 DC 0.9 AC -0.5 SIN(0.9 -0.05 1G 0 0)

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 100 1Meg 10G
let vout_diff = v(N2) - v(N0)
let gain_db = vdb(vout_diff)
meas ac max_gain max gain_db
meas ac ugbw when gain_db=0 fall=1

tran 10p 5n
meas tran vout_max max v(N2)
meas tran vout_min min v(N2)
let vpp = vout_max - vout_min
print vpp
quit
.endc
.end