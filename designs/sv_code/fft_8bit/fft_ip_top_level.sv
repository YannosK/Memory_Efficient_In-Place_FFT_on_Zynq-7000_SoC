module fft_ip_top_level #(
        parameter points = 1024,
        parameter stages = 10,
        parameter stagesbits = 4,
        parameter maxshifts = 8,
        parameter wordlen = 32,
        parameter romwordlen = 32,
        parameter shamtbits = 4,
        parameter ramfile = "../../../dataset/8bit/input_bin/32_bits/1024_samples/0_in.txt",
        parameter romfile = "../../../dataset/twiddles/memconfig_2-21/twiddles_1024p.txt"
    )(
        input logic     clk_i,
        input logic     rstn_i,

        /*-------------------------------------
         Interfaces where the PS
         can write to the local BRAM
         of the FFT IP core.
        -------------------------------------*/

        bram_intrf.slave bram_porta,

        /*-------------------------------------
         Control interfaces
         that must become AXI4-Lite
         registers in the future work.
        -------------------------------------*/

        input logic run,
        output logic [maxshifts-1:0] total_shifts
    );


    /***********************************************
    *   Local Parameters / Constants
    ***********************************************/

    localparam ramlen = points / 2;
    localparam romlen = points / 2;
    localparam ramaddr = stages - 1;
    localparam romaddr = stages - 1;
    localparam width = wordlen / 4;         // number width
    localparam twidwidth = romwordlen / 2;  //  twiddle number width  
    localparam pairbits = stages - 2;       // number of bits to count the FFT pairs on each stage

    /***********************************************
    *   Packages import / Custom types
    ***********************************************/

    import dataword_pkg::*;

    typedef struct packed {
        logic [romwordlen-1:romwordlen/2] re;
        logic [(romwordlen/2)-1:0] im;
    } tw_word_t;

    typedef logic [romaddr-1:0] tw_addr_t;

    /***********************************************
    *   Internal Signals
    ***********************************************/

    clk_rstn_intrf clk_rstn();

    bram_intrf  bram_portb();

    logic datamux_sel;
    word_t data_mem_to_mux;
    word_t data_pe_to_mux;
    word_t data_mux_to_reg;
    word_t data_reg_o;

    tw_addr_t tw_addr;
    tw_word_t tw_data;

    /***********************************************
    *   Direct assignments
    ***********************************************/

    // packing clock and reset into an interface
    assign clk_rstn.clk = clk_i;
    assign clk_rstn.rstn = rstn_i;

    // packing memory interface into data word package types
    assign data_mem_to_mux = bram_portb.dout;

    /***********************************************
    *   Always blocks
    ***********************************************/

    always_comb begin : datareg_input_mux
        if (datamux_sel)
            data_mux_to_reg <= data_pe_to_mux;
        else
            data_mux_to_reg <= data_mem_to_mux;
    end

    /***********************************************
    *   Module instantiations
    ***********************************************/

    system_memory system_memory_inst (
        .clk_i      (clk_i),
        .bram_porta (bram_porta),
        .bram_portb (bram_portb.slave)
    );

    twiddle_rom #(
        .addr       (romaddr),
        .width      (romwordlen),
        .len        (romlen),
        .filepath   (romfile)
    ) twiddle_rom_inst (
        .addr_i     (tw_addr),
        .d_out      (tw_data)
    );

    processing_element #(
        .width      (width),
        .twidwidth  (twidwidth),
        .shamtbits  (shamtbits)
    ) processing_element_inst (
        .clk_rstn_i (clk_rstn.slave),
        .s_axis     (),
        .m_axis     (),
        .x0r_i      (data_reg_o.left.re),
        .x0i_i      (data_reg_o.left.im),
        .x1r_i      (data_reg_o.right.re),
        .x1i_i      (data_reg_o.right.im),
        .tw_r_i     (tw_data.re),
        .tw_i_i     (tw_data.im),
        .shamt_i    (),
        .y0r_o      (data_pe_to_mux.left.re),
        .y0i_o      (data_pe_to_mux.left.im),
        .y1r_o      (data_pe_to_mux.right.re),
        .y1i_o      (data_pe_to_mux.right.im),
        .shamt_o    ()
    );

    address_generation_unit #(
    ) address_generation_unit_inst (
    );

    data_registers data_registers_inst (
        .clk_rstn_i (clk_rstn.slave),
        .sel_i      (),
        .exchange_i (),
        .wren_i     (),
        .data_i     (data_mux_to_reg),
        .data_o     (data_reg_o)
    );

endmodule : fft_ip_top_level