module twiddle_rom #(
    parameter addr = 5,               // Number of bits of address
    parameter width = 46,             // Number of bits of data (word length in the memory - each word stores two twiddles but here you do not care)
    parameter len = 512,              // Number of words in memory - must be points / 2
    parameter filepath = "../../../dataset/twiddles/memconfig_2-21/twiddles_1024p.txt"
    // parameter filepath = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/twiddles/memconfig_2-21/twiddles_1024p.txt"
)(
    input  logic [addr-1:0] addr_i,      // Address input
    output logic [width-1:0] d_out          // Data output
);

    /***********************************************
    *   Custom Types
    ***********************************************/

    typedef logic [width-1:0] rom_array_t[len];

    /***********************************************
    *   Internal Signals
    ***********************************************/

    int fd;
    rom_array_t rom_array;

    /***********************************************
    *   Initialization of memory
    ***********************************************/

    initial begin
        // init the memory block
        $readmemb(filepath, rom_array);
    end

    /***********************************************
    *   Always block
    ***********************************************/

    always_comb begin
        d_out <= rom_array[addr_i];
    end

endmodule : twiddle_rom
