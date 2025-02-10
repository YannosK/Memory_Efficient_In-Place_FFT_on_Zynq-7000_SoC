module twiddle_rom #(
    parameter addr = 3,               // Number of bits of address
    parameter width = 20,             // Number of bits of data (word length)
    parameter len = 8,                // Number of words in memory
    parameter filepath = "../../dataset/twiddles/twiddles_1024p.txt"
)(
    input  logic [addr-1:0] addr_i,      // Address input
    output logic [width-1:0] d_out          // Data output
);

    /***********************************************
    *   Internal Signals / Custom Types
    ***********************************************/

    typedef logic [width-1:0] ROM_array_t[len];
    ROM_array_t ROM_content;

    /***********************************************
    *   Initial begin block
    ***********************************************/

    initial begin
        integer file, i;
        string line;

        file = $fopen(filepath, "r");
        if (file) begin
            for (i = 0; i < len; i++) begin
                if (!$feof(file)) begin
                    line = $fgets(file);
                    ROM_content[i] = line.atozbin(); // Convert the binary string to a logic vector
                end 
                else begin
                    ROM_content[i] = '0;  // Set to zero if fewer lines in file than memlen
                end
            end
            $fclose(file);
        end
        else begin
            $display("Error: Could not open file %s", filepath);
        end
    end

    /***********************************************
    *   Direct assignments
    ***********************************************/

    assign d_out = ROM_content[addr_i];

endmodule : twiddle_rom
