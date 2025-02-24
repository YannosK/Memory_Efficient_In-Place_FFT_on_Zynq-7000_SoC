module butterfly_stage2 #(
        parameter width = 24    // data word length - internal widht of the butterfly processor
    ) (
        clk_rstn_intrf.slave            clk_rstn_i,
        axi_ctr_intrf.s_axis            s_axis,
        axi_ctr_intrf.m_axis            m_axis,
        input logic[0:3][width-1:0]     data_i,
        output logic[0:3][width-1:0]    data_o
    );
    
    /***********************************************
    *   Internal Signals
    ***********************************************/

    logic [width-1:0] xr_i;
    logic [width-1:0] xi_i;

    logic [width-1:0] wr_i;
    logic [width-1:0] wi_i;

    /***********************************************
    *   Immediate assign
    ***********************************************/

    assign xr_i = data_i[0];
    assign xi_i = data_i[1];

    assign wr_i = data_i[2];    
    assign wi_i = data_i[3];

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
                data_o[0] <= xr_i + wr_i;
                data_o[1] <= xi_i + wi_i;
                data_o[2] <= xr_i - wr_i;
                data_o[3] <= xi_i - wi_i;
            end
        end

    end

endmodule : butterfly_stage2