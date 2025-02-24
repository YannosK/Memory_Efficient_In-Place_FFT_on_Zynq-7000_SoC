library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shamt is
    generic
    (
        -- width       : positive := 16;   -- number of bits to represent one datum (real and imaginary part)
        in_width    : positive := 28;   -- number of bits of input datum
        out_width   : positive := 8;   -- number of bits of output datum
        shiftbits   : positive := 5     -- number of bits to represent the number of most possible shifts. Right shifts are 2 at most and need 2 bits. Left shifts need (shiftbits - 2)
    );
    port
    (
        d_in    : in std_logic_vector(in_width - 1 downto 0);  -- input data
        shamt_r : out std_logic_vector(1 downto 0);                         -- right-shift amount: it has priority over left shift, and maximum value 2 = 10. It performs right shift extending the sign defined by s
        shamt_l : out std_logic_vector((shiftbits - 2) - 1 downto 0);       -- left-shift amount: it has smaller priority than right-shift, and maximum value 6 = 110
        d_out   : out std_logic_vector(out_width - 1 downto 0)              -- output data
    );
end entity shamt;


architecture Behavioral of shamt is

    -- constant digits     : positive := ((width/2) + 2) * 2;
    constant decimals   : positive := out_width - 2;
    constant leftovers  : positive := in_width - 2 - out_width;
    -- constant decimals   : positive := (width/2) - 2;
    -- constant leftovers  : positive := digits - 2 - (width/2);

    begin


        process(d_in)
        variable temp : signed(in_width - 1 downto 0);
        variable max_rep : signed(in_width - 1 downto 0);
        variable min_rep : signed(in_width - 1 downto 0);
        variable rest_zeros : std_logic_vector((in_width - 4) - 1 downto 0) := (others => '0');
        variable rest_ones  : std_logic_vector(in_width - 4 downto 0) := (others => '1');
        variable zeros      : std_logic_vector(decimals - 1 downto 0) := rest_zeros(decimals - 2 downto 0) & '1';
        variable ones       : std_logic_vector(decimals - 2 downto 0) := rest_ones(decimals - 3 downto 0) & '0';
            begin

                temp := shift_right(signed(d_in), leftovers);
                max_rep := (others => '0');
                max_rep(out_width - 2 downto 0) := (others => '1');
                min_rep := (others => '1');
                min_rep(out_width - 2 downto 0) := (others => '0');
                if temp > max_rep then
                    d_out <= std_logic_vector(max_rep(out_width - 1 downto 0));
                elsif temp < min_rep then
                    d_out <= std_logic_vector(min_rep(out_width - 1 downto 0));
                else
                    d_out <= std_logic_vector(temp(out_width - 1 downto 0));
                end if;

                case d_in((in_width - 1) - 1 downto ((in_width - 1) - 3)) is
                    when "000" =>
                        shamt_r <= "00";
                        -- shifts-left cases for positives : Cases for 0 to decimals - 1 (case decimal is 'else')
                        if      d_in((in_width - 5) downto (in_width - 2 - out_width + 0)) = zeros((decimals - 1) - 0 downto 0) then
                            shamt_l <= std_logic_vector(to_unsigned(decimals - 0, shamt_l'length));
                        elsif   d_in((in_width - 5) downto (in_width - 2 - out_width + 1)) = zeros((decimals - 1) - 1 downto 0) then
                            if d_in(((in_width - 2 - out_width - 1) + 1) downto (in_width - 2 - out_width)) = rest_zeros(1 - 1 downto 0) then
                                shamt_l <= std_logic_vector(to_unsigned(decimals - 1, shamt_l'length));
                            else
                                shamt_l <= std_logic_vector(to_unsigned(decimals - 1 - 1, shamt_l'length));
                            end if;
                        elsif   d_in((in_width - 5) downto (in_width - 2 - out_width + 2)) = zeros((decimals - 1) - 2 downto 0) then
                            if d_in(((in_width - 2 - out_width - 1) + 2) downto (in_width - 2 - out_width)) = rest_zeros(2 - 1 downto 0) then
                                shamt_l <= std_logic_vector(to_unsigned(decimals - 2, shamt_l'length));
                            else
                                shamt_l <= std_logic_vector(to_unsigned(decimals - 1 - 2, shamt_l'length));
                            end if;
                        elsif   d_in((in_width - 5) downto (in_width - 2 - out_width + 3)) = zeros((decimals - 1) - 3 downto 0) then
                            if d_in(((in_width - 2 - out_width - 1) + 3) downto (in_width - 2 - out_width)) = rest_zeros(3 - 1 downto 0) then
                                shamt_l <= std_logic_vector(to_unsigned(decimals - 3, shamt_l'length));
                            else
                                shamt_l <= std_logic_vector(to_unsigned(decimals - 1 - 3, shamt_l'length));
                            end if;
                        elsif   d_in((in_width - 5) downto (in_width - 2 - out_width + 4)) = zeros((decimals - 1) - 4 downto 0) then
                            if d_in(((in_width - 2 - out_width - 1) + 4) downto (in_width - 2 - out_width)) = rest_zeros(4 - 1 downto 0) then
                                shamt_l <= std_logic_vector(to_unsigned(decimals - 4, shamt_l'length));
                            else
                                shamt_l <= std_logic_vector(to_unsigned(decimals - 1 - 4, shamt_l'length));
                            end if;
                        elsif   d_in((in_width - 5) downto (in_width - 2 - out_width + 5)) = zeros((decimals - 1) - 5 downto 0) then
                            shamt_l <= std_logic_vector(to_unsigned(decimals - 5, shamt_l'length));
                        else
                            shamt_l <= std_logic_vector(to_unsigned(0, shamt_l'length));
                        end if;
                    when "001" =>
                        shamt_l <= "000";
                        if d_in(((in_width - 4) - 1) downto 0) = rest_zeros then
                            shamt_r <= "00";
                        else
                            shamt_r <= "01";
                        end if;
                    when "010" =>
                        shamt_l <= "000";
                        if d_in(((in_width - 4) - 1) downto 0) = rest_zeros then
                            shamt_r <= "01";
                        else
                            shamt_r <= "10";
                        end if;
                    when "011" =>
                        shamt_r <= "10";
                        shamt_l <= "000";
                    when "100" =>
                        shamt_r <= "XX";
                        shamt_l <= "000";
                    when "101" =>
                        shamt_r <= "10";
                        shamt_l <= "000";
                    when "110" =>
                        shamt_r <= "01";
                        shamt_l <= "000";
                    when "111" =>
                        shamt_r <= "00";
                        -- shifts-left cases for negatives : Cases for 0 to decimals - 2 (case decimal is 'else')
                        if      d_in((in_width - 6) downto ((in_width - 2 - out_width) + 0)) = ones((decimals - 2) - 0 downto 0) then shamt_l <= std_logic_vector(to_unsigned((decimals - 1) - 0, shamt_l'length));
                        elsif   d_in((in_width - 6) downto ((in_width - 2 - out_width) + 1)) = ones((decimals - 2) - 1 downto 0) then shamt_l <= std_logic_vector(to_unsigned((decimals - 1) - 1, shamt_l'length));
                        elsif   d_in((in_width - 6) downto ((in_width - 2 - out_width) + 2)) = ones((decimals - 2) - 2 downto 0) then shamt_l <= std_logic_vector(to_unsigned((decimals - 1) - 2, shamt_l'length));
                        elsif   d_in((in_width - 6) downto ((in_width - 2 - out_width) + 3)) = ones((decimals - 2) - 3 downto 0) then shamt_l <= std_logic_vector(to_unsigned((decimals - 1) - 3, shamt_l'length));
                        elsif   d_in((in_width - 6) downto ((in_width - 2 - out_width) + 4)) = ones((decimals - 2) - 4 downto 0) then shamt_l <= std_logic_vector(to_unsigned((decimals - 1) - 4, shamt_l'length));
                        else shamt_l <= (others => '0');
                        end if;
                    when others =>
                        shamt_r <= "00";
                        shamt_l <= "000";
                end case;
        end process;

end Behavioral;
