module system_memory (
    input logic clk_i,
    bram_intrf.slave bram_porta,
    bram_intrf.slave bram_portb
    );

    blk_mem_gen_0 your_instance_name (
        .clka(clk_i),
        .wea(bram_porta.we),
        .addra(bram_porta.addr),
        .dina(bram_porta.din),
        .douta(bram_porta.dout),
        .clkb(clk_i),
        .web(bram_portb.we),
        .addrb(bram_portb.addr),
        .dinb(bram_portb.din),
        .doutb(bram_portb.dout)
    );

endmodule : system_memory