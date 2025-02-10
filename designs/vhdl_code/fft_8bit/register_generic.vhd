library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
    generic (width : positive := 32);
    port
    (
        clk     : in std_logic;
        rst     : in std_logic;
        we      : in std_logic;
        d_in    : in std_logic_vector(width-1 downto 0);
        d_out   : out std_logic_vector(width-1 downto 0)
    );
end reg;

architecture Behavioral of reg is
    begin
        process (clk, rst)
            begin
                if rst = '1' then
                    d_out <= (others => '0');
                elsif rising_edge(clk) and we = '1' then
                    d_out <= d_in;
                end if;
        end process;
end Behavioral;
