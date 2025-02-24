// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Feb 24 11:22:42 2025
// Host        : yannos running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/designs/Vivado_22.2/FFT_8bit_SoC_Behavioral/FFT_8bit_SoC_Behavioral.gen/sources_1/ip/mult_gen_1/mult_gen_1_sim_netlist.v
// Design      : mult_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_1,mult_gen_v12_0_18,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_18,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module mult_gen_1
   (A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [8:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [24:0]P;

  wire [8:0]A;
  wire [15:0]B;
  wire [24:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "9" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "24" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  mult_gen_1_mult_gen_v12_0_18 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(1'b1),
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
exx245QJFAkXfHq/8MVcgJFrINN3R1c2rCx61lqiFublnARUrNWeUnXoVcW/c6FiRKI9CyiZ/BOd
6cUgMTqwkbUMopfWHYmFR1PDQft61A66fy+jHqhpe4Ar02vNrXNkcW7dJAKYNAP6KmmJBcKTv8yX
eyztDOz8WzJyoRwM242N1/08b0Er4chiuJKUjNyXg8kVUy87Jepo+Ezf6IfCKRWYRWSsAqVrDdnd
I84/suekiAVWl7geXvZHKovDRjA+J0vgUGMhftWeyTDLtTxzAiNIRH3Q+9Vn07BRKaxRPvbxwf+H
78g82Y1Y0uEhvCs2gUXuneZWhsZW3wkURz2krg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
El9pouziOjr2u/VFiJeCUL5xwtIISFWvpT27uMa3nfT+QD5gFA6LMUH4Kp709KXuHVlGx1G7qF13
wHCSQJj4vjf5aB1cLP+F3Zwo/q0NUgd5HJCtSSuwE3RkBtyBGbE+RV9tXs+MII2iwH2FDMHC/UcJ
txrS6aZk0JCq1qukWk589OyGR7fGl4l5g2hug74e9+Ifw/Wf9U3J+sLCQQBxXiS3FT3+wxMRwyt9
w4B3i5AmyXHuCeBgynyHl+XaaWXmflngZf9PAxnlxuPjqQscTAUIiA4+tDWJmHLuUc4E+h/IJoE7
+LiSTIu3hZDm2+ezvTc8XfxDuitNt62f4Cej7Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 10448)
`pragma protect data_block
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
0HtfHRsBHEHE/MMNtfYT4CI=
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
