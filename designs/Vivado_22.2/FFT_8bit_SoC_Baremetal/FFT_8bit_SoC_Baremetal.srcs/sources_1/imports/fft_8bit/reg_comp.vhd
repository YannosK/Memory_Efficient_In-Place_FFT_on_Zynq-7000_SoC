library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_comp is
    generic (shiftbits   : positive := 5);    -- number of bits to represent the number of most possible shifts. Right shifts are 2 at most and need 2 bits. Left shifts need (shiftbits - 2)
    port
    (
        clk     : in std_logic;
        rst     : in std_logic;
        en      : in std_logic;
        shr_in  : in std_logic_vector(1 downto 0);
        shl_in  : in std_logic_vector((shiftbits - 2) - 1 downto 0);
        shr_out : out std_logic_vector(1 downto 0);
        shl_out : out std_logic_vector((shiftbits - 2) - 1 downto 0)
    );
end entity reg_comp;

architecture Behavioral of reg_comp is

    signal shr_i : std_logic_vector(1 downto 0);
    signal shl_i : std_logic_vector((shiftbits - 2) - 1 downto 0);
    signal shr   : std_logic_vector(1 downto 0);
    signal shl   : std_logic_vector((shiftbits - 2) - 1 downto 0);
    signal shr_o : std_logic_vector(1 downto 0);
    signal shl_o : std_logic_vector((shiftbits - 2) - 1 downto 0);

    begin

        shr <= shr_in;
        shl <= shl_in;
        shr_out <= shr_o;
        shl_out <= shl_o;

        sync: process(clk)      -- Synchronous on purpose!
            begin
                if rising_edge(clk) then
                    if rst = '1' then
                        shr_o <= (others => '0');
                        shl_o <= (others => '0');
                    elsif en = '1' then
                        shr_o <= shr_i;
                        shl_o <= shl_i;
                    end if;
                end if;
        end process sync;

        async: process(clk, rst, shr, shl, shr_in, shl_in, shr_i, shl_i, shr_o, shl_o)
            begin
                if unsigned(shr_o) > unsigned(shr) then
                    shr_i <= shr_o;
                else
                    shr_i <= shr;
                end if;

                if unsigned(shl_o) < unsigned(shl) then
                    shl_i <= shl_o;
                else
                    shl_i <= shl;
                end if;
        end process async;

end Behavioral;
