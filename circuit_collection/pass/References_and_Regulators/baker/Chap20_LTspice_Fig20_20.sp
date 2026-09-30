* Regulated Beta-Multiplier Current Reference Testbench (Fig 20.19 / Fig 20.20)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* DUT Parameters
.param W_xmsu1=50.0 L_xmsu1=2.0
.param W_xmsu2=10.0 L_xmsu2=20.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm1=50.0   L_xm1=2.0
.param W_xm2=200.0  L_xm2=2.0
.param W_xm3=100.0  L_xm3=2.0
.param W_xm4=100.0  L_xm4=2.0

* DUT Netlist
VDD VDD 0 1.8
xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
xmsu3 Vbiasp N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N002 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N002 Vbiasn N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
R1 N003 0 5500.0
E1 Vbiasp 0 N002 Vbiasn 10

.control
* Run operating point at nominal supply (VDD = 1.8V)
op
let iref1 = @m.xm1.msky130_fd_pr__nfet_01v8[id]
let iref2 = @m.xm2.msky130_fd_pr__nfet_01v8[id]
let gm1 = @m.xm1.msky130_fd_pr__nfet_01v8[gm]
let vgs1 = v(vbiasn)
let vreg = v(n002)
let vbiasp = v(vbiasp)
let vdiff = vreg - vgs1
let vov1 = vgs1 - 0.42

print iref1 iref2 gm1 vgs1 vreg vbiasp vdiff vov1

* Sweep VDD from 0V to 1.8V as in Figure 20.20
dc VDD 0 1.8 0.01

let iref_sweep = @m.xm1.msky130_fd_pr__nfet_01v8[id]
let didvdd = deriv(iref_sweep)

* Measure metrics from sweep
meas dc iref_nom find iref_sweep at=1.8
meas dc didvdd_nom find didvdd at=1.8
meas dc vdd_min when iref_sweep=5u rise=1
meas dc vdiff_nom find v(n002) at=1.8

print iref_nom didvdd_nom vdd_min
quit
.endc
.end