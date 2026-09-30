* Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Define parameters
.param W_xm1=2 L_xm1=0.15
.param W_xm2=4 L_xm2=0.15
.param W_xm3=4 L_xm3=0.15
.param W_xm4=2 L_xm4=0.15
.param W_xm5=2 L_xm5=0.15
.param W_xm6=2 L_xm6=0.15
.param W_xm7=2 L_xm7=0.15
.param W_xm8=2 L_xm8=0.15
.param W_xm9=2 L_xm9=0.15
.param W_xm10=2 L_xm10=0.15
.param W_xm11=2 L_xm11=0.15
.param W_xm12=2 L_xm12=0.15

* DUT
xm1 N003 Inp 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 Outm Outp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Outp Outm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm5 N002 Outm N004 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N001 Outp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
Vinm Inm 0 500m
xm4 Outm clock VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm7 Outp clock VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 Outm clock N001 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 Outp clock N002 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N004 Inm 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
X_X1 Outp Q Qi VDD 0 nand_2
X_X2 Qi Outm Q VDD 0 nand_2

.subckt nand_2 A B Out VDD GND
  xm3 out B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm8 out A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm11 N001 B GND 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 out A N001 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
.ends nand_2

* Stimulus
Vclock clock 0 PULSE(0 1.8 5n 100p 100p 10n 20n)
* 10mV differential input to test sensitivity
Vinp_src Inp_src 0 510m
* 10k resistor to measure kickback noise as described in text
Rinp Inp_src Inp 10k

.control
  let delta_v = 0.0
  let sensitivity = 1.3
  while delta_v <= 1.3
    let v_inp = 0.5 + delta_v
    alter Vinp_src $&v_inp
    tran 10p 30n
    meas tran q_final find v(Q) at=25n
    if q_final > 0.9
      let sensitivity = delta_v
      break
    end
    let delta_v = delta_v + 0.01
  end
  print sensitivity

  let v_inp_final = 0.5 + sensitivity + 0.01
  alter Vinp_src $&v_inp_final
  tran 10p 30n
  
  meas tran peak_idd min i(VDD)
  let switching_current = -peak_idd
  print switching_current
  
  meas tran max_inp max v(Inp)
  meas tran min_inp min v(Inp)
  let kickback_noise = max_inp - min_inp
  print kickback_noise
  
  meas tran max_drain_voltage_MB1 max v(N003)
  print max_drain_voltage_MB1

  alter Vclock 0.9
  alter Vinp_src 0
  dc Vinm 0 1.8 0.01
  meas dc min_input_voltage find v(Inm) when i(VDD)=-1u
  print min_input_voltage
  
  quit
.endc
.end