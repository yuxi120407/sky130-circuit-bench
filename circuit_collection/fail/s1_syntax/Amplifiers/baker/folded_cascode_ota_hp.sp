* Folded-Cascode OTA testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param W_casc_n=5.0
.param W_casc_p=5.0
.param W_fold=5.0
.param W_in=5.0
.param W_mirr=5.0
.param W_sink=5.0
.options GMIN=1e-10 RELTOL=1e-4 ABSTOL=1e-12

f""".subckt FOLDED_CASCODE_OTA VSS VDD VOUT VINN VINP VBN VBP VTAIL 
* PMOS differential input pair
XM1 N1 VINP VTAIL VDD sky130_fd_pr__pfet_01v8 w={W_in} l=0.15
XM2 N2 VINN VTAIL VDD sky130_fd_pr__pfet_01v8 w={W_in} l=0.15

* NMOS folding devices
XM3 N1 VBN NC1 VSS sky130_fd_pr__nfet_01v8 w={W_fold} l=0.15
XM4 N2 VBN NC2 VSS sky130_fd_pr__nfet_01v8 w={W_fold} l=0.15

* NMOS cascode (bottom)
XM5 NC1 VBN VSS VSS sky130_fd_pr__nfet_01v8 w={W_casc_n} l=0.15
XM6 NC2 VBN VSS VSS sky130_fd_pr__nfet_01v8 w={W_casc_n} l=0.15

* PMOS current mirror loads
XM7 N1 N1 NP1 VDD sky130_fd_pr__pfet_01v8 w={W_sink} l=0.15
XM8 N2 N1 NP2 VDD sky130_fd_pr__pfet_01v8 w={W_sink} l=0.15

* PMOS cascode (top)
XM9  NP1 VBP VDD VDD sky130_fd_pr__pfet_01v8 w={W_mirr} l=0.15
XM10 NP2 VBP VDD VDD sky130_fd_pr__pfet_01v8 w={W_casc_p} l=0.15

* Output connection
ROUT N2 VOTA_OUT 0.01

* Sallen-Key HIGH-PASS Filter (C and R swapped from LPF)
C1 VOTA_OUT VNODE1 C1
C2 VNODE1 VBUF_IN C2
R2 VBUF_IN VSS R2
R1 VNODE1 VOUT R1

* Unity-gain buffer
EBUFFER VOUT VSS VBUF_IN VSS 1.0
RBUF_OUT VOUT VFINAL_OUT 0.01

* Output load
CLOAD VFINAL_OUT VSS 1e-12
.ends FOLDED_CASCODE_OTA"""


* Rails - Use voltage sources to measure current
VVDD  VDD_NODE   0   DC 1.8
VVSS  VSS_NODE   0   DC 0

* Bias voltages
VBN   VBN_NODE   0   DC 0.7
VBP   VBP_NODE   0   DC 1.0

* Differential inputs
VINP  VINP_NODE  0   DC 0.9 AC 0.5
VINN  VINN_NODE  0   DC 0.9 AC -0.5

* Tail current - Use 0V voltage source to measure current
VTAIL VDD_NODE VTAIL_NODE DC 0
ITAIL_SRC VTAIL_NODE 0 DC 10e-6

* DUT and load
XOTA  VSS_NODE VDD_NODE VOUT_NODE VINN_NODE VINP_NODE VBN_NODE VBP_NODE VTAIL_NODE subckt_name
CLOAD VOUT_NODE VSS_NODE 1e-12

.op
.ac dec 200 1 10G

* Measurements
.measure ac dc_gain_db max vdb(VOUT_NODE)
.measure ac ugbw when vdb(VOUT_NODE)=0 fall=1

.control
set noaskquit
op
ac dec 200 1 10G

* Power measurement
let power_dc = abs(i(VVDD)[0]) * 1.8 * 100
print power_dc

* AC gain
let vout_ac = ac1.v(VOUT_NODE)
let gain_linear = mag(vout_ac[0])
let gain_db = 20*log(gain_linear)/log(10)
print gain_db

* UGBW
let vout_mag = mag(vout_ac)
let freq_vec = frequency
let gain_db_vec = 20*log(vout_mag)/log(10)

let idx = 0
let ugbw_hz = 0
while idx < length(gain_db_vec) - 1
  if (gain_db_vec[idx] > 0) & (gain_db_vec[idx+1] < 0)
    let ugbw_hz = freq_vec[idx]
    print ugbw_hz
    break
  end
  let idx = idx + 1
end

quit
.endc
.end
