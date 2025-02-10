// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu Oct  3 15:52:12 2024
// Host        : yannos running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Yannos/FILES/PROGRAMS/DST/FFT_implementation/fft-avr3200/Designs/VIVADO_22.2/FFT_Behavioral_arch_x32_v1/FFT_Behavioral_arch_x32_v1.gen/sources_1/ip/mult_gen_0/mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_18,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_18,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module mult_gen_0
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [9:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [22:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [32:0]P;

  wire [9:0]A;
  wire [22:0]B;
  wire CLK;
  wire [32:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "10" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "23" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "32" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  mult_gen_0_mult_gen_v12_0_18 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
C/5Mh/YfQK+xvzcE2CGtETuPBeLiyJko5tNa9mMrxf8GTM/0mqqMZ+vYDutRWwlkGLoBJ0ubJ2JM
hSYnF9uwe22zt9N5LFdSRZxMoN1o6c2PdIJyFX9QiG+G0k5olg9eEzsigfNpc9kE5brQ+zVlZ0BV
klXrD05hnhWq+ZJys/w=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
nhu9PWmxjSOqIMDTXJV+4qo0FPiBJCygcWuN/bfQzqY2oUKKM8378Fb2UT55vg8n4G10m17vIBgN
+Wy6buZC7GhxULhm+9qKdG61k/7yfhvEyQUBzudlOBUaIUk7ZAeE6SGH26C8h1WgBFSBJBshielG
kmSnefelvtJmMqQynpqanYQE+2/nM45zHVEXMtgEl8NM+ittmjnbmsjMG+VmkcpjTiitr8v+SSgM
RUwmbOuITmj1SaUWkm+IJTDW4bnipSqF0iXScNDVurlEpJm4oLvKdM1ottYIIcXR6+Fa5dGLRubI
LjYe8sQ49kCgXyYdFk4JbJANd3OdYx/U0839pw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oLOGB6O+5m7WVYa3aB6L+szJIkfErI3K6c0Z4Xd6Cc9YLnPbUoTR/E3N7bfACANo1RtCR1KrgOT9
QRzSpMaWuUNpHkoBWkpOvvqpujGg7n+KNjtsXpeAJDMZq0hpkCFMyTIbglQJfVL4ds7LBIztVpT+
XPSPp0rHN6MvUs/o0sQ=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
b3H7uIeGCIVDgn3FEC671rtMncRXCjR9RBfw6OuWzlyF5wFk4ElX2tB2gwrWUb2Com7mmOGUcT8m
dWBnb4fgFyaI4CcP0cDJZ1RBfKHzHsnVnUtydmh17jwFjOhuG4oqUfxDBVOziYixuf8xqsPD1kIx
AAGgp8eCh/3TTWsXe8MqUHFhWLAFBHiM+g9tiFtJxHBAyX5v+8avU7rSRQOteILiCl/aE/ZTg1U1
TZRYZm9xCtpTek8kcIXycf8cf1vmkeYfjYqsPcKnLXjswHKcSvCTgJBvdf6/NU1hADbYz5krZkN6
cP43YF8Es6pXZ5MZxRyvAulHMEmC1vBKEV4L2Q==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hNojWTRiv5xJXFjSuajQtOI6VJWjSVIasMceSy/iOADWwlykMyPQqJwBZv9vgyG2lsbPzupIZZOt
sY4+VQKC49eSzzBiqlXJuuRgTh4eG5Sj78MJPFi8Z4JHdANbBDjcsfEyFcFinPG8C+6ObqSWv3sT
fh66lPvK05YKvRong1DaI4yDI+LeF0XCXF9jXawejRWPqZyQQRofEUn3P6/HL3rOQ9WrwtOgLOh4
eld6oolD6hKjdN6z7BtfypoG1+c9GyXB8peQYSYy2mC/UhPM2He7IScIeEh8FKNZOETke8ShtPdd
8KijcT3YF0mZbR+JEAYmPRwljDtmkR1nmLPJ5g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vNoNhNOiLgedrjzCipcIWa66MfCSJrQLJjludHrumavTx1oA+4ROcs5sx9EIY16AxVabVb6PSj/B
6g7QMmhWOHO5XWCGsLGngpWlMaz7FPJIrMDMH0FqHULVZgn+ytshKF3OiHU9DKUfGAkx2o6xKR8J
v2jv+NfcjYrjtp1y5L007VCIwcNtkKJJXaDQjJxbYYOB0uzxwQIXRo+SEib+esXDvZD6Ikc55nl4
wE0bh+voYoBpOgDoGMiOgpg8YJnYWFS+aCT4aHJqb0+12fK4HJHyN34p2V9mna/PBHxQttZEjbwL
t5GBDgl9IiQOzvoyMMwa3D9yJPGWNEJTOJaUbw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UWO1yL0EL8CXhMsuZN3v7pq9vqI3Hx8I4AdpxQRWS35PlhqAcAjYeBVG9msiPa5PzWiULLQfpvtc
jErP46XJGtGsEiYBMIv0Sy4sw0m1buhgPQC3ebkJgAk3bspWMUEsvYaN1IfFXabxN+RYANz3tJ2Y
oHgpnvvpm8OrlQUsgkwwn7FgVUGvBHoaj3vopWTMROl61+OL1aj+VLKQvwlZuA30e5yG7JAT159Y
e+xbMUxDz+W4RK0kPzZxnlU6X2HGieEEqGVzuAHvbaqUsRHZF294LqHX4u2WuTM74rvH69Kh5wL6
jYEYgCU9ma4gBAA98slrAnjNqn4bY2f9DG+now==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
iXm1XonW4ervg3D4DUJphNzJ6vN12GMfC70OgzuNrZ2kX9fFpWbL5IBPnCTMNnNWQy0GGe6hvPmb
j7EpeR3MIhJR5BcSdHMR4BVvSo0AEM+UmieNsuTc7dTw++8EucnKuLvloLldJo1b29DO+LZfqkGP
M9z2zkXfSVOqQRNGzxLR5gGJLHNfjxGz8MOIJ3HaDDAbO1eEgkWN9ZeesYwJrgERNSubcEhjLzl8
dVi5A1iTEa6WcsQ7XpUZkZTrHlM+/ZUnuZelrt2eHwx7m5XAZzHXbVz6YPrxLVx80IcJzqkykiEp
dMotGjzHWB0+tNy/gRFTUB5rpFt3LtF2+O9mZEf4nNluB9zmYqmvU9T4zeiID3NuEe4WOZjruJ0Q
gBPt5imaHECnAFxZ7QWVRp1rGkX8eS8I5qjfVJm8+pKqvjc1MGkAv2Vh4RG+n36yShUI44QIDYIY
zqj5fbexc27+CEmjJEFy/Cwik0yDg15IXyQYIkVLbBBdXfuQsGR6lI0A

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
e2TCE/IVroj0BoMutEWWgUoHdqmqHN4Vq1aGvl8tHLqPMgKPyusaF/EU/+MvsIWjDyZip1MmWOcx
jQu5Oy8IWt51LTRIQJ0x+kU2WDMNmZRHSdVAR8ORyzaV+63xJ+1FR21OuVBTsdN0zc5+xPOZn251
Ih7Dkw8u+guep7Yr4t3jgw+4crsiBVVM+5WJvUb5HgZZLCirWswHL2EOSwrlxmh1UfYzXoib6RPE
Ra/hqZSom0279kPBw6Fx+riPQZSw7jyFJal9sJMpp1RQHG0wo0DgA0V8Ot4NHxUc9Fwq4+hnCyfi
r2lvbn1yjpQbLFKBIZrlQAud1cQVbPc9abtdFA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
amFKhetGTlfluRuw+7MMOUyIo3vGg0+A7/Ai3gahf3q7Q2DhTB+aDs5W3IzQVuGl/PAcW8x5XBUU
Hpt5mlODI6OKSSadNPPSrSAMN5jrdbv2DfpnqGuxXjVFjrTa7718RjSBQ06uhzPQPCp8Bl+HJ1zu
9FRNvZMBrslG3F2E4UJG+jTm46YTvfAn4IxqTWs0Z0rBals2sWTo0VdhFpzvkT7CoqjkfFR2hzpC
ihafnm849oEbJGDdFof9yYRV01yRmPrDR30/5WhMa/u/vyng00jSqdoQjRL4Z+y/jUWcnvg3hnUz
li9IIzHln1T7mMntuOm9UA6ytqUhjgBWjQuRNA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GdgmhI1R7uUIKCgDJQU7mqMvGjMHkonmMop7KS1paxTMSUlyEznWbneSK/pmwvGupdZpytnfGiJh
9RV+y+J+sdYN4eBBFlK5d0fdbTPbcGlViKgyn72vHLwvZOSw8jUyraWQX0MNrZpbkxb/86R0o8m9
lE4/NhM0a183vy6oOYYktRKeDUbI/W4znCpaZWwWrB7hr62M7XFQ51hmiEZLjgIDbDuz91ccQy5I
SfdXpITmoWyzi7SKziUhsyZIyeH/wZNr2XugyLjgJ15Tb2UZ3/2lPr6Bci50YzDsJOKvSoYKe8eq
E0ijN/CHkGvOdmmA1LwG6lldaoI3lh1jUEp77Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11056)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
