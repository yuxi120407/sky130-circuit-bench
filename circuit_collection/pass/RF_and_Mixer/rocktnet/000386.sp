* Merged LNA and Mixer Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

* DUT
XM1 N5 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 IF_OUT LO N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 IF_OUT_BAR LO_BAR N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 VBIAS N5 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

* Power supply
VVDD VDD 0 1.8

* LNA Bias and Load
V_LNA_SRC N3 0 0
V_VBIAS VBIAS 0 1.2
R_LNA_LOAD VDD N1 2k
V_LNA_IN N4 0 DC 0.7 AC 1 SIN(0.7 10m 2.1G)

* Mixer Bias and AC Coupling from LNA
C_AC N1 N2 10p
V_MIX_BIAS N2_bias 0 0.7
R_MIX_BIAS N2_bias N2 10k

* LO Signals (2.101 GHz for 1 MHz IF)
V_LO LO 0 DC 1.2 SIN(1.2 0.6 2.101G)
V_LO_BAR LO_BAR 0 DC 1.2 SIN(1.2 0.6 2.101G 0 0 180)

* Mixer Loads
R_MIX_LOAD1 VDD IF_OUT 2k
R_MIX_LOAD2 VDD IF_OUT_BAR 2k
C_MIX_LOAD1 IF_OUT 0 5p
C_MIX_LOAD2 IF_OUT_BAR 0 5p

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.control
  * 1. DC Power Consumption
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. LNA Voltage Gain
  ac dec 10 1G 10G
  let lna_gain_db = vdb(N1)
  meas ac lna_gain_2_1G find lna_gain_db at=2.1G

  * 3. Mixer Conversion Gain
  tran 10p 2u
  * Measure peak-to-peak of single-ended IF output over the second 1MHz cycle
  meas tran if_max max v(IF_OUT) from=1u to=2u
  meas tran if_min min v(IF_OUT) from=1u to=2u
  let if_pp = if_max - if_min
  * Differential conversion gain = (Differential Output Amp) / (Input Amp)
  * Diff Output Amp = if_pp. Input Amp = 10mV.
  let conv_gain = if_pp / 10m
  let conv_gain_db = 20 * log10(conv_gain)
  print conv_gain_db
  
  quit
.endc
.end
