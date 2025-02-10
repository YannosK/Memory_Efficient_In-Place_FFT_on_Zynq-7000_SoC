module shifter #(
        parameter width = 8,        // the memory width of data in bits
        parameter shamtbits = 4,    // 1 right and lg(6 = fractional bits) = 3 
        parameter twidwidth = 16    // twiddle width
    )(
        clk_rstn_intrf.slave                clk_rstn_i,
        axi_ctr_intrf.s_axis                s_axis,
        axi_ctr_intrf.m_axis                m_axis,
        input logic [0:3][width-1:0]        data_i,
        input logic [0:1][twidwidth-1:0]    twiddle_i,
        input logic [shamtbits-1:0]         shamt_i,
        output logic [0:3][width:0]         data_o,
        output logic [0:1][twidwidth-1:0]   twiddle_o
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
    *   Internal Signals
    ***********************************************/

    localparam ports = 4;
    logic [0:ports-1] ready;
    logic [0:ports-1] valid;
    logic [0:ports-1] last;

    axi_ctr_intrf s_axis_arr[ports]();
    axi_ctr_intrf m_axis_arr[ports]();

    genvar i;

    /***********************************************
    *   Always block / Immediate assign
    ***********************************************/
    
    generate
        for (i = 0; i < ports; i++) begin
            assign s_axis_arr[i].tvalid = s_axis.tvalid;
            assign s_axis_arr[i].tlast = s_axis.tlast;
            assign ready[i] = s_axis_arr[i].tready;
        end
    endgenerate
    assign s_axis.tready = &ready;


    generate
        for (i = 0; i < ports; i++) begin
            assign valid[i] = m_axis_arr[i].tvalid;
            assign last[i] = m_axis_arr[i].tlast;
            assign m_axis_arr[i].tready = m_axis.tready;
        end
    endgenerate
    assign m_axis.tvalid = &valid;
    assign m_axis.tlast = |last;

    /***********************************************
    *   Module instantiations
    ***********************************************/

    generate
        for (i = 0; i < ports; i++) begin : shift_unit_array
            shift_unit #(
                .width(width),
                .shamtbits(shamtbits)
            ) shift_unit_inst (
                .clk_rstn_i(clk_rstn_i),
                .s_axis(s_axis_arr[i].s_axis),
                .m_axis(m_axis_arr[i].m_axis),
                .data_i(data_i[i]),
                .shamt_i(shamt_i),
                .data_o(data_o[i])
            );
        end
    endgenerate

    /***********************************************
    *   AXI logic: twiddle signal propagate
    ***********************************************/

    always_ff @(posedge clk_rstn_i.clk or negedge clk_rstn_i.rstn) begin
        if (~clk_rstn_i.rstn) begin
            twiddle_o[0] <= 0;
            twiddle_o[1] <= 0;
        end
        else begin
            if (m_axis.tready) begin
                twiddle_o[0] <= twiddle_i[0];
                twiddle_o[1] <= twiddle_i[1];
            end
        end
    end
    
endmodule : shifter
