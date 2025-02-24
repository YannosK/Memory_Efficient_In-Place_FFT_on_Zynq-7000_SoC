module fft_ip_top_level #(
        parameter points = 1024,
        parameter stages = 10,
        parameter stagesbits = 4,
        parameter maxshifts = 8,
        parameter wordlen = 32,
        parameter romwordlen = 32,
        parameter shamtbits = 4,
        parameter ramfile = "../../dataset/8bit/input_bin/32_bits/1024_samples/0_in.txt",
        parameter romfile = "../../dataset/twiddles/twiddles_1024p.txt"
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
    localparam width = wordlen / 4;                      // number width
    localparam twidwidth = romwordlen / 2;               //  twiddle number width  

    /***********************************************
    *   Internal Signals
    ***********************************************/

    bram_intrf bram_portb();

    logic [romaddr-1:0] tw_addr;
    logic [romwordlen-1:0] tw_data;

    /***********************************************
    *   Direct assignments
    ***********************************************/

    // need to pass clocks and resets in the interface

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
    );

endmodule : fft_ip_top_level