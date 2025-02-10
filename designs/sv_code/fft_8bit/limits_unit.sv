`timescale 1ns/100ps

module limits_unit #(
        parameter width = 8       // the memory width of data in bits
    )(
        clk_rstn_intrf.slave        clk_rstn_i,
        axi_ctr_intrf.s_axis        s_axis,
        axi_ctr_intrf.m_axis        m_axis,
        input logic [width:0]       data_i,
        output logic [width-1:0]    data_o
    );

    /***********************************************
    *   Internal Signals
    ***********************************************/

    logic signed [width:0] max_int = {2'b00, {width-2{1'b1}}}; // 001111111
    logic signed [width:0] min_int = {2'b11, {width-2{1'b0}}}; // 110000000
    
    /***********************************************
    *   Always block / Immidiate assign
    ***********************************************/

    always_ff @(posedge clk_rstn_i.clk or negedge clk_rstn_i.rstn) begin


        if (~clk_rstn_i.rstn) begin
            s_axis.tready <= 1'b0;
            m_axis.tvalid <= 1'b0;
            m_axis.tlast <= 1'b0;
            data_o <= '0;
        end
        else begin
            s_axis.tready <= m_axis.tready;
            m_axis.tvalid <= s_axis.tvalid;
            m_axis.tlast <= s_axis.tlast;

            if (m_axis.tready) begin
                if ($signed(data_i) > max_int)
                    data_o <= max_int[width-1:0];
                else if ($signed(data_i) < min_int)
                    data_o <= min_int[width-1:0];
                else
                    data_o <= data_i[width-1:0];
            end
        end

    end

endmodule : limits_unit