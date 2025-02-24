library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;

entity ROM is 
    generic
    (
        addr    : positive := 3;    -- number of bits of address
        dat     : positive := 20;   -- number of bits of data (word length)
        memlen  : positive := 8;    -- number of words in memory
        filepath: string := "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/twiddles/memconfig_22-1/twiddles_16p.txt"
    );
    port
    (
        address : in std_logic_vector(addr-1 downto 0);
        d_out   : out std_logic_vector(dat-1 downto 0)
    );
end ROM;

architecture Behavioral of ROM is
    
    type ROM_array is array(memlen-1 downto 0) of std_logic_vector(dat-1 downto 0);
    
    impure function init_rom_bin( file_path : string) return ROM_array is
        -- ATTENTION: for every different points FFT or mem config the twiddlefile changes! I do not know how you parameterize that...
        file text_file : text open read_mode is file_path;
        variable text_line : line;
        variable rom_content : ROM_array;
        variable bv : bit_vector(rom_content(0)'range);
        begin
            for i in 0 to memlen - 1 loop
                readline(text_file, text_line);
                read(text_line, bv);
                rom_content(i) := To_StdLogicVector(bv);
            end loop;
            return rom_content;
    end function;

    constant ROM_content : ROM_array := init_rom_bin(filepath);

    begin
        d_out <= ROM_content(to_integer(unsigned(address)));

end architecture Behavioral;