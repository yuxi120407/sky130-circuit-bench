* Testbench for Differential Pair
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N2 IN N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 IN_HASH N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Loads (Added for testbench functionality)
RL1 VDD N2 2k
RL2 VDD N3 2k
CL1 N2 0 10f
CL2 N3 0 10f

* Sources
VVDD VDD 0 1.8
VBIAS BIAS 0 1.0

* Input Signal Generation (Common Mode + Differential Mode)
VCM VCM 0 0.9
VDM VDM 0 DC 0 AC 1 SIN(0 0.2 100MEG)
E1 IN VCM VDM 0 0.5
E2 IN_HASH VCM VDM 0 -0.5

.control
  * DC Operating Point
  op
  let itail = -i(VVDD)
  let power = itail * 1.8
  print itail power

  * AC Analysis
  ac dec 100 1MEG 100G
  let vout_diff = v(N2) - v(N3)
  let gain_mag = mag(vout_diff)
  let gain_db = 20 * log10(gain_mag)
  meas ac dc_gain find gain_db at=1MEG
  let gain_3db = dc_gain - 3
  meas ac bw when gain_db=gain_3db fall=1

  * Transient Analysis
  tran 10p 20n
  let vout_diff_tran = v(N2) - v(N3)
  meas tran vout_max max vout_diff_tran from=10n to=20n
  meas tran vout_min min vout_diff_tran from=10n to=20n
  let vout_pp = vout_max - vout_min
  print vout_pp
  
  quit
.endc
.end
