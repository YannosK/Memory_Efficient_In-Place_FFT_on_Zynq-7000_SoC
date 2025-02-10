module limiter #(
        parameter width = 8
    )(
        clk_rstn_intrf.slave                    clk_rstn_i,
        axi_ctr_intrf.s_axis                    s_axis,
        axi_ctr_intrf.m_axis                    m_axis,
        input logic [0:3][width:0]            data_i,
        output logic [0:3][width-1:0]  data_o
    );

    /***********************************************
    *   Generate Block / Pre-Synthesis Check
    ***********************************************/

    generate
        if (!(width == 8) || (width == 16)) begin
            initial begin
                $error ("[limiter_unit]: wrong parameter values");
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
        for (i = 0; i < ports; i++) begin : limits_unit_array
            limits_unit #(
                .width(width)
            ) limits_unit_inst (
                .clk_rstn_i(clk_rstn_i),
                .s_axis(s_axis_arr[i].s_axis),
                .m_axis(m_axis_arr[i].m_axis),
                .data_i(data_i[i]),
                .data_o(data_o[i])
            );
        end
    endgenerate

endmodule : limiter
