library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shifts_count is
    generic
    (
        width    : positive := 5;   -- number of bits of shamt register
        max_count: positive := 5    -- number of bits needed to represent total shifts left
    );
    port
    (
        clk     : in std_logic;
        rst     : in std_logic;
        en      : in std_logic;
        shr     : in std_logic_vector(1 downto 0);
        shl     : in std_logic_vector((width - 2) - 1 downto 0);
        total   : out std_logic_vector(max_count - 1 downto 0)
    );
end entity shifts_count;

architecture Behavioral of shifts_count is
    begin
        process (clk, rst)
        variable count : integer := 0;
            begin
                if rst = '1' then
                    count := 0;
                    total <= std_logic_vector(to_signed(count, total'length));
                elsif rising_edge(clk) and en = '1' then
                    count := count + to_integer(unsigned(shr)) - to_integer(unsigned(shl));
                    total <= std_logic_vector(to_signed(count, total'length));
                end if;
        end process;
end Behavioral;