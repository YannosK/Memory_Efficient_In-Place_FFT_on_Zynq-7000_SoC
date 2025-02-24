// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Feb 24 11:22:42 2025
// Host        : yannos running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/designs/Vivado_22.2/FFT_8bit_SoC_Behavioral/FFT_8bit_SoC_Behavioral.gen/sources_1/ip/mult_gen_1/mult_gen_1_stub.v
// Design      : mult_gen_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_18,Vivado 2022.2" *)
module mult_gen_1(A, B, P)
/* synthesis syn_black_box black_box_pad_pin="A[8:0],B[15:0],P[24:0]" */;
  input [8:0]A;
  input [15:0]B;
  output [24:0]P;
endmodule
