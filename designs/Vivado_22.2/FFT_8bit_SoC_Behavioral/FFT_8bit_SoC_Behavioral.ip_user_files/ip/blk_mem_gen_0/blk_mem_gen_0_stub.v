// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu Nov  7 16:51:39 2024
// Host        : yannos running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/designs/Vivado_22.2/FFT_8bit_SoC_Behavioral/FFT_8bit_SoC_Behavioral.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_stub.v
// Design      : blk_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *)
module blk_mem_gen_0(clka, wea, addra, dina, douta, clkb, web, addrb, dinb, 
  doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[13:0],dina[31:0],douta[31:0],clkb,web[0:0],addrb[13:0],dinb[31:0],doutb[31:0]" */;
  input clka;
  input [0:0]wea;
  input [13:0]addra;
  input [31:0]dina;
  output [31:0]douta;
  input clkb;
  input [0:0]web;
  input [13:0]addrb;
  input [31:0]dinb;
  output [31:0]doutb;
endmodule
