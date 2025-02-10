library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_en is
    generic (digits : positive := 4);
    port
    (
        clk : in std_logic;
        rst : in std_logic;
        en  : in std_logic;
        cnt : out std_logic_vector(digits - 1 downto 0)
    );
end entity counter_en;

architecture Behavioral of counter_en is
    begin
        process(clk, rst)
            variable count : unsigned(digits - 1 downto 0) := (others => '0');
            begin
                if rst = '1' then
                    count := (others => '0');
                    cnt <= std_logic_vector(count);
                elsif rising_edge(clk) and en = '1' then
                    count := count + 1;
                    cnt <= std_logic_vector(count);
                end if;
        end process;
end Behavioral;