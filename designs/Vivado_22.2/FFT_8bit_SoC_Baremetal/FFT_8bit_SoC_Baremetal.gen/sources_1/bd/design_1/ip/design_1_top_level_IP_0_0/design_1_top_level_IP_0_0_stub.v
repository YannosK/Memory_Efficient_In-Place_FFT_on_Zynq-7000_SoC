// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Fri Nov  1 14:09:40 2024
// Host        : yannos running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Yannos/FILES/PROGRAMS/FPGA/VIVADO/Cora_Z7/Projects/Full_FFT_System_Baremetal/Full_FFT_System_Baremetal.gen/sources_1/bd/design_1/ip/design_1_top_level_IP_0_0/design_1_top_level_IP_0_0_stub.v
// Design      : design_1_top_level_IP_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "top_level_IP,Vivado 2022.2" *)
module design_1_top_level_IP_0_0(FCLK_CLK0, peripheral_aresetn, 
  BRAM_PORTB_0_clk, BRAM_PORTB_0_rst, BRAM_PORTB_0_addr, BRAM_PORTB_0_din, 
  BRAM_PORTB_0_dout, BRAM_PORTB_0_en, BRAM_PORTB_0_we, S_AXI_ACLK, S_AXI_ARESETN, 
  S_AXI_AWADDR, S_AXI_AWPROT, S_AXI_AWVALID, S_AXI_AWREADY, S_AXI_WDATA, S_AXI_WSTRB, 
  S_AXI_WVALID, S_AXI_WREADY, S_AXI_BRESP, S_AXI_BVALID, S_AXI_BREADY, S_AXI_ARADDR, 
  S_AXI_ARPROT, S_AXI_ARVALID, S_AXI_ARREADY, S_AXI_RDATA, S_AXI_RRESP, S_AXI_RVALID, 
  S_AXI_RREADY)
/* synthesis syn_black_box black_box_pad_pin="FCLK_CLK0,peripheral_aresetn[0:0],BRAM_PORTB_0_clk,BRAM_PORTB_0_rst,BRAM_PORTB_0_addr[31:0],BRAM_PORTB_0_din[31:0],BRAM_PORTB_0_dout[31:0],BRAM_PORTB_0_en,BRAM_PORTB_0_we[3:0],S_AXI_ACLK,S_AXI_ARESETN,S_AXI_AWADDR[3:0],S_AXI_AWPROT[2:0],S_AXI_AWVALID,S_AXI_AWREADY,S_AXI_WDATA[31:0],S_AXI_WSTRB[3:0],S_AXI_WVALID,S_AXI_WREADY,S_AXI_BRESP[1:0],S_AXI_BVALID,S_AXI_BREADY,S_AXI_ARADDR[3:0],S_AXI_ARPROT[2:0],S_AXI_ARVALID,S_AXI_ARREADY,S_AXI_RDATA[31:0],S_AXI_RRESP[1:0],S_AXI_RVALID,S_AXI_RREADY" */;
  input FCLK_CLK0;
  input [0:0]peripheral_aresetn;
  output BRAM_PORTB_0_clk;
  output BRAM_PORTB_0_rst;
  output [31:0]BRAM_PORTB_0_addr;
  output [31:0]BRAM_PORTB_0_din;
  input [31:0]BRAM_PORTB_0_dout;
  output BRAM_PORTB_0_en;
  output [3:0]BRAM_PORTB_0_we;
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [3:0]S_AXI_AWADDR;
  input [2:0]S_AXI_AWPROT;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0]S_AXI_WDATA;
  input [3:0]S_AXI_WSTRB;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [1:0]S_AXI_BRESP;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [3:0]S_AXI_ARADDR;
  input [2:0]S_AXI_ARPROT;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [31:0]S_AXI_RDATA;
  output [1:0]S_AXI_RRESP;
  output S_AXI_RVALID;
  input S_AXI_RREADY;
endmodule
