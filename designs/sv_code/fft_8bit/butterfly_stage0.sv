/*
    This uses a sequential asynchronous multiplier
*/

module butterfly_stage0 #(
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
        output logic[0:5][intrwidth-1:0]    data_o
    );
    
    /***********************************************
    *   Internal Signals
    ***********************************************/

    logic [width-1:0]       x0r_i;
    logic [width-1:0]       x0i_i;
    logic [width-1:0]       x1r_i;
    logic [width-1:0]       x1i_i;
    logic [twidwidth-1:0]   wr_i;
    logic [twidwidth-1:0]   wi_i;

    logic [multwidth-1:0] A_o;
    logic [multwidth-1:0] B_o;
    logic [multwidth-1:0] C_o;
    logic [multwidth-1:0] D_o;

    /***********************************************
    *   Immediate assign
    ***********************************************/

    assign x0r_i = data_i[0];
    assign x0i_i = data_i[1];
    assign x1r_i = data_i[2];    
    assign x1i_i = data_i[3];

    assign wr_i = twiddle_i[0];
    assign wi_i = twiddle_i[1];

    /***********************************************
    *   Module instantiation
    ***********************************************/

    /* 
        The multiplier is generated with Vivado IP generator.
        It uses the DSP48 slices.
    */
    
    mult_gen_1 mult_A (
        .A(x1r_i),
        .B(wr_i),
        .P(A_o)
    );

    mult_gen_1 mult_B (
        .A(x1i_i),
        .B(wi_i),
        .P(B_o)
    );

    mult_gen_1 mult_C (
        .A(x1i_i),
        .B(wr_i),
        .P(D_o)
    );

    mult_gen_1 mult_D (
        .A(x1r_i),
        .B(wi_i),
        .P(C_o)
    );

    /***********************************************
    *   Always block / Immidiate assign
    ***********************************************/

    always_ff @(posedge clk_rstn_i.clk or negedge clk_rstn_i.rstn) begin

        /*
            The assertions test that we do not need the MSB of the results
            since it always has the same bit value with the next to the MSB
        */

        MULT_A: assert (A_o[multwidth-1] == A_o[multwidth-2]);
        MULT_B: assert (B_o[multwidth-1] == B_o[multwidth-2]);
        MULT_D: assert (D_o[multwidth-1] == D_o[multwidth-2]);
        MULT_C: assert (C_o[multwidth-1] == C_o[multwidth-2]);

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
                data_o[0] <= x0r_i;
                data_o[1] <= x0i_i;
                data_o[2] <= A_o[multwidth-2:0];
                data_o[3] <= B_o[multwidth-2:0];
                data_o[4] <= D_o[multwidth-2:0];
                data_o[5] <= C_o[multwidth-2:0];
            end
        end

    end

endmodule : butterfly_stage0