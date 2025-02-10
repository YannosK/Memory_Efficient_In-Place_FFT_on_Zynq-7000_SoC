`timescale 1ns/100ps

module processing_element #(
        parameter width = 8,        // number width
        parameter twidwidth = 16,   //  twiddle number width  
        parameter shamtbits = 4
    )(
        clk_rstn_intrf.slave        clk_rstn_i,

        axi_ctr_intrf.s_axis        s_axis,
        axi_ctr_intrf.m_axis        m_axis,

        input logic[width-1:0]      x0r_i,
        input logic[width-1:0]      x0i_i,
        input logic[width-1:0]      x1r_i,
        input logic[width-1:0]      x1i_i,
        input logic[twidwidth-1:0]  tw_r_i,
        input logic[twidwidth-1:0]  tw_i_i,
        input logic[shamtbits-1:0]  shamt_i,

        output logic[width-1:0]     y0r_i,
        output logic[width-1:0]     y0i_i,
        output logic[width-1:0]     y1r_i,
        output logic[width-1:0]     y1i_i,
        output logic[shamtbits-1:0] shamt_o
    );
    
    /***********************************************
    *   Generate Block / Pre-Synthesis Check
    ***********************************************/

    generate
        if (!((width == 8 && shamtbits == 4) || (width == 16 && shamtbits == 5))) begin
            initial begin
                $error ("[processing_element]: wrong parameter values");
                $finish;
            end
        end
    endgenerate

    /***********************************************
    *   Local Parameters / Constants
    ***********************************************/

    localparam width_fractionals = width - 2;                   // number of fractionals
    // localparam twidwidth_fractionals = twidwidth - 2;        // number of twiddle factor fractionals
    localparam shiftwidth = width + 1;                          // one bit added in the shifter
    localparam multwidth = shiftwidth + twidwidth;              // the multiplication width
    localparam intrwidth = multwidth - 1;                       // internal width
    localparam roundbit = intrwidth - 3 - width_fractionals;    // the bit we round
    localparam ports = 4;                                       // 4 data streams

    /***********************************************
    *   Internal Signals
    ***********************************************/

    logic [0:ports-1][width-1:0]                input_to_shifter;
    logic [0:1][twidwidth-1:0]                  twiddle_input; 
    logic [0:ports-1][shiftwidth-1:0]           shifter_to_butterfly;
    logic [0:1][twidwidth-1:0]                  twiddle_to_butterfly; 
    logic [0:ports-1][intrwidth-1:0]            butterfly_to_rounder;
    logic [0:ports-1][intrwidth-roundbit-1:0]   rounder_to_limiter;
    logic [0:ports-1][width-1:0]                limiter_to_shamt_producer;
    logic [0:ports-1][width-1:0]                shamt_producer_to_decider;
    logic [0:ports-1][shamtbits-1:0]            shamt_outputs;

    axi_ctr_intrf axi_shifter_to_butterfly();
    axi_ctr_intrf axi_butterfly_to_rounder();
    axi_ctr_intrf axi_rounder_to_limiter();
    axi_ctr_intrf axi_limiter_to_shamt_producer();
    axi_ctr_intrf axi_shamt_producer_to_decider();

    /***********************************************
    *   Direct assignments
    ***********************************************/

    assign twiddle_input[0] = tw_r_i;
    assign twiddle_input[1] = tw_i_i;

    assign input_to_shifter[0] = x0r_i;
    assign input_to_shifter[1] = x0i_i;
    assign input_to_shifter[2] = x1r_i;
    assign input_to_shifter[3] = x1i_i;

    /***********************************************
    *   Module instantiations
    ***********************************************/

    shifter #(
        .width(width),
        .shamtbits(shamtbits),
        .twidwidth(twidwidth)
    ) shifter_inst (
        .clk_rstn_i(clk_rstn_i),
        .s_axis(s_axis),
        .m_axis(axi_shifter_to_butterfly.m_axis),
        .data_i(input_to_shifter),
        .twiddle_i(twiddle_input),
        .shamt_i(shamt_i),
        .data_o(shifter_to_butterfly),
        .twiddle_o(twiddle_to_butterfly)
    );

    butterfly #(
        .width(shiftwidth),
        .twidwidth(twidwidth),
        .multwidth(multwidth),
        .intrwidth(intrwidth)
    ) butterfly_inst (
        .clk_rstn_i(clk_rstn_i),
        .s_axis(axi_shifter_to_butterfly.s_axis),
        .m_axis(axi_butterfly_to_rounder.m_axis),
        .data_i(shifter_to_butterfly),
        .twiddle_i(twiddle_to_butterfly),
        .data_o(butterfly_to_rounder)
    );

    rounder #(
        .width(intrwidth),
        .roundbit(roundbit)
    ) rounder_inst (
        .clk_rstn_i(clk_rstn_i),
        .s_axis(axi_butterfly_to_rounder.s_axis),
        .m_axis(axi_rounder_to_limiter.m_axis),
        .data_i(butterfly_to_rounder),
        .data_o(rounder_to_limiter)
    );

    limiter #(
        .width(width)
    ) limiter_inst (
        .clk_rstn_i(clk_rstn_i),
        .s_axis(axi_rounder_to_limiter.s_axis),
        .m_axis(axi_limiter_to_shamt_producer.m_axis),
        .data_i(rounder_to_limiter),
        .data_o(limiter_to_shamt_producer)
    );

    shamt_producer #(
        .width(width),
        .shamtbits(shamtbits)
    ) shamt_producer_inst (
        .clk_rstn_i(clk_rstn_i),
        .s_axis(axi_limiter_to_shamt_producer.s_axis),
        .m_axis(axi_shamt_producer_to_decider.m_axis),
        .data_i(limiter_to_shamt_producer),
        .data_o(shamt_producer_to_decider),
        .shamt_o(shamt_outputs)
    );


endmodule : processing_element