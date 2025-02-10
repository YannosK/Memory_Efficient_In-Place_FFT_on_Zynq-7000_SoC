// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu Nov  7 15:32:40 2024
// Host        : yannos running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/designs/Vivado_22.2/FFT_8bit_SoC_Behavioral/FFT_8bit_SoC_Behavioral.gen/sources_1/ip/mult_gen_0/mult_gen_0_sim_netlist.v
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
I3+PE4MmxEo8dhtBdzstc9LBJ3qF/7+XuiruAvDwOU6V/SzzqbQEDcXjYzbs7Yz00pF4CmpoSuaG
b1VCbByEgaHpoE1kRDfszNaktSQTMb/Xfkkla4r3n6kg2DY+DL4eg9bAnwWDTJ3zWpKxn/EVPlx3
ebqWyAryL8/2HU3zA3/xICZofziBivgkjzZvJVz0l98m2IjDuhVxReNKgq+h1J0E5fAqx6YDKtPv
w3B3s8ldZ6gHJWo5UMKkCtM8++hDb5pLvz9NJzSrthNkl2z0U57thGWCZefYwcnwONuYKLPIX0gz
gW6GP/Ko3SksNKLfZPJpZjHzLWo7/y2VWGAZ1w==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
N6n4CmHJt+6yQmnuufqEIcMkvXv3AeCsP+r11j3lwKF4cd/shGlDrmn7wvCP2T2bWaic5/w7oYrc
gSu+5ACYtLEUaZV+RJjWKcLVhE59gN+Sv6dd+v2w4dV/hj7B+xoM333kzlggq/sUQ3yukPb4ZLqL
7fPH1mHGgM1RAJeCz6wvj9oGJ2Ir6UcY5ai9yIrxKMas0dRhehgyvTSfKbcQbG1nmtbz6yPwQ7Eh
HhiRkNWL0FmHyvjp8lp2KbGiEU1CuSJu44GXWHQhSz6rQjakfKiFWYgxgMBMhLUePN4YVoT5EZte
X7o1Y5YdPeCc/9UpXEk5OIGVami53y9AhdVxkA==

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
