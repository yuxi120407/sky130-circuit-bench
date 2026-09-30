* RTWO Parasitic Capacitance Model Testbench

.param cval=1p

* DUT (Parameter {cval} appended to prevent SPICE syntax errors for missing capacitor values)
CgsP2 A VDD {cval}
CdbP2 A VDD {cval}
CgsP1 VDD B {cval}
CdbP1 VDD B {cval}
CdgN1 A B {cval}
CdgP1 A B {cval}
CABint A B {cval}
CdgN2 A B {cval}
CdgP2 A B {cval}
CdbN2 A VSS {cval}
CgsN2 A VSS {cval}
CdbN1 VSS B {cval}
CgsN1 VSS B {cval}

* Supplies
VVDD VDD 0 1.8
VVSS VSS 0 0

* DC Bias to prevent floating nodes (singular matrix error)
RbiasA A 0 1G
RbiasB B 0 1G

* AC Current Source for C_diff measurement
Iac A B AC 1

.control
ac dec 10 1Meg 1Gig
* C = I / (omega * V)
let omega = 2 * pi * frequency
let v_diff = mag(v(A) - v(B))
let c_diff = 1 / (omega * v_diff)
meas ac C_diff_val find c_diff at=100Meg
print C_diff_val
quit
.endc
.end
