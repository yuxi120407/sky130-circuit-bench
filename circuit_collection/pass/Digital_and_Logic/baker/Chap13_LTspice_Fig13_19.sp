* Level-Sensitive Latch Testbench

.param W_xm1=1 L_xm1=0.15
.param W_xm2=2 L_xm2=0.15
.param W_xm3=1 L_xm3=1.5
.param W_xm4=2 L_xm4=1.5
.param W_xm5=1 L_xm5=0.15
.param W_xm6=2 L_xm6=0.15
.param W_xm7=1 L_xm7=0.15

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Circuit Netlist
XM1 Q_b Q_int GND GND sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
XM2 Q_b Q_int VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
XM3 Q_int Q_b GND GND sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
XM4 Q_int Q_b VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
XM5 Q Q_b GND GND sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
XM6 Q Q_b VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
XM7 Q_int CLK D GND sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}

* Dummy inverter for input capacitance
XM_dummy_n out_dummy in_dummy GND GND sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
XM_dummy_p out_dummy in_dummy VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}

* Stimuli
VDD VDD 0 1.8
VCLK CLK 0 PWL(0 0 2n 0 2.01n 2.5 4n 2.5 4.01n 0 6n 0 6.01n 2.5 8n 2.5 8.01n 0 12n 0 12.01n 2.5 13n 2.5 13.01n 0 16n 0 16.01n 2.5 17n 2.5 17.01n 0 20n 0 20.01n 2.5 21n 2.5 21.01n 0 24n 0 24.01n 2.5 25n 2.5 25.01n 0 28n 0 28.01n 2.5 29n 2.5 29.01n 0 32n 0 32.01n 2.5 33n 2.5 33.01n 0 36n 0 36.01n 2.5 37n 2.5 37.01n 0 42n 0 42.01n 2.5 43n 2.5 43.01n 0 46n 0 46.01n 2.5 47n 2.5 47.01n 0 50n 0 50.01n 2.5 51n 2.5 51.01n 0 54n 0 54.01n 2.5 55n 2.5 55.01n 0 58n 0 58.01n 2.5 59n 2.5 59.01n 0 62n 0 62.01n 2.5 63n 2.5 63.01n 0 66n 0 66.01n 2.5 67n 2.5 67.01n 0 90n 0)
VD D 0 PWL(0 0 1n 0 1.01n 1.8 5n 1.8 5.01n 0 12.8n 0 12.81n 1.8 13.8n 1.8 13.81n 0 16.85n 0 16.86n 1.8 17.85n 1.8 17.86n 0 20.9n 0 20.91n 1.8 21.9n 1.8 21.91n 0 24.95n 0 24.96n 1.8 25.95n 1.8 25.96n 0 29.0n 0 29.01n 1.8 30.0n 1.8 30.01n 0 33.05n 0 33.06n 1.8 34.05n 1.8 34.06n 0 37.1n 0 37.11n 1.8 38.1n 1.8 38.11n 0 42.2n 0 42.21n 1.8 43.2n 1.8 43.21n 0 46.15n 0 46.16n 1.8 47.15n 1.8 47.16n 0 50.1n 0 50.11n 1.8 51.1n 1.8 51.11n 0 54.05n 0 54.06n 1.8 55.05n 1.8 55.06n 0 58.0n 0 58.01n 1.8 59.0n 1.8 59.01n 0 61.95n 0 61.96n 1.8 62.95n 1.8 62.96n 0 65.9n 0 65.91n 1.8 66.9n 1.8 66.91n 0 90n 0)
Vac in_dummy 0 DC 0.9 AC 1

* Metastability forcing
Vmeta1 meta1 0 0.95
Vmeta2 meta2 0 0.85
Vctrl ctrl 0 PWL(0 0 78.9n 0 79n 1.8 79.9n 1.8 80n 0)
S1 Q_int meta1 ctrl 0 switch_model
S2 Q_b meta2 ctrl 0 switch_model
.model switch_model sw vt=0.9 vh=0.1 ron=100 roff=1g

.control
tran 10p 90n

meas tran clock_to_q_delay trig v(CLK) val=0.9 rise=1 targ v(Q) val=0.9 rise=1

let vdd_current = -i(VDD)
meas tran contention_current max vdd_current from=5.9n to=7n

meas tran inverter_delay trig v(Q_b) val=0.9 fall=1 targ v(Q) val=0.9 rise=1

meas tran metastability_delay trig v(ctrl) val=0.9 fall=1 targ v(Q_int) val=1.6 rise=1 td=79n

let setup_time = 200e-12
meas tran sq1 find v(Q) at=14n
if sq1 > 0.9
  let setup_time = 200e-12
end
meas tran sq2 find v(Q) at=18n
if sq2 > 0.9
  let setup_time = 150e-12
end
meas tran sq3 find v(Q) at=22n
if sq3 > 0.9
  let setup_time = 100e-12
end
meas tran sq4 find v(Q) at=26n
if sq4 > 0.9
  let setup_time = 50e-12
end
meas tran sq5 find v(Q) at=30n
if sq5 > 0.9
  let setup_time = 0
end
meas tran sq6 find v(Q) at=34n
if sq6 > 0.9
  let setup_time = -50e-12
end
meas tran sq7 find v(Q) at=38n
if sq7 > 0.9
  let setup_time = -100e-12
end

let hold_time = 200e-12
meas tran hq1 find v(Q) at=44n
if hq1 > 0.9
  let hold_time = 200e-12
end
meas tran hq2 find v(Q) at=48n
if hq2 > 0.9
  let hold_time = 150e-12
end
meas tran hq3 find v(Q) at=52n
if hq3 > 0.9
  let hold_time = 100e-12
end
meas tran hq4 find v(Q) at=56n
if hq4 > 0.9
  let hold_time = 50e-12
end
meas tran hq5 find v(Q) at=60n
if hq5 > 0.9
  let hold_time = 0
end
meas tran hq6 find v(Q) at=64n
if hq6 > 0.9
  let hold_time = -50e-12
end
meas tran hq7 find v(Q) at=68n
if hq7 > 0.9
  let hold_time = -100e-12
end

ac dec 10 1G 10G
let omega = 2 * pi * frequency
let cap = imag(-i(Vac)) / omega
meas ac input_capacitance find cap at=1G

print clock_to_q_delay
print contention_current
print setup_time
print hold_time
print inverter_delay
print metastability_delay
print input_capacitance
.endc
.end