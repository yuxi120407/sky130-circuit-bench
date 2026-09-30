* Frequency Divider Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5

XM1 N0 N0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 GND N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 GND N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

VVDD VDD 0 1.8
VCLK N1 0 PULSE(0 1.8 0 10p 10p 156p 333p) AC 1

.control
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  tran 1p 2n
  meas tran vmax MAX v(N0)
  meas tran vmin MIN v(N0)
  let vpp = vmax - vmin
  let vmid = (vmax + vmin) / 2

  let t_in = 0
  meas tran t_in trig v(N1) val=0.9 rise=1 targ v(N1) val=0.9 rise=2

  let t_out = 0
  if vpp > 0.05
    meas tran t_out trig v(N0) val=$&vmid rise=1 targ v(N0) val=$&vmid rise=2
  end

  let max_operating_frequency = 0
  if t_in > 0
    if t_out > 0
      let freq_ratio = t_out / t_in
      if freq_ratio > 1.5
        if freq_ratio < 2.5
          let max_operating_frequency = 1 / t_in
        end
      end
    end
  end
  print max_operating_frequency

  noise v(N0) VCLK dec 10 1k 100Meg
  setplot noise1
  meas noise pn_floor find onoise_spectrum at=100Meg
  let phase_noise = 10 * log10(pn_floor + 1e-20)
  print phase_noise
  quit
.endc
.end