`timescale 1ns/100ps

module rounding_unit #(
        parameter width = 24,       // WARNING: internal width of the design
        parameter roundbit = 15     // the index of the bit where we round (the one that survives)
    )(
        clk_rstn_intrf.slave                clk_rstn_i,
        axi_ctr_intrf.s_axis                s_axis,
        axi_ctr_intrf.m_axis                m_axis,
        input logic [width-1:0]             data_i,
        output logic [width-roundbit-1:0]   data_o
    );

    /***********************************************
    *   Internal Signals
    ***********************************************/

    logic [width-1:0] mask_lsb = { {(width-roundbit+1){1'b1}}, {(roundbit-1){1'b0}} };
    logic [roundbit-1:0] threshold = '1 << (roundbit - 1);
    logic [width-1:0] added = 1 << roundbit;
    logic [width-1:0] rounded = 0;
    logic [width-1:0] zeroed = '0;

    /***********************************************
    *   Always block / Immidiate assign
    ***********************************************/

    always_ff @(posedge clk_rstn_i.clk or negedge clk_rstn_i.rstn) begin

        LEFTOVERS_CHECK: assert (zeroed[roundbit-1:0] == '0) else $display("Rounding unit should make zero the extra LSBs, before truncating them");

        if (~clk_rstn_i.rstn) begin
            s_axis.tready <= 1'b0;
            m_axis.tvalid <= 1'b0;
            m_axis.tlast <= 1'b0;
            zeroed <= '0;
        end
        else begin
            s_axis.tready <= m_axis.tready;
            m_axis.tvalid <= s_axis.tvalid;
            m_axis.tlast <= s_axis.tlast;

            if (m_axis.tready) begin
                if (data_i[roundbit-1:0] > threshold) begin
                    // blocking assignments purposefully
                    rounded = data_i + added;
                    zeroed = rounded & mask_lsb;
                end
                else begin
                    zeroed <= rounded & mask_lsb;
                end
            end
        end

    end

    assign data_o = zeroed[width-1:roundbit];
        
endmodule : rounding_unit