library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rounder is
    generic
    (
        digits      : positive := 20;   -- digits of input and output
        fractional  : positive := 10    -- bit where we round (the least significant bit that will survive - its index)
    );
    port
    (
        d_in    : in std_logic_vector(digits - 1 downto 0);
        d_out   : out std_logic_vector(digits - 1 downto 0)
    );
end entity rounder;

architecture Behavioral of rounder is

    begin
        process (d_in)
        variable temp : unsigned(digits - fractional - 1 downto 0);
        variable leftovers : unsigned(fractional - 1 downto 0);
        variable threshold : unsigned(fractional - 1 downto 0);
            begin
                temp := unsigned(d_in(digits - 1 downto fractional));
                leftovers := unsigned(d_in(fractional - 1 downto 0));
                threshold := shift_left(to_unsigned(1, threshold'length), fractional - 1);
                if leftovers > threshold then
                    temp := temp + 1; 
                    d_out <= std_logic_vector(temp) & d_in(fractional - 1 downto 0);
                else
                    d_out <= std_logic_vector(temp) & d_in(fractional - 1 downto 0);
                end if;
        end process;
end Behavioral;
