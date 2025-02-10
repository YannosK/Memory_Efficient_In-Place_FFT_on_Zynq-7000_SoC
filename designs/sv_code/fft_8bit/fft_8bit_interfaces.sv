interface clk_rstn_intrf;
    
    logic clk;
    logic rstn;

    modport slave (
        input clk,
        input rstn
    );

    modport master (
        output clk,
        output rstn
    );

endinterface : clk_rstn_intrf

interface bram_intrf;

    logic [0:0]     we;
    logic [13:0]    addr;
    logic [31:0]    din;
    logic [31:0]    dout;

    modport master (
        output we,
        output addr,
        output din,
        input dout
    );

    modport slave (
        input we,
        input addr,
        input din,
        output dout
    );

endinterface : bram_intrf

interface axi_ctr_intrf;

    logic tvalid;
    logic tready;
    logic tlast;

    modport s_axis (
        input tvalid,
        output tready,
        input tlast
    );

    modport m_axis (
        output tvalid,
        input tready,
        output tlast
    );

endinterface : axi_ctr_intrf
