`timescale 1ns/100ps

module shamt_unit #(
        parameter width = 8,        // the memory width of data in bits
        parameter shamtbits = 4     // 1 right and lg(6 = fractional bits) = 3 
    )(
        clk_rstn_intrf.slave            clk_rstn_i,
        axi_ctr_intrf.s_axis            s_axis,
        axi_ctr_intrf.m_axis            m_axis,
        input logic [width-1:0]         data_i,
        output logic [width-1:0]        data_o,
        output logic [shamtbits-1:0]    shamt_o
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

    logic signed [width-1:0] r_pos_threshold = (1 << (width-2));
    logic signed [width-1:0] r_neg_threshold = -r_pos_threshold;

    logic                   r_shamt = 0;
    logic [shamtbits-2:0]   l_shamt = 0;

    /***********************************************
    *   Always block / Immidiate assign
    ***********************************************/

    always_ff @(posedge clk_rstn_i.clk or negedge clk_rstn_i.rstn) begin

        if (~clk_rstn_i.rstn) begin
            s_axis.tready <= 1'b0;
            m_axis.tvalid <= 1'b0;
            m_axis.tlast <= 1'b0;
            data_o <= 0;
            shamt_o <= 0;
        end
        else begin
            s_axis.tready <= m_axis.tready;
            m_axis.tvalid <= s_axis.tvalid;
            m_axis.tlast <= s_axis.tlast;

            if (m_axis.tready) begin

                r_shamt = 0;
                l_shamt = 0;


                if (($signed(data_i) > r_pos_threshold) || ($signed(data_i) < r_neg_threshold)) begin
                    r_shamt = 1;
                    l_shamt = 0;
                end
                else begin
                    r_shamt = 0;

                    if (width == 8 && shamtbits == 4) begin
                        casez (data_i)
                            (8'b11111111 || 8'b00000001):                   l_shamt = 6;
                            (8'b1111111? || 8'b00000010):                   l_shamt = 5;
                            (8'b111111?? || 8'b00000100 || 8'b00000011):    l_shamt = 4;
                            (8'b11111??? || 8'b00001000 || 8'b000001??):    l_shamt = 3;
                            (8'b1111???? || 8'b00010000 || 8'b00001???):    l_shamt = 2;
                            (8'b111????? || 8'b00100000):                   l_shamt = 1;
                            default:                                        l_shamt = 0;
                        endcase
                    end
                    else if (width == 16 && shamtbits == 5) begin
                        casez (data_i)
                            (16'b1111111111111111 || 16'b0000000000000001):                         l_shamt = 14;
                            (16'b111111111111111? || 16'b0000000000000010):                         l_shamt = 13;
                            (16'b11111111111111?? || 16'b0000000000000100 || 16'b0000000000000011): l_shamt = 12;
                            (16'b1111111111111??? || 16'b0000000000001000 || 16'b00000000000001??): l_shamt = 11;
                            (16'b111111111111???? || 16'b0000000000010000 || 16'b0000000000001???): l_shamt = 10;
                            (16'b11111111111????? || 16'b0000000000100000 || 16'b000000000001????): l_shamt = 9;
                            (16'b1111111111?????? || 16'b0000000001000000 || 16'b00000000001?????): l_shamt = 8;
                            (16'b111111111??????? || 16'b0000000010000000 || 16'b0000000001??????): l_shamt = 7;
                            (16'b11111111???????? || 16'b0000000100000000 || 16'b000000001???????): l_shamt = 6;
                            (16'b1111111????????? || 16'b0000001000000000 || 16'b00000001????????): l_shamt = 5;
                            (16'b111111?????????? || 16'b0000010000000000 || 16'b0000001?????????): l_shamt = 4;
                            (16'b11111??????????? || 16'b0000100000000000 || 16'b000001??????????): l_shamt = 3;
                            (16'b1111???????????? || 16'b0001000000000000 || 16'b00001???????????): l_shamt = 2;
                            (16'b111????????????? || 16'b0010000000000000):                         l_shamt = 1;
                            default:                                                                l_shamt = 0;
                        endcase
                    end
                end

                shamt_o = {r_shamt, l_shamt};
                data_o <= data_i;

            end
        end
    end
endmodule : shamt_unit
