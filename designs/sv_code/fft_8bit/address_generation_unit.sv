module address_generation_unit #(
        parameter stages = 10,              // FFT stages
        parameter stagesbits = 4,           // bits to represent the stages = log(stages)
        parameter pairbits = 2,             // number of bits to count the pairs on each FFT stage
        parameter addrbits = stages - 1,    // the number of bits of the address of the memory
        parameter twiddbits = stages - 1    // the number of bits of the address of the twiddle ROM memory
    ) (
        clk_rstn_intrf.slave        clk_rstn_i,

        input logic     trigger_i,

        output logic [stagesbits-1:0]       stage_cnt_o,
        output logic [pairbits-1:0]         pairs_cnt_o,

        output logic [0:1][addrbits-1:0]    data_addr_o,
        output logic [0:1][twiddbits-1:0]   twid_addr_o
    );
    
endmodule : address_generation_unit