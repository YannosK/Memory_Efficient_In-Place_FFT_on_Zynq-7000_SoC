/*
    This needs
    - Some kind of AXI synchronization for the three stage multiplier
    - One solution is to use a non-pipelined multiplier
    - Else you can use some FSM logic
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

    logic [width-1:0]       x0r;
    logic [width-1:0]       x0i;
    logic [width-1:0]       x1r;
    logic [width-1:0]       x1i;
    logic [twidwidth-1:0]   wr;
    logic [twidwidth-1:0]   wi;

    logic [multwidth-1:0] A;
    logic [multwidth-1:0] B;
    logic [multwidth-1:0] C;
    logic [multwidth-1:0] D;

    /***********************************************
    *   Immediate assign
    ***********************************************/

    assign x0r_i = data_i[0];
    assign x0i_i = data_i[1];
    assign x1r_i = data_i[2];    
    assign x1i_i = data_i[3];

    assign tw_r_i = twiddle_i[0];
    assign tw_i_i = twiddle_i[1];

    // assign data_o[0] = y0r_i;
    // assign data_o[1] = y0i_i;
    // assign data_o[2] = y1r_i;
    // assign data_o[3] = y1i_i;

    /***********************************************
    *   Module instantiation
    ***********************************************/

    /* 
        The multiplier is generated with Vivado IP generator.
        It has three pipeline stages and it uses the DSP48 slices.
    */

    mult_gen_1 mult_A (
        .CLK(clk_rstn_i.clk),    // input wire CLK
        .A(A),        // input wire [8 : 0] A
        .B(B),        // input wire [15 : 0] B
        .CE(m_axis.tready),      // input wire CE
        .SCLR(~clk_rstn_i.rstn),  // input wire SCLR
        .P(P)        // output wire [24 : 0] P
    );

    mult_gen_1 mult_B (
        .CLK(clk_rstn_i.clk),    // input wire CLK
        .A(A),        // input wire [8 : 0] A
        .B(B),        // input wire [15 : 0] B
        .CE(m_axis.tready),      // input wire CE
        .SCLR(~clk_rstn_i.rstn),  // input wire SCLR
        .P(P)        // output wire [24 : 0] P
    );

    mult_gen_1 mult_C (
        .CLK(clk_rstn_i.clk),    // input wire CLK
        .A(A),        // input wire [8 : 0] A
        .B(B),        // input wire [15 : 0] B
        .CE(m_axis.tready),      // input wire CE
        .SCLR(~clk_rstn_i.rstn),  // input wire SCLR
        .P(P)        // output wire [24 : 0] P
    );

    mult_gen_1 mult_D (
        .CLK(clk_rstn_i.clk),    // input wire CLK
        .A(A),        // input wire [8 : 0] A
        .B(B),        // input wire [15 : 0] B
        .CE(m_axis.tready),      // input wire CE
        .SCLR(~clk_rstn_i.rstn),  // input wire SCLR
        .P(P)        // output wire [24 : 0] P
    );

    /***********************************************
    *   Always block / Immidiate assign
    ***********************************************/

    always_ff @(posedge clk_rstn_i.clk or negedge clk_rstn_i.rstn) begin

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

endmodule : butterfly_stage0