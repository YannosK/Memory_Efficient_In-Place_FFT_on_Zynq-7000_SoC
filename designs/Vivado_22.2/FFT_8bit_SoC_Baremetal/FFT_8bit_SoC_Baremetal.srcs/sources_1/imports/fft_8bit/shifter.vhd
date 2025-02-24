library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shifter is
    generic
    (
        digits      : positive := 10;
        shiftbits   : positive := 5
    );
    port
    (
        d_in    : in std_logic_vector(digits - 1 downto 0);         -- input data
        shamt_r : in std_logic_vector(1 downto 0);                  -- right-shift amount: it has priority over left shift, and maximum value 2 = 10. It performs right shift extending the sign defined by s
        shamt_l : in std_logic_vector((shiftbits - 2) - 1 downto 0);-- left-shift amount: it has smaller priority than right-shift, and maximum value 6 = 110
        d_out   : out std_logic_vector(digits - 1 downto 0)
    );
end entity shifter;

architecture Behavioral of shifter is
    begin
        async: process (d_in, shamt_r, shamt_l)
            begin
                if shamt_r = "00" then
                    d_out <= std_logic_vector(shift_left(signed(d_in), to_integer(unsigned(shamt_l))));
                else
                    d_out <= std_logic_vector(shift_right(signed(d_in), to_integer(unsigned(shamt_r))));
                end if;
        end process async;
end Behavioral;
