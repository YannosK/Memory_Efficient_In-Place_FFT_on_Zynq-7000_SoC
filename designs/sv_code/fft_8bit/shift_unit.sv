module shift_unit #(
        parameter width = 8,        // the memory width of data in bits
        parameter shamtbits = 4     // 1 right and lg(6 = fractional bits) = 3 
    )(
        clk_rstn_intrf.slave            clk_rstn_i,
        axi_ctr_intrf.s_axis            s_axis,
        axi_ctr_intrf.m_axis            m_axis,
        input logic [width-1:0]         data_i,
        input logic [shamtbits-1:0]     shamt_i,
        output logic [width:0]        data_o
    );

    /***********************************************
    *   Generate Block / Pre-Synthesis Check
    ***********************************************/

    generate
        if (!((width == 8 && shamtbits == 4) || (width == 16 && shamtbits == 5))) begin
            initial begin
                $error ("[shamt_unit]: wrong parameter values");
                $finish;
            end
        end
    endgenerate

    /***********************************************
    *   Always block / Immidiate assign
    ***********************************************/

    always_ff @(posedge clk_rstn_i.clk or negedge clk_rstn_i.rstn) begin

        if (~clk_rstn_i.rstn) begin
            s_axis.tready <= 1'b0;
            m_axis.tvalid <= 1'b0;
            m_axis.tlast <= 1'b0;
            data_o <= 0;
        end
        else begin
            s_axis.tready <= m_axis.tready;
            m_axis.tvalid <= s_axis.tvalid;
            m_axis.tlast <= s_axis.tlast;

            if (m_axis.tready) begin

                if (shamt_i[shamtbits-1] == 1)
                    data_o <= {data_i,0} >>> 1;
                else
                    data_o <= {data_i,0} << $unsigned(shamt_i[shamtbits-2:0]);

            end
        end
    end
endmodule : shift_unit
