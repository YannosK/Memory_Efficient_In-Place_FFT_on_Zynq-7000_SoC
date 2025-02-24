module shamt_decider #(
        parameter width = 8,        // the memory width of data in bits
        parameter shamtbits = 4     // 1 right and lg(6 = fractional bits) = 3 
    )(
        clk_rstn_intrf.slave                clk_rstn_i,
        axi_ctr_intrf.s_axis                s_axis,
        axi_ctr_intrf.m_axis                m_axis,
        input logic [0:3][width-1:0]        data_i,
        output logic [0:3][width-1:0]       data_o,
        input logic [0:3][shamtbits-1:0]    shamt_i,
        output logic [shamtbits-1:0]        shamt_o
    );

    /***********************************************
    *   Generate Block / Pre-Synthesis Check
    ***********************************************/

    generate
        if (!((width == 8 && shamtbits == 4) || (width == 16 && shamtbits == 5))) begin
            initial begin
                $error ("[shamt_decider]: wrong parameter values");
                $finish;
            end
        end
    endgenerate

    /***********************************************
    *   Local parameters / Internal Signals
    ***********************************************/

    localparam ports = 4;
    genvar i;

    logic [0:3]                 r_shamt;
    logic [0:3][shamtbits-2:0]  l_shamt;

    logic                   max_r_shamt = r_shamt[0];
    logic [shamtbits-2:0]   min_l_shamt = l_shamt[0];

    logic [0:1][shamtbits-2:0] temp_min;

    /***********************************************
    *   Always block / Immediate assign
    ***********************************************/
    
    // generate
    //     for (i = 0; i < ports; i++) begin
    //         assign r_shamt[i]= shamt_i[i][shamtbits-1];
    //         assign l_shamt[i] = shamt_i[i][shamtbits-2:0];
    //     end
    // endgenerate

    generate
        for (i = 0; i < ports; i++) begin
            assign {r_shamt[i], l_shamt[i]} = {shamt_i[i][shamtbits-1], shamt_i[i][shamtbits-2:0]};
        end
    endgenerate

    always_comb begin
        if (r_shamt == 4'b0) begin
            max_r_shamt = 1'b0;

            if (l_shamt[0] < l_shamt[1])
                temp_min[0] = l_shamt[0];
            else
                temp_min[0] = l_shamt[1];

            if (l_shamt[2] < l_shamt[3])
                temp_min[1] = l_shamt[2];
            else
                temp_min[1] = l_shamt[3];

            if (temp_min[0] < temp_min[1])
                min_l_shamt = temp_min[0];
            else
                min_l_shamt = temp_min[1];

        end
        else begin
            max_r_shamt = 1'b1;
            min_l_shamt = '0;
        end
    end

    always_ff @(posedge clk_rstn_i.clk or negedge clk_rstn_i.rstn) begin

        if (~clk_rstn_i.rstn) begin
            s_axis.tready <= 1'b0;
            m_axis.tvalid <= 1'b0;
            m_axis.tlast <= 1'b0;
            data_o <= '0;
            shamt_o <= '0;
        end
        else begin
            s_axis.tready <= m_axis.tready;
            m_axis.tvalid <= s_axis.tvalid;
            m_axis.tlast <= s_axis.tlast;

            if (m_axis.tready) begin
                data_o <= data_i;
                shamt_o <= {max_r_shamt, min_l_shamt};
            end
        end

    end

endmodule : shamt_decider
