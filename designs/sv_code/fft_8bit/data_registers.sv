module data_registers (
        clk_rstn_intrf.slave        clk_rstn_i,

        input logic sel_i,
        input logic exchange_i,
        input logic wren_i,

        input dataword_pkg::word_t  data_i,
        output dataword_pkg::word_t data_o
    );

    /***********************************************
    *   Packages import
    ***********************************************/

    import dataword_pkg::*;

    /***********************************************
    *   Internal Signals
    ***********************************************/

    genvar i;

    word_t [0:1] datareg;

    /***********************************************
    *   Always block
    ***********************************************/

    generate
        for (i = 0; i < 2; i++) begin
            always_ff @(posedge clk_rstn_i.clk or negedge clk_rstn_i.rstn) begin
                if (~clk_rstn_i.rstn)
                    datareg[i] <= 0;
                else if (wren_i && (sel_i == i))
                    datareg[i] <= data_i;
            end
        end
    endgenerate

    always_ff @(posedge clk_rstn_i.clk) begin
        if (exchange_i && !(wren_i))
            datareg[0] <= '{datareg[0].left, datareg[1].left};
            datareg[1] <= '{datareg[0].right, datareg[1].right};
    end

    always_comb begin
        if (sel_i)
            data_o <= datareg[1];
        else
            data_o <= datareg[0];
    end

endmodule : data_registers