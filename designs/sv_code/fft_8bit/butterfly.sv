/*
    This module completes the butterfly operations
    in a three stage pipeline (stages 0 - 2).

    Every stage is single cycle except the first one (stage 0),
    which contains a multiplier, that has its own three stage pipeline.

    The three different stages are three AXI submodules
*/
module butterfly #(
        parameter width = 9,        // data word length
        parameter twidwidth = 16,   // twiddle word length

        // The following too parameters can be derived from the above but must be inserted as a ckeck
        parameter multwidth = 25,   // the multiplication width (width + twidwidth)
        parameter intrwidth = 24    // internal width after multiplication
    ) (
        clk_rstn_intrf.slave                clk_rstn_i,
        axi_ctr_intrf.s_axis                s_axis,
        axi_ctr_intrf.m_axis                m_axis,
        input logic[0:3][width-1:0]         data_i,
        input logic [0:1][twidwidth-1:0]    twiddle_i,
        output logic[0:3][intrwidth-1:0]    data_o
    );
    
    /***********************************************
    *   Internal Signals
    ***********************************************/

    logic [0:5][intrwidth-1:0] data_s0; // data output of stage 0
    logic [0:3][intrwidth-1:0] data_s1; // data output of stage 1

    axi_ctr_intrf axi_s01(); // axi interface between stage 0 and stage 1
    axi_ctr_intrf axi_s12(); // axi interface between stage 1 and stage 2

    /***********************************************
    *   Module instantiations
    ***********************************************/

    butterfly_stage0 #(
        .width      (width),
        .twidwidth  (twidwidth),
        .multwidth  (multwidth),
        .intrwidth  (intrwidth)
    ) butterfly_stage0_inst (
        .clk_rstn_i (clk_rstn_i),
        .s_axis     (s_axis),
        .m_axis     (axis_s01.m_axis),
        .data_i     (data_i),
        .twiddle_i  (twiddle_i),
        .data_o     (data_s0)
    );

    butterfly_stage1 #(
        .width      (intrwidth)
    ) butterfly_stage1_inst (
        .clk_rstn_i (clk_rstn_i),
        .s_axis     (axis_s01.s_axis),
        .m_axis     (axis_s12.m_axis),
        .data_i     (data_s0),
        .data_o     (data_s1)
    );

    butterfly_stage2 #(
        .width      (intrwidth)
    ) butterfly_stage2_inst (
        .clk_rstn_i (clk_rstn_i),
        .s_axis     (axis_s12.s_axis),
        .m_axis     (m_axis),
        .data_i     (data_s1),
        .data_o     (data_o)
    );

endmodule : butterfly