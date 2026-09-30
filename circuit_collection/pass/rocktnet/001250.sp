* MDAC Stage Testbench
.param C_in=2p C_fb=1p C_load=1p

* DUT (Note: A1 changed to X1 for standard SPICE compatibility, C values parameterized)
X1 VI_N N1 GND amplifier
C1 VI_N N1 {C_fb}
C2 N1 VREF {C_load}

* External components for testing (Input cap and DC bias path)
Cin VIN VI_N {C_in}
Rbias VI_N GND 1G

* Sources
VVREF VREF 0 0.9
VVIN VIN 0 DC 0.9 AC 1 SIN(0.9 0.1 10Meg)
VVDD VDD 0 1.8

* Amplifier macro model (Tuned for ~61MHz closed-loop BW)
.subckt amplifier in out gnd
G1 gnd out_int gnd in 1m
R1 out_int gnd 100k
C1 out_int gnd 0.87p
E1 out gnd out_int gnd 1
.ends

.control
* AC Analysis
ac dec 100 100k 1G
let gain_db = vdb(N1)
meas ac midband_gain find gain_db at=1Meg
let gain_db_3db = midband_gain - 3
meas ac bw_3db when gain_db=gain_db_3db fall=1

* Transient Analysis
tran 0.1n 200n
meas tran v_out_max max v(N1)
meas tran v_out_min min v(N1)
let v_pp = v_out_max - v_out_min

print midband_gain
print bw_3db
print v_pp
quit
.endc
.end
