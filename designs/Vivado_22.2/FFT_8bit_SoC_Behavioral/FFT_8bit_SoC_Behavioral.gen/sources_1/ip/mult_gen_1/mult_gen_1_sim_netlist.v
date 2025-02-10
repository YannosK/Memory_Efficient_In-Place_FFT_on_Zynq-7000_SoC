// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Sun Feb  9 23:19:15 2025
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
   (CLK,
    A,
    B,
    CE,
    SCLR,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [8:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_HIGH" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [24:0]P;

  wire [8:0]A;
  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [24:0]P;
  wire SCLR;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "9" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "24" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  mult_gen_1_mult_gen_v12_0_18 U0
       (.A(A),
        .B(B),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(SCLR),
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
dEJPDGVxhuVX+NcW0vnAi/4lzDeXS74/QaHHN5i0+miGzy0P9a+wFcMuYTBKDhRQdSVp+kCSTdI6
NeXANAmeV1EbKr9xwxnoGSKMMFS8yzLJv/nJ1zU6ECvEQ9W6FjWpXNBUslnFlj4hvh0OO6ZCqzGH
Gzu0QHAMki+W/antqWpKijb3iYiI2i8j0uUSHbZbOlcdZgzXLWbxi0q6pd2aVm/MJz5f03OqJBMn
3G+1AxzBsuvdLEXe+rUUb2MOGtfdoEr+d9xF9udJYec++yMCzVxBGFSABoatBL7iGiWFxeORp7Mw
gy2jx6ZEwhnGbQMDK5hN5cLLJPDE0OY7LGnssw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
q1SLoNFnTdlTr8bWdiuqG9Qso7sSeCZvsVvuQ7X6e3Vw3ZCbniSYe1XYZ4WaY1F/yYrCDKUQqwSw
Yo3WrEmKGH07fTMzMzIXTr7NiNvxQA0AS1lmgzj5Bin7clD1k7RCbMrakLROLYxJ0uxfTcy7Slv8
PAjPKY2zfGcakn/iKL/OU3idSm04p7cEY8e50rRRTz5I10qhy+lyLa3fYPnpBKolYbaaB2NE7wBh
5Ey1GqAPiKYlPIPATxedk+i7Chxmyf+WiHK1DE3H6n5xhkmJh/vSVwIir2tATbrm5Ex/XlIAbcD7
xnhyRFHw+E+bK2FyepTTGuaJD3rvsiW05cmOdA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11232)
`pragma protect data_block
bQnir+VU8PnL9OnwsKqVEZY5FO6TMlhFaHfgafKVwC8/9hOjXinBBq/JXauWgLngf7TaoRzrwWZh
oiPJQJ6vH9RpdgQAlyTwidn4HSQvjfky0GgT2USLFjVYjwCwXfFOpCfkFtbTvOnC02t4jr/ufznI
Ih3OLj494+JLWCRBC2TIejYTtvxGB8s5DWk43pkY++iVvwtNOT0Z0rEXn2OKP2dQYXwtjlR+Nh3z
7BXWc/HW+MUl5OvFnhwvjYfucBAQRm4qft94MQgpoyZLk6w/cAFsn1ZPIKx6Gm6I+QkMjbTCNJnU
WVrc4orHc6biyA3s3GKGxWQHUL0gzRjl/nGc8RmPPTsRh/F77GZoUQGqOhgh9gQlxxRoWCw/xP1w
qZXIsFTdXc+3E/YsURM8qhPdUOGpNDAtubZzyFPh7CpWFujEvSksffSvqn1t1Vw3PqcUluQGCfBS
zgoXuwGPk1gCCsxqn//dgOwfeN62rFXcr1WbLCHRbm2gTUnr4HkYKYJwTZ/0ZHBDmoyqVZ3vc5m5
zl32DIC6BX+SWDK2J1/RZEZpCUr3+5MmpAS5ASSsE5UrXIytv64fSnkTCt3ws78waxaCqch3biF9
l4opI4SOaQSpB66YSVPq+CipbVFsKMIvV0P5m9ZB2JoixqCAyoHB6MshjlMraVZPjHLp467y2FBz
GdNYkiRg5Ok8DDQYFegqy+Dl2TRQxwfIKpKlbCh/MIk3UDB8RXtLWKJkNF8byTZLluQprcYHCWmQ
AHWCYZTImftVxGdvjB5Ua50TuFNbGgj5KSQYIfKBIpGldQFgLmbxKHmHo7wezHcAcamNZViOi+jh
CU6YnUValHVaNPbOLbkx7M0dTtZ+BZBm0suykGu+VDzoeKWQO6mNL3gi+l6Xk8IZ2KqoI5+oXaxd
mJWUCs1BT64KL8Cfl9NNvYHVf/QHfdE5lZAT0mzCVOJrL/MeuVJ17W6OKe3xLR2pqwAer4hl15rv
mSRDmDrvxv+ZnuFYv4dixrKonTLESROJuS4w+IDjd8PePl+zvYZe+zABFi6TMX+FRPevjRc1zeJF
X13flHqOcWzlJD0qMnUSYc6iaO4TWV1JRpvnn10XR5y2CYaZBDrA/rh8VvzfHpmMmuyTtuW736hD
xI/qxJ4MpwA+CrI58UMWjW5zbyovWscvZ8NhDiCSUjsByzaZQ9sJovvLbmNUO0VN2AFJQWXnBqZc
GEZM9aTFXEMxPpPv4Na1Q8kM/PXNc79JQXERx9L8iCzEH5ppXRc6Gm4LP/3sRenNNdraN2dDutBs
aZQUhfTjCDgV4hqz3uyF63Tv/0GbQVUd7+AqIfRKlHx+OJhQ5tOGFWok5lcU/kJ6S8Nk7MtYoxlb
003jQAc+IWtxpKxvChpJ/rnbCg7BNNhmDAThq5bKYmKk56zAyCqssqs0mvJBEKU9fY+0teuIVMqw
VcuKR49DXF/U8FcZJR2v5BuAOCYkXmNjN9bKxepVancCVBL+cPSAW52urwfSWUfAABcOayYlG3Cv
93MkaftbEzJQtIttzXQuuZPpTGjc2mfaQhW3hqoSsnuY0s+YX+fBnY8+wnFng7AdCJUK2+Y2Vhqz
ixcT4Jp/PEujMqI5wclVCR0O2gB7NQccTXcETVRnHdjvNsUV1ri8/flwviVBsMW2NCcHHr0yKSKb
T+VMYoN8Eu39fA6+3qJQfN9HRTaAqHlCRe3NCb2kQ8pjo9vB7lhQC3qTJNBK2EnvozlFMjbrlZA7
urkEMJMqqH6Y0bzkAQUeGCKpHqFjdao/X7sSmxXvoCmWBPU2gZPIxcFMUxj1Uj4LbgtINNLFISpL
w/tcSSMjdGTrfPd1C4p9/mCm9CO5u7l08tvcaIvXai7WhZlP4NM66gLPNZosLYwMrAXXIYjCZHoe
4IydI6W8HnSAvM5hAs+oJ5Ej0qFmPc7r/gUdiEbDAzAW8uUr4VF9KAatC4aFhxgSIxEkkTkXdMIj
+yaY3IfiyCTyVnBspTcfs+T/r6lTrNpdWC1bpjEk1dl7//KWVf6ZNEd2M7VsR899OhsTcLMP52qV
AXVHCU+ZV4AUuWKWtwGPo0voFqP6Oz3zHXUq2orJRdSDc1KMddCAKIU2GgEK/DIO0sPOABOtBihr
pqrNAparSXMks6YRP4lkqlRcPuLnfs33i2KjXTqnmLfPtj+95r5Uq5wnkYKnH4G2v7KRNoZbdft/
jQ0abrq1sq/nFeM+L7lMdrrOF1yaWOZg2Sn7GFTZae31JC2ahUfJgSL3JAwZimhrk9XTfoAKsfnX
Iv54DCQWSl4+xkO18d4JpIs/O9149qDOu38RT1pjk6n5iate6Di3oB1M99QwDywoFaiWLi7O2a5Z
3IzL4i9nqNbwXEkLBX2VbP06c0GkoZ/QK5A/6uqP0LQY4X9LkXhsP9TDIyNjljoPZJGT95qxVABJ
/8qV9T8KilpEz7lfo+oQ11/afNFH4NPBSGif5jKb/vbObUoK5VyGpFE+mVpdbR9yYkCLfrruSM6J
uVdrYDWWrVtgUhfhqmHM5IZ974QQR953Ow8ZwlB9hqL9tVvz1ISRai8qBCwVjTItuvforPXUy43f
rWIoskZbEHJX6PFmdoitKm3TWBOkvSfTWbmy71rLoZQzXofOyE4DE6x/Mp7fkb9deTgfD8NMtzIZ
QhgmypOg5g0Bie82bzhE00EjRqsGMpy8e0+v4YELd2O6so1Dl86MGYbiSMQn3ewX7iXm23TOFqet
DlUG1Ymt+QnuVfFrnXBvDn5FL5I9u+yG3PsWHbjgHjpOHbN/A99kcC2JKG2cFxJMHwN7YF4+KYit
Ct/huiFjRla1VM9MykofMV47LE1XCDWWeOABUp6OcMyR1z2Qco+DrdL8xYifn+5nsF+FqHLDIjHK
WuAS8J8k0N1gPxV+Rao/7Ua5oD0Ohk8Rz9/MFv86TP04zX8wrwsdcOYkQJ55U+zRcbtD0+H0+7wZ
LwQCZt8wyGKoNtUrZwXuLAxluOZq0sv3vLfrhpEr87s/GVK+5ejoQ3kHmIXtAUamCbV9LIl10fHT
NAw4MixcTtE6FkL5wlUOtezF836tsdmi9XN0NOB155+vSrl0DgiiY/hp8mz8cLngPgjfCPIYAqA/
gpsoVtMf/0OxbGex6kFkjiLYEOhNgxdjtEpTEsHGtt+zC37ANc/mtyBAt65mh1U4BwlzOGVdcRKy
aWj73eFAqTWjDhC16/qK6wWkEyPpe63ehjxmtW5wePOCjQkRURSKPEKSGvXb0Vat1SKXwI+gxHjZ
ScfHb+cU3NYf3yl2Qv9/pGgpW10ZtoZfQaM40/fppy3ImXGqb4Y3UU5xSTPwfiw84P157ruODGb1
p66BVpTZ6gFIz1c5abA5t7C2mCng9BWAQ9ygzIdm7cJxMBnzwcKhDCp8N/FuzhSrCuRoamtATmnc
5rLkg7E/zHJ3ePpalNXNHpL820126ruzFqrOMEcWNMVdDWyMk273z5A6fSj5AkyLnz7E2G/lmwdH
dwBtCnVO24N6jPMEspTM7xJjHQjYT9vFZJtsa5JkTeXlPR7Yd3zNNG/MCLN5v+ZR65pqqzjKZ6hx
qAsp7K44BqfkbR4fRHJDNiR4VFrweAtQxt5TY6tatLtpr0kAWMCSLKiG0lv0//MsIMjr8f27YEgT
1xoLFbhYSB31sAAY2fHBesVscCVeMg3hK/TuUXrxMVLUjmvtjUpBcylG5vzc76kJXSP4oKLAkKh8
/RHKs/YnEZzQ24vMwpCAep85DqiPUUSTWheQFhubKPe2C6NUKSnDG3FSUK7sC6We1XCWoo9vS6rt
jQxAQNNDT017sAzZ8dI8+Nb423WtUy62CTymhEOd2llocWQxxL8qBH9WYlRm4s3NsWXkK72WfeMD
q6I2hmsjhff0hKLR0Ildt/2PkUgufdp1OkTjbRlA5p1eBBETWssq47ej8D/sAeA7KVr+BPelX+bO
DwSV5GrRrFnlzeG5NBQZeBWhRCo9f8TlMT8sS3X4b46qAOxfIryP/APykp9abFg5FpUqxgWAE6P2
efnlW7SpDYFwSZ6iTm2JNhb3DIJuOzGxHck7FIean6jYejw6mN1upVJqI9gz1bRoaeqD9u3CT5Ya
0ju7Zn47ZZkVcSPgUs63TsUK6VFTmaJq70TICaWqFX814XZZvHcb/Svmq/RYuXPlL2X8cHMwb+HN
075F620dbouxAuB1KFpBo2z55MFv7nF7ZwbqMDV/GjDW0vzxZPGwMfQNCXxkvq5r5dOarINnpRlK
q5he+5884euB5vRelr2Pd0WacC9Fwkl1llofpEFWnR14wJ0QDvWmLGgX0LFU6oxRX0tVet8mA1o3
jOpdqzjRWbAL2v61eHiy/ycGiD0RnQp2nayG1FCHwCZSe65zw9IynMme0xhnJ3YgC0pnsOHzOGCO
Rw96oVAqcyk+BQ3nurtCmLLW19DJp9aHpzUcCVRvHO/6njoP6L0Q9YfW+SH2NVIAVyNUYbmcTzSR
dkVQ7l5NSISHjkVEiVHhAKH0NIIL2LYJcMeoAF/QcXF4mBuDH0SxBlOKeMsNJhkTJd/BJJm7g5/i
iyvll38O+1G+SfDmv6cRiSScAfpaUbkiBsu9kLi+esuu28u3nbonKWtHvu+Ogkt0RLXvjhieht71
WNtN9x6ZCKg/deYDziuN2pR3QELan8oIaIp35FAKCq7Yf+Ly1jbcbTGO+RHWqx1Y0JrjXgOkYsOu
fOEQxrO4f2SMlenWvfuQfXh/hVVlO39tzeinppidrkPy6o6ujxqyElfJjnIj6NC7OA+g41MTDnl+
VC2n1md3OOiTpTNcuZItL/EROUne93eEBa01GPzaL0f0OQps9Rc0K1KRNnro3X9QV2wr3uCw4YrG
XoG7Wy8M5kHY6g3YiMNFshng5s/00mRDGCw/87iJxcr2vZuzhamUQQaMhFRnAeIBlBqHX3fiNFRC
FRxNbXvVF68e3QnN0thEf3h1P+/ubn1RrpxqGGBU+OKARMtUDWGtFC5LfQTVLgTUvcvpVNJL5h8O
32cQFjN13ljwQsSS/dPbey8T084Y0o+kKEdXpaMmrVryeGsu4RRcUwdL5875xMD1PR9kEcEje/6y
x2WfofTtfrDpg3VvSIhNnZDXHZv8+qqdthh05/pz1GiXsQCDNJ41Lm/ZrlQ5UeG3OL9UM+DT17i+
pwnKoqeEzXBn+tUF1uY0Vu1wnaGPiFJkq/3yuPHvmnV+OzHfi3Vln9jTu9435/LgaePqPprwX6Go
K8ykgHXMrbkeRXApEZm5yXtms4pLHL1onTOzgYALb1dBc360EFh0BBfyxOplI1dPqr7ABzEH6Bu6
coB/HyPUvulEw5JkksO/m42hHrrYZk0V5HEDLb6/WmE3KGPj5XxR3Qy5wIoQxG8zYS/IEvKxUCXH
LZhBSxUjJuawiIcgOcn8FLCvmJLAKOsSoCHJGgWeZqY6a/b7SuFeUlOcq4qq+oLU2Zk4SWzBkeIi
RRGQFwjjvcuwlqN7HqunZfXwFsQc/RILT0y/VbaBtdpEDS7MMR17S5HFZld9tFZInSHJJM7SqV5e
OE3L2/Sot7fYblH1RDm3Pr6jcmwpmIwkF3jHbH8LLBXwhupoKyKfX6toTwbDguPCCSEDGmNgZVVa
j126JewNQAuiy5QDovIOWcY3XDdbW+H1Ofh9K0Zc40EkWpluYGl6R3stLwj2Tx/4w1VIfmQ8/TWt
zXJtyozJL3ghAg4IRgfCOiv7Ls1AVBOlk3axbTYJTmTm06r4qN1urJI9VkSHDYMnIDVuEKvO6aEQ
x3iAAyy9rkn9tsxBbJkPq3AcCnb4ktm31DX8eLs+V1/HcRJ32YUobNq+4zKzbf6TucFTKbdJcO4E
FP5OUj5BrbUTu1z5F/8fSK0kPnWQH1QMVtDgd817vhW0oLkV5hooxnZNybP2yh2PTVV9KKbciovh
dN6P1btdpdkqXk3aYaG6/np5M1WWo5bTbr0LlSvo/38R4/MlZwGC2OQlyO0XPWNVULU7rRq4pzzt
czWSZ67+7c954rcHLIWSm0X59BPCLo85EQ3ag5kt0/2nXkdQla2xP+kQ5l5CaTa1jb0KVSKCVUd6
smnJ5bfchOgib126OHrozFiQY0U65G+ziWLk8n3xbWhTGWWlfK5w1/Av/pDfQOB6DXpAo8CDGFBg
3Cx4BLRk1FpRxcsRgCiIdtYlbubjLh/FtnALfT9Km0VoG9QCQbYrNrD2ckU32HZjm1ZQd/ekvp++
pJMehvaQJAGjMqP0DJ9lBFFbE78Qf0f7eZcOZbGLGjEG67/x1dawWSciEXVqWQO9seZHV5tsuiLm
+/bqJx13NqJ7XlQKw++xkw9r3myl1kUu6wOKmyklevqFauM/EdO1yM0ZX8gUi4+VcFADqhMs/C3u
6FLacXCYYDsU4RESBBs0eNV7fyNfm7GCNm+ZxzT2Yy1C8fo27TdnHUa9rH6GHY+eJhpsM5GFPKQG
jD7gGVml2OqQKNXUGnibX+0cd/n46TDAi763S2GvRiKkINS47k9R7d+WhgxNNKgBjoiqipce2kh5
8nChVHbr0TQSqvI2puYzwYjhpwe3gHLYei8mBWWVPMTZDbpKt0Nm8P+xPUepv7ZHJnBqOczGICjJ
RtPbELc9d/gfU10jaFc99DWL1DdqJ9VSWY/iFqeQYi3e/+vC5Cv+X+hyn8YXmCa1Pw3M18LH7JQ5
HJ4gDLqCXDuVar3ynouTGyCsNGycQFDYyGl6G7dTetW8PoesEXQd6I7n2qOUGtlSwkI62gtCAo8S
Wt7uMr/154+n/18HPOG/x5jtSypTbfUfJlan0ZTFQeBmQIGI08UxWrQXqP0Pyndd4VmMNMK49csE
ro/cMVMyIUtlrbWpww8SS/yS/kQf/CkGwx2qmDDkxi8LuEC2CkJziVkfJbf9QD7GkLuUuaWGHJ0Q
ewhJ9ntsqe3CWJluSYNIvLUzklqh6d2VD4H2rYe8qD2yiYRlxffyEmCrTwOUccw+FwCFDjof6KMk
taz88b8fJzwkHWZTWUb8NXeM0g+qyjCamn+ntad1tfmiOJwEd4QlCa5A0kebZwok5Ljuo0HUPGPQ
2A8ohCPkwtLNysVBpCQ1QoAY9QUylLTdnhD22aUVPGH+2NTFzd+pZjDL+rTAWtkeyx5CmrjWQMam
piYO9swHGJz+un3j4fvpmMPYpW1soCLTV1vw7ss72+Wgzt4Po6alax3KZQsQ/aAQeJP61VQQZduH
DDizIsdx6IXkfl5t8ajYcSb8LXns0veii/aP1BUEuDWpmVahCQ+WWbhxZNvzWS46NMpKvtrgthBq
7X6LBDqG7mbhDklh0rZ15/vowwx2tw+qvClWp3L8AbLt0ygV5hUOBUXx62I3R8m73wK/CpERdK0g
XHCh51UhSe5oSQOU56RjahLM1gf/6WbkVj9HhL6VTM/lCGgu2zqyj8jfwLZdf2LBzVyq8M7rN3g5
WeUwUn6kJ0s73VbcE3lXGSXVAU9xWs+WQ1eftqWLW5spRxEfR16QX1wMNdtSR6X6YZJxxkGFWO0h
0yi1EYgWPZduCdaqFXhkiPImsmyVe6FlWG+kbqtER0+Z9eDZJVIYp9bQjKgBAxPICYy8ocHCxbDj
7v5vZsXFZlmQRRnLaexIYFeYRKhhp2lMaNsUaoE38+97wZhKjUgFVI1gUe584js81gNpgkUHsLXV
Y+NrpkkkkL2nwz/eSs9Z2TG69I1ph8fBcZPI8VVG07xskKY31q1jJuP5nN+0xwNeIIJG+K8yfPwb
wIUY9Hu7yW70bNfEsr8luSAri+rfhBKCJPcH7a4xvT7xTyxRIkIqKPt78pDl90AqvEPckYxwvfCa
yYet4OwsDWl2xO6JKYAa8SqNk3bDU5R6W/chSwftUvVqodMi86foL/4aroHH3yl0MfujQ13ygt4P
H8DUlbM0aKYpFYFDI+AJk/7nr/6seu9q2MD3nKHxlyFho/gea0uy9lyPwqBK5OB99hZ5ublIcKdS
14Np6b2xaMKYsvoJuLcr1KEePRhzc/E7bi6u+vehsw46AKm6Oa1ioEDi57pD4dDsIJ7X6RGml1kz
SWWcFwH/j4ImFxX4jvHngfVrcgJLI6K9g7NuLXiPkQtGVb8bXkaZvZnCbtSgejpFwZ174IBcl/Px
C64CbzTwXQyLg4nwC/RNC/RaBx4W12aLJwEdtR4NdPIvi74YkBGKzkCY5+aAlZz1P8DKz9FaLa6q
f5xCVrAk0WYLV0l0YR1OzM41i2dMnrYoQ4Jv93ViVG4mtcDSN1OBJgXaZA3J8gK6TuZtdmipQ35s
VryCmLfv9KF5Ld7EK2sk71QWg53Ho7OW/0TFU7DN39PtJ79wWccGhPx/aQC4ZeTOxZCdsPSy7h1n
6j2mwHKukKWzFxavElUADYsKrpVpUYt4Yi9Cclp+8myrjWxYgqWCZOBKtynmfEgQW9JgcItUPn/7
bRG8Aw6DW5w37BumpU6Xpb1NpLrBgrl0Zljc+XsuSRQ7/P7uIvzpFkscJ79Ru1aoToIvUUicVEq6
NRcrcTVQB++jhjKXRjvXrs1Xp+UHjiDeFR2z54At68zzDabAF+M63qp3EVPUcw2QBqfbF6fM7dho
sEO1rcORMn77Xtkhb5Dbto4WjuJXImrYQcN2t1yLynriTZYGOKsRyupynSgmQucO4OHKflv8BYLe
ANaU1xFOTFAOqPC9ruFuG1Oiv9p3K6lAnRtPQjW8sKBBvXoZprr++5S8gw0jGed/GHb2PaAJ9NlH
1wZ/USQ86TCdV0JWpf+03bB5+Eyhhv8WNCGb001KTnL5DhiO8PQKB3L7NFGsMI2Zkttcpuvzfmsb
5nB38QdFHyB62jiBQGQly7VFOBcdOtqD91p+3fCVpYoL0pQYcvorshQ3AsgUX9FXOGYLdk4PD1iH
8RaLyg31EQkwiOQe4wCQ4daRcKFBIkvbWjvLplso4cwOpO6axGjbVYtpdHhuCmbji620nPuSPBYD
MIz3GaW67kf24m29Mua8KoE7dC56AQrLyKSO4S2RXfFYqMXEKpNe2Q7Vdcf0HsGYPnCvckSMCHWa
RtkVO4VeCpLKF+WlS1b84jgR7bkPlqJXKlwkqN61hCETSHE9ugn8YXdhVF13H91MxLlMbzVAaCsG
uUOHaPz4/HHgiX6mBpo/tvnO8DxARkr/rK2KP7nynvZ7siMmTUSG0iUGR5zX2se503QoU6RIb+3h
n1A2MGVIw4tOGw7IatPRcnkQ3t23Zk/Dswoh6hyB6oyPZz3/l0yuCJGBPQeuc9okSCXEd1mcjZ7M
SRrNAWDYo6CCdLIcAqoRlMMI4L/O9tstdVidLKFzJbAnqFLxTCDWOjlivDQxoc2AvlIlYGiHbIS6
2GDz2qnkkCMakxP/wOduQ1X8+5D+zT6EMWQcMVJKd75oxXgE45DaHnBSlCnsMK/XrRmm1tIndwAQ
4BFTbsgUJhy/4pc4O0fhiljmCtyrnIfpPbxs//xw0DOzNRu3OyB3+Rq2nuJdIumZXl0OeGkOtS/H
T3xmTeuce8iOK4f0tbLrdDU/p2Ud++kHfN1NQu6N5gSdtViWa3O9BrIM9q+opD+WXriqSf/2GkWW
6sBq5Ozx+255rbNCQb5VW628RT9na/Da7Sd2C9rzQqaMxsTpyxP8Q7z1VVqbGaEEi06fkvoWElZr
lZsaFCMDjIJG7RUCw9DeM5cGI+dI7iHWoMuIR17hD9Vxwijvb3XMnS5Oy84nW4emTgigXfkiZvfD
/RTDeTqH0kws75lvjyghAjtYIa+fhh1ZZpCAItusNWnWiBd3DB6mSR8Qmd1jPwaOVhFJLYofoXnL
n8d6Ik63Y1WlChaZwGNeAKdc6IksIzqIUStkbJb0XF7d0fhP+qeE7OZbSM10Tvn3Ytr2zEZu96vz
HU2E+XzRfdfUOkRN6olf8yNgBcl1SwXIOOLRlKmjVvEuf0vGN7o4armnTuWM89H4ba3gN9wRHRz9
6bfGHAm19DNRS80t579mlbuCe/JxPK/gf4SEv8A4gjwKfgouDP0HDiuY8WGRtL5JkK10ySXi/eY+
9YHUNXN6voDGCly8DUtBZdZ74/7smbFQWQnNUZGF/8qeD9b8JKbSAk3RcP3gdaiCYMQkF+JhPTMe
HbI9V94FKC0UXsFqbH28Q0UkudA3+fSJeeR7e5gpyzkdqkDpIgphzN92UlrHQNMxe3rcPt6Lm46A
zfq8wgTy4s3TADLeOIiepvwwIa5htufhkPUR8bEMYrcZZ5yHyJS0q6xN9j7ip10MBrEOR0S/uGW/
AttW/X9KagEVWHxJmgozd1v6eRp0XWCcSreSe7VWlhaLU9DVJATCmQfDZ3PHfTQYGImjOfp5tECB
ev9f0CPnB3hGSnd/Oe1W0jJYuLom27A20mH6KusJDGovdpbM/D/PyXdts8LAVFqhL7DHjdaZaaT+
iOfrRjZkic60opBruSuLsyzPmnsxt7gyvoXOK8B8jcdIi7VCysCPAjQ46DV2DvrVsj5Z7+WEqGMa
ryjUo2Hpa572lmVBscWR5yk3CfKG62qZ3xXJdoGgV8bzHbgKM1MG1n7y0zbFJPiYVve2ulISYEsd
5cLcCtZNcN7zV9wMkTWnqu54Gky55cruan4YrWOxkdGh9/LLnrF+i1zaifOqEQIeU+oc8anC9tuO
JCdZzojLjVpnywSzjaFS6Iw36fiOz5s5R0ptEMM28Te5kIIxozz2yaOQoZqysVfkpncbuNMNI3kL
bh3JK5P8yhQ6vkHigdINMaLLFNRZH8cS+HPpVGUkpVmK5oI2uXff4CEmXJvHo71fx42XeLJ0tP2h
xcqhd1O96YRqsReCa9DN0eRdaBcJMD6iggYx4z9O4dC8RGr9UBmYHZBK9ulWNOysbwm94q8wxobZ
I/mUBJ2J4Z4PZgaJHSAZ5lY9jI6XF4JLOudjvvGMQGUt+Dr19Ct0PJcnLWL8b5AgLK4QjO/4iP5R
eUeTZv0DFNMSIYAAoh70f3ZQlQ0cPpSw8EjDOUHDFks7T+Tw8+z5IRS/wLiD4S8JMZs8AxfUAl4J
4eb3fya/MvUF7KMjQ/R46ZoCG//L53+yEbvvRjQTb9IaX5YUOzlJNZWLgkO9HNrQg6YAj2AGvK5O
/Iyxn/tfr4ecFHjKM6mRQi9x1OuriJhwq2c/8kOpILVBnZMU9/1+hWGAFGcNdU8OgWJ7/lkcLuZO
E8qkvIoGS2USWxlYMRnPdtZeY5unrGjtFgwmmkwFWlN/SfpMPXv4FC7uqGJW6ny3qQL1obEN7TRE
LS4EvDcwUTDhiC5z4l9sbIF2fywh/BcTLpmYoCwDCwk5aY5TPdqC+gCDTsSbf4SFeXAVXwXVdRby
tpuZ8DYxdghDPnbml1fEEbleRnBfCJFNyJP2HhccKheewGw7+MKO3cCXYLcMW7icuF9iThq4wvRX
phqMVul3q1oMzqdR+D5ES0mXuxyYYH7cGFGKZQgkag2Kaa9dqA5M+JIY2W9dGLsXi2AlrVLUQ+Hw
iX+sIgAQmVW3SXfvgn7rCdCnfvpewuq+0iUma0PsSSpbwLhBVm/n5QWqC6kgQwvdU+DmZax+On6Y
E10P+t4ouhEtTzyXvU596W7QL21rQOb/AFyeAnm9wPU3Ux9gxfvSCRfQaaM6r4A0TJb24qwifV7S
zoz321Ax9dpKxOPboeHxHM7tQ06Fgv9ZgzMcpYN/ptiovuesj7kolfHzwz/c9xFEXaaJ4P9Gek9l
KNpQeRzSkg41VCmXQUT4ooPTnwa3XaM7U1nU5G4+0Xwnfp/+yMkmz4fbyDmoxF3BozWfzxFAmogg
9/66pLSCOGmoczWILswC5CUHQEvg4I4Xswoob6d8QMWSUFoXQx2VTywHCzjGoaETy2Pk0oxotstH
sC6idDqwqY71gJ9Cv4xZdj3QffPdofi9s3HcS0MXgTsBSJ/bN8UqdSDAlitSjfSf/YOv42ntACLJ
LPiYsrPvlmmGtsaxERCuRg0RTr+Y8WsoSTdnpUj2ZBu3nWmzazRM8GJiR7QLSaqTLR1BNGwq1JRu
rkrNmbkBLI96/FyfbIcNABG0QFNWB5VtAj1xUKD029fNITZLY33cbeRnkkb3cJydMUDsmYs6JjdD
wDGI12olhzICbyBQIUbKO47TENOb4EEZwmc6Z8g1E44l1u2jYV9/GiB2ghUQy5bFldtgOZrCS/q5
nvkoQp7zmIayCxU0W8YNgu+Z74KWRg0jRPQxwSu38N8eyRSNpT4WWIXSmA7YG0o56c12ItHwlEkv
/X99SPFy68F2YRoTI/VhoNH0EbtBHDp9pJeyxpidnx2A9X+Q7T9tMYIcRGu6gtfeSHo/Wl1407ZY
ALpXQVV/3/Z53Uikin7SOz82/w2kpEu+qQMVKoNwtb+oRzdpxv6ueI1WiITOjR5Fa7CSiJGOOSJH
ISdBHYEYuppZ9YUr3dME95Pi39aOVChH8s7RjN/tOyul70reJWbvvYiAVMHe8bDtO6QhUzO+0UOF
Hc91ROX3YjYt2pNyk5Kx6AEerdDlcuIel4MHn3xPXSSDzleeCUDK/aTvwIhvbpfsqaTclcSIV+Dr
JpGmn+BEKJu6jZzhLgO4vFt5Rx9iDWeIvBfTrc2Ra0BFD1tg/4q/L65hKdh1TLPp0UJsxw+vuhjG
eXQYfYsMx529fuTUoY1+U/MElG3T6sy3UpqTqHZjnMdhDZLcNjmK1emBzvDNcaBPCj7ZtRJIeib0
aAk92824UtYHwov8jOj1bHX0Rxo9xuc/Q+L2IYWy4V+nOH4/eTL95PROzGiz3q49OcMJFycSeuYX
dbQESXC1es6HNcoHZbChHEZUgnRBwCsWVNJRF/9MLkFan21E25MqpOE3fjPTi+ac0kCUPEV4q5Ei
MpZxWBZDefVTnU3tvXgW0K2J4G1qt+P/aFV/CkEpHhwt1utScLo/3iTvTV30hPulsFga6Bj8OwZM
8VvGCgfbRMdpgE6k8IFPRCb/XthM34qYGSx2i/aXVY9oSbwj7auT7WXmA72uo81tE8St1IC3efG9
OKnRvSB3RmOpnFAgVEdtHyD0iLiCwnkx6PuTiUF/jzyMj8H9tWENWjzAuLf7OhaP5oMLkDgxF2UY
qYYk05CFN1YJyZcn6bkJTpvuim0B+uwky2lW9xaPslmH1HvYaqz3hImHomEVDQSu3gWciw0Oz/ZI
O57t+9NsX37l/qpn4sZ6Z0aZTpR3VsEdNlQY7LBSaMqEhorFGEPMDgsYGx+ur4I0v+hut4hFgnad
fDMSnrWPXcc8+rqxN2QAB32IajEFibpSQnVDWJ5MW/ECSjQtPTVkD9ifGIbd3MZvSDACl3NdHMXq
9/HdJHzUxboW1fsU247f1lQepMb+boDfKJOMwFIykWV2hwTpvtLgTIGghdA3l4whLACCzSQv3NeY
RP3sFV2J8E9Eyp36sfOBXM9YGvXozospCV8nWIMhMvm6q5Okz1M3VM7HIUOJIUXC6215pc0yMvO7
XlpNEbHwsNIG2j3SrkXNnCVGQx8S7ZAvqd4YTlmuvh7TR6JWM2Ro/kTZLLwcZMDQlP+wGgmYxr8Q
iLAEpEz4Fbeo2nR0m0cuzynvhD4ePGXVuNe0jdNrQMqC8Wfe9GQmg8KoEBRrWvRFd3hbmkVeo/bS
c8Q7Biss7D1QyOgZNPJg+S3bwYoQrjRH9E0p6u5RLIlTU8ZW9eCA/gqhd0NaCPaE7NhEGEuetIeX
IKKT0pIWopd+Op+y3hfT0CWbnYVsmMc/I7p21w3I3DYk8Kpuz1fz/K3i/DhXYy0CerEi0zzVOD46
0YxDjzqSuSQhUwHNNIfpTaClmSRQGuO5RzZ1jM+l4PSK7BLUJqdX6Kuyram+lwp2OaOCqVnpM4Dt
/2WoOSeaDfPfmVauzOEt1C6ArEciPA457deljSW+X7GCpdFI+LCw12Fk8UIO4/YEnecKPfd6cpHs
NmIJ1yzlPQRy47yo6RnVqYKLMIGorF+YV5u4r7yZgRWmmxR1mW+KytD49RnfbQ35zSHBm5OIUaNW
zhQI7/d8ALD83WXdT3OvqfnzWUcH7InnGeiap5D5sulWutdpq7KC/CV04ggXkIw0rYH76MT+mxrA
oInQNuzetxZBcNhvisZgUhZDyRYOLkiY5w0p13QtvHB0UdGwv+ggEB8Y8fH4ToOWtIjn2fwI6j2b
cdtZBUbaK6jDPbyKmttJDsTmezp5khHm25BA8cS4oSaU73iNreYCdn76cHtgfcd9GBxCBkHXtP3t
ayC/tNcay/6gkDV+isRc7OzUbju9w2AMH+jLT7D3Jy0ZuaTwq4f+ewxZFhfvs2v+Mtei5z9ootCT
S9364e3dI/0z3zPoWc2fS6npWtrnOjXXYM/XBZmRHuPqNk30Z9LHGFHn8VQ69jDho8lYlXbQj1OO
2sZH6dRf8aPqGyd94kFzDXup+z3WLgUoS1ILDLzx/Qfq3YE8dGTObRLxq/iEUKaRfCn3ij3jjj+W
u2TbXRITS6G/AHKb39AEcop/bJX4b3Jk1OmQhKjSdq4mgF+9H20voXjsfDxdOqbJk4bGFe1JtUzk
33dbQ6ajm2dYlva2xLqJ+dYv6DRzv4k4MD3cX8E8U3nudXnkCTsGGJ2BiHDwtAltE2JEF/SC975R
deKGvW/jEYn97PBlokhRIDy4d5LoyJjgwncFIpW9evznIt8/VsK4/JuegSM80Sfcq3qGLqv+N2om
YZVzFgGCHcdhWGIJYoYOsfI93HjCTbMVwG/Ftsofc9J501svZXIrGMml7juQxTKOanSLKs0MEQbh
gGeEOMFKf297PNH7A5prrjQ8AQSIkF7GerkEEOVYgG7i0qGFJeL+CeEJZfTQUncTCgvpm5awhiNY
iDnaHDpaMTPfelscaRrZZi3S/ZipICMsWpuIgcHkyBUlLUmBBu/ORr1a/quslyTUB/sogGHABFsS
4UiwceuXUCS/pwgU1FmxoLMMsTaRQz6O1CXxJtBvP/9jhRVx7+7pXixo4xn2RW1y4d5w3F3M6UaI
hPYM
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
