library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_reg is 
    generic
    (
        width   : positive := 32;   -- data word width
        length  : positive := 4     -- shift stages of shift register
    );
    port
    (
        clk     : in std_logic;
        d_in    : in std_logic_vector(width - 1 downto 0);
        d_out   : out std_logic_vector(width - 1 downto 0)
    );
end entity shift_reg;

    architecture Behavioral of shift_reg is

    type sr_type is array (length - 2 downto 0) of std_logic_vector(width - 1 downto 0);
    
    signal sr : sr_type;
  
    begin
        
        process(clk)
            begin
                if rising_edge(clk) then
                    sr <= sr(sr'high - 1 downto sr'low) & d_in;
                    d_out <= sr(sr'high);
                end if;
        end process;

end Behavioral;
