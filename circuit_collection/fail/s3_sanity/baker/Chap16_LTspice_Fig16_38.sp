* Chap16_LTspice_Fig16_38 Clocked Sense Amplifier with SR Latch
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Circuit Netlist
XMtail tail CLK GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XMB1 s1 VINP tail GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XMB2 s2 VINN tail GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM1 OUTN OUTP s1 GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM2 OUTP OUTN s2 GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM3 OUTN OUTP VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM4 OUTP OUTN VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM5 OUTN CLK VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM6 OUTP CLK VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM7 s1 CLK VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM8 s2 CLK VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15

* SR Latch (NAND based)
XMN1 Q OUTN n1 GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XMN2 n1 QN GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XMP1 Q OUTN VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XMP2 Q QN VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15

XMN3 QN OUTP n2 GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XMN4 n2 Q GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XMP3 QN OUTP VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XMP4 QN Q VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15

* Stimuli
VDD VDD 0 1.8
VCLK CLK 0 PULSE(0 1.8 1n 50p 50p 2n 4n)
Rinp VINP_src VINP 1k
Rinn VINN_src VINN 1k
VVINP VINP_src 0 0.905
VVINN VINN_src 0 0.895

* Analysis
.control
  * 1. Default Transient analysis
  tran 10p 5n
  
  * pmos_turn_on_voltage
  let d_outp = deriv(v(OUTP))
  meas tran t_min_outp WHEN d_outp=0 RISE=1 FROM=1.01n TO=3n
  meas tran pmos_turn_on_voltage FIND v(OUTN) AT=t_min_outp
  print pmos_turn_on_voltage
  
  * mb1_drain_max_voltage
  meas tran mb1_drain_max_voltage MAX v(s1) FROM=1n TO=3n
  print mb1_drain_max_voltage
  
  * kickback_noise
  meas tran v_vinp_max MAX v(VINP) FROM=0.9n TO=1.5n
  meas tran v_vinp_min MIN v(VINP) FROM=0.9n TO=1.5n
  let kickback_noise = v_vinp_max - v_vinp_min
  print kickback_noise
  
  * switching_current
  meas tran switching_current_raw MIN i(VDD) FROM=1n TO=3n
  let switching_current = -switching_current_raw
  print switching_current

  * 2. Sensitivity measurement via loop
  let vdiff = 0.0005
  let vbase = 0.895
  let found = 0
  while vdiff <= 0.02
    let vnew = vbase + vdiff
    alter VVINP $&vnew
    tran 10p 5n
    meas tran outn_val FIND v(OUTN) AT=2.5n
    if $&outn_val < 0.9
      let sensitivity = vdiff
      let found = 1
      break
    end
    let vdiff = vdiff + 0.0005
  end
  if found == 0
    let sensitivity = 0.02
  end
  print sensitivity

  * 3. DC analysis for input_common_mode_min
  alter VCLK 0
  alter VVINN 0
  dc VVINP 0 1.8 0.01
  meas dc input_common_mode_min FIND v(VINP_src) WHEN v(tail)=0.01
  print input_common_mode_min

.endc
.end