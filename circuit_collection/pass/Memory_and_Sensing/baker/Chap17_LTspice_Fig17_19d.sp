* DSM Sensing Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Stimuli
Vdd vdd 0 1.8
Vref vref 0 1.4
Vclk clk 0 pulse(0 1.8 0 1n 1n 49n 100n)

* Circuit Netlist
S1 vref ncup clk 0 switch_mod
S2 ncup vbit vout 0 switch_mod
.model switch_mod sw vt=0.9 vh=0.1 ron=100 roff=1G

Ccup ncup 0 1p
V_Rmbit vbit vbit_r 0
Rmbit vbit_r 0 100k
Cbit vbit 0 10p

B1 vout 0 V= ((V(vref) - 0.8 + V(vout)*0.2 > V(vbit)) * (V(clk) < 0.9)) ? 1.8 : 0
XM4 vbit vref vdd vdd sky130_fd_pr__pfet_01v8 w=5.0 l=0.15

* Control Block
.control
tran 10n 10u

* Measure M_over_N (Ratio of output pulses to total clock cycles)
meas tran vout_avg avg v(vout) from=6u to=10u
let M_over_N = vout_avg / 0.9

* Measure Qcup (Charge transferred from Ccup to bitline during one active clock cycle)
meas tran Qtotal integ i(Vref) from=6u to=10u
let active_cycles = M_over_N * 40 + 1e-9
let Qcup = -Qtotal / active_cycles

* Measure Imbit (Average current through Rmbit)
meas tran Imbit avg i(V_Rmbit) from=6u to=10u

* Measure dVbit (Maximum voltage ripple on bitline)
meas tran vbit_max max v(vbit) from=6u to=10u
meas tran vbit_min min v(vbit) from=6u to=10u
let dVbit = vbit_max - vbit_min

* Measure Rsc (Equivalent resistance of SC circuit)
meas tran vref_avg avg v(vref) from=6u to=10u
meas tran vbit_avg avg v(vbit) from=6u to=10u
meas tran I_vref_avg avg i(Vref) from=6u to=10u
let I_sc = -I_vref_avg + 1e-15
let V_drop = vref_avg - vbit_avg
let Rsc_eff = V_drop / I_sc
let Rsc = Rsc_eff * M_over_N

* Measure VREF_max (DC)
dc Vref 0 1.8 0.01
meas dc VREF_max find v(vref) when v(vout)=0.9

print Qcup Imbit dVbit Rsc M_over_N VREF_max
.endc
.end