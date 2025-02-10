library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PE is
    generic
    (
        width       : positive := 16;   -- number of bits to represent one datum (real and imaginary part)
        twid_width  : positive := 46;
        shiftbits   : positive := 5     -- number of bits to represent the number of most possible shifts. Right shifts are 2 at most and need 2 bits. Left shifts need (shiftbits - 2)
    );
    port
    (
        clk         : in std_logic;
        rst         : in std_logic;
        in_A        : in std_logic_vector(width-1 downto 0);            -- First input of the butterfly. Data format REAL-IMAG. Content of first half of words
        in_B        : in std_logic_vector(width-1 downto 0);            -- Second input of the butterfly. Data format REAL-IMAG. Content of second half of words
        twiddle     : in std_logic_vector(twid_width-1 downto 0);      -- Twiddle factor. Format REAL-IMAG. Each one is 10 bits instead of 8bits
        shr_in      : in std_logic_vector(1 downto 0);                  -- Shift-Right amount determined from the previous FFT stage
        shl_in      : in std_logic_vector((shiftbits - 2) - 1 downto 0);-- Shift-Left amount determined from the previous FFT stage
        out_A       : out std_logic_vector(width-1 downto 0);           -- First ouput of FFT
        out_B       : out std_logic_vector(width-1 downto 0);           -- Second ouput of FFT
        shr_out     : out std_logic_vector(1 downto 0);                 -- The maximum of shift-right amounts produced. Out to update the shr_register
        shl_out     : out std_logic_vector((shiftbits - 2) -1 downto 0) -- The minimum of shift-left amounts produced. Out to update the shl_register
    );
end entity PE;

architecture Structural of PE is

    component butterfly is
        generic
        (
            width   : positive := 10;
            tw_width: positive := 46
        );
        port
        (
            clk     : in std_logic;
            rst     : in std_logic;
            x0_r    : in std_logic_vector(width - 1 downto 0);
            x0_i    : in std_logic_vector(width - 1 downto 0);
            x1_r    : in std_logic_vector(width - 1 downto 0);
            x1_i    : in std_logic_vector(width - 1 downto 0);
            twiddle : in std_logic_vector(tw_width - 1 downto 0);
            y0_r    : out std_logic_vector((width + (tw_width/2)) - 1 downto 0);
            y0_i    : out std_logic_vector((width + (tw_width/2)) - 1 downto 0);
            y1_r    : out std_logic_vector((width + (tw_width/2)) - 1 downto 0);
            y1_i    : out std_logic_vector((width + (tw_width/2)) - 1 downto 0)
        );
    end component butterfly;

    component shifter is 
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
    end component shifter;

    component rounder is
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
    end component rounder;

    component shamt is
        generic
        (
            in_width    : positive := 26;   -- number of bits of input datum
            out_width   : positive := 16;   -- number of bits of output datum
            shiftbits   : positive := 5     -- number of bits to represent the number of most possible shifts. Right shifts are 2 at most and need 2 bits. Left shifts need (shiftbits - 2)
        );
        port
        (
            d_in    : in std_logic_vector(in_width - 1 downto 0);  -- input data
            shamt_r : out std_logic_vector(1 downto 0);                         -- right-shift amount: it has priority over left shift, and maximum value 2 = 10. It performs right shift extending the sign defined by s
            shamt_l : out std_logic_vector((shiftbits - 2) - 1 downto 0);       -- left-shift amount: it has smaller priority than right-shift, and maximum value 6 = 110
            d_out   : out std_logic_vector(out_width - 1 downto 0)              -- output data
        );
    end component shamt;

    constant init_width : positive := (width/2) + 2;
    constant intr_width : positive := init_width + (twid_width/2);

    -- Initial signals
    signal x0_r         : std_logic_vector(init_width - 1 downto 0);
    signal x0_i         : std_logic_vector(init_width - 1 downto 0);
    signal x1_r         : std_logic_vector(init_width - 1 downto 0);
    signal x1_i         : std_logic_vector(init_width - 1 downto 0);
    -- Post shifter
    signal x0_r_sh      : std_logic_vector(init_width - 1 downto 0);
    signal x0_i_sh      : std_logic_vector(init_width - 1 downto 0);
    signal x1_r_sh      : std_logic_vector(init_width - 1 downto 0);
    signal x1_i_sh      : std_logic_vector(init_width - 1 downto 0);
    -- Pre Butterly PE
    signal x0_r_pe      : std_logic_vector(init_width - 1 downto 0);
    signal x0_i_pe      : std_logic_vector(init_width - 1 downto 0);
    signal x1_r_pe      : std_logic_vector(init_width - 1 downto 0);
    signal x1_i_pe      : std_logic_vector(init_width - 1 downto 0);
    signal tw_int       : std_logic_vector(twid_width - 1 downto 0);
    -- Post Butterfly PE
    signal y0_r_pe      : std_logic_vector(intr_width - 1 downto 0);
    signal y0_i_pe      : std_logic_vector(intr_width - 1 downto 0);
    signal y1_r_pe      : std_logic_vector(intr_width - 1 downto 0);
    signal y1_i_pe      : std_logic_vector(intr_width - 1 downto 0);
    -- Pre round
    signal y0_r_rndi    : std_logic_vector(intr_width - 1 downto 0);
    signal y0_i_rndi    : std_logic_vector(intr_width - 1 downto 0);
    signal y1_r_rndi    : std_logic_vector(intr_width - 1 downto 0);
    signal y1_i_rndi    : std_logic_vector(intr_width - 1 downto 0);
    -- Post round
    signal y0_r_rndo    : std_logic_vector(intr_width - 1 downto 0);
    signal y0_i_rndo    : std_logic_vector(intr_width - 1 downto 0);
    signal y1_r_rndo    : std_logic_vector(intr_width - 1 downto 0);
    signal y1_i_rndo    : std_logic_vector(intr_width - 1 downto 0);
    -- Pre shamt
    signal y0_r_sh      : std_logic_vector(intr_width - 1 downto 0);
    signal y0_i_sh      : std_logic_vector(intr_width - 1 downto 0);
    signal y1_r_sh      : std_logic_vector(intr_width - 1 downto 0);
    signal y1_i_sh      : std_logic_vector(intr_width - 1 downto 0);
    -- Post shamt
    signal y0_r         : std_logic_vector(width/2 - 1 downto 0);
    signal y0_i         : std_logic_vector(width/2 - 1 downto 0);
    signal y1_r         : std_logic_vector(width/2 - 1 downto 0);
    signal y1_i         : std_logic_vector(width/2 - 1 downto 0);
    signal shr_0_r      : std_logic_vector(1 downto 0);
    signal shr_0_i      : std_logic_vector(1 downto 0);
    signal shr_1_r      : std_logic_vector(1 downto 0);
    signal shr_1_i      : std_logic_vector(1 downto 0);
    signal shl_0_r      : std_logic_vector((shiftbits - 2) - 1 downto 0);
    signal shl_0_i      : std_logic_vector((shiftbits - 2) - 1 downto 0);
    signal shl_1_r      : std_logic_vector((shiftbits - 2) - 1 downto 0);
    signal shl_1_i      : std_logic_vector((shiftbits - 2) - 1 downto 0);
    -- Pre decider
    signal shr_0_r_de   : std_logic_vector(1 downto 0);
    signal shr_0_i_de   : std_logic_vector(1 downto 0);
    signal shr_1_r_de   : std_logic_vector(1 downto 0);
    signal shr_1_i_de   : std_logic_vector(1 downto 0);
    signal shl_0_r_de   : std_logic_vector((shiftbits - 2) - 1 downto 0);
    signal shl_0_i_de   : std_logic_vector((shiftbits - 2) - 1 downto 0);
    signal shl_1_r_de   : std_logic_vector((shiftbits - 2) - 1 downto 0);
    signal shl_1_i_de   : std_logic_vector((shiftbits - 2) - 1 downto 0);

    begin

        ---------------------------------------------------------------------------------------
        --  Internal Signal Assignments
        ---------------------------------------------------------------------------------------

        x0_r <= in_A(width -1 downto width/2) & "00";
        x0_i <= in_A(width/2 -1 downto 0) & "00"; 
        x1_r <= in_B(width -1 downto width/2) & "00"; 
        x1_i <= in_B(width/2 -1 downto 0) & "00";


        ---------------------------------------------------------------------------------------
        --  Components / Modules
        ---------------------------------------------------------------------------------------

        shifter_x0_r: shifter
            generic map
            (
                digits => init_width,
                shiftbits => shiftbits
            )
            port map
            (
                d_in    => x0_r,
                shamt_r => shr_in,
                shamt_l => shl_in,
                d_out   => x0_r_sh
            );

        shifter_x0_i: shifter
            generic map
            (
                digits => init_width,
                shiftbits => shiftbits
            )
            port map
            (
                d_in    => x0_i,
                shamt_r => shr_in,
                shamt_l => shl_in,
                d_out   => x0_i_sh
            );

        shifter_x1_r: shifter
            generic map
            (
                digits => init_width,
                shiftbits => shiftbits
            )
            port map
            (
                d_in    => x1_r,
                shamt_r => shr_in,
                shamt_l => shl_in,
--                s       => s_in(1),
                d_out   => x1_r_sh
            );

        shifter_x1_i: shifter
            generic map
            (
                digits => init_width,
                shiftbits => shiftbits
            )
            port map
            (
                d_in    => x1_i,
                shamt_r => shr_in,
                shamt_l => shl_in,
                d_out   => x1_i_sh
            );

        Butterfly_Processor: butterfly
            generic map
            (
                width => init_width,
                tw_width => twid_width
            )
            port map
            (
                clk     => clk,
                rst     => rst,
                x0_r    => x0_r_pe,
                x0_i    => x0_i_pe,
                x1_r    => x1_r_pe,
                x1_i    => x1_i_pe,
                twiddle => tw_int,
                y0_r    => y0_r_pe,
                y0_i    => y0_i_pe,
                y1_r    => y1_r_pe,
                y1_i    => y1_i_pe
            );

        Rounder_y0_r: rounder
            generic map
            (
                digits      => intr_width,
                fractional  => intr_width - 2 - (width/2)
            )
            port map
            (
                d_in    => y0_r_rndi,
                d_out   => y0_r_rndo
            );

        Rounder_y0_i: rounder
            generic map
            (
                digits      => intr_width,
                fractional  => intr_width - 2 - (width/2)
            )
            port map
            (
                d_in    => y0_i_rndi,
                d_out   => y0_i_rndo
            );

        Rounder_y1_r: rounder
            generic map
            (
                digits      => intr_width,
                fractional  => intr_width - 2 - (width/2)
            )
            port map
            (
                d_in    => y1_r_rndi,
                d_out   => y1_r_rndo
            );

        Rounder_y1_i: rounder
            generic map
            (
                digits      => intr_width,
                fractional  => intr_width - 2 - (width/2)
            )
            port map
            (
                d_in    => y1_i_rndi,
                d_out   => y1_i_rndo
            );

        Shamt_Generator_y0_r: shamt
            generic map
            (
                in_width => intr_width,
                out_width => width/2,
                shiftbits => shiftbits
            )
            port map
            (
                d_in    => y0_r_sh,
                shamt_r => shr_0_r,
                shamt_l => shl_0_r,
                d_out   => y0_r
            );

        Shamt_Generator_y0_i: shamt
            generic map
            (
                in_width => intr_width,
                out_width => width/2,
                shiftbits => shiftbits
            )
            port map
            (
                d_in    => y0_i_sh,
                shamt_r => shr_0_i,
                shamt_l => shl_0_i,
                d_out   => y0_i
            );

        Shamt_Generator_y1_r: shamt
            generic map
            (
                in_width => intr_width,
                out_width => width/2,
                shiftbits => shiftbits
            )
            port map
            (
                d_in    => y1_r_sh,
                shamt_r => shr_1_r,
                shamt_l => shl_1_r,
                d_out   => y1_r
            );

        Shamt_Generator_y1_i: shamt
            generic map
            (
                in_width => intr_width,
                out_width => width/2,
                shiftbits => shiftbits
            )
            port map
            (
                d_in    => y1_i_sh,
                shamt_r => shr_1_i,
                shamt_l => shl_1_i,
                d_out   => y1_i
            );

        ---------------------------------------------------------------------------------------
        --  Synchronous Processes
        ---------------------------------------------------------------------------------------

        sync_shifter_to_PE: process(clk, rst)
            begin
                if rst = '1' then
                    x0_r_pe <= (others => '0');
                    x0_i_pe <= (others => '0');
                    x1_r_pe <= (others => '0');
                    x1_i_pe <= (others => '0');
                    tw_int  <= (others => '0');
                elsif rising_edge(clk) then
                    x0_r_pe <= x0_r_sh;
                    x0_i_pe <= x0_i_sh;
                    x1_r_pe <= x1_r_sh;
                    x1_i_pe <= x1_i_sh;
                    tw_int  <= twiddle;
                end if;
        end process sync_shifter_to_PE;

        sync_PE_to_round: process(clk, rst)
            begin
                if rst = '1' then
                    y0_r_rndi <= (others => '0');
                    y0_i_rndi <= (others => '0');
                    y1_r_rndi <= (others => '0');
                    y1_i_rndi <= (others => '0');
                elsif rising_edge(clk) then
                    y0_r_rndi <= y0_r_pe;
                    y0_i_rndi <= y0_i_pe;
                    y1_r_rndi <= y1_r_pe;
                    y1_i_rndi <= y1_i_pe;
                end if;
        end process sync_PE_to_round;

        sync_round_to_shamt: process(clk, rst)
            begin
                if rst = '1' then
                    y0_r_sh <= (others => '0');
                    y0_i_sh <= (others => '0');
                    y1_r_sh <= (others => '0');
                    y1_i_sh <= (others => '0');
                elsif rising_edge(clk) then
                    y0_r_sh <= y0_r_rndo;
                    y0_i_sh <= y0_i_rndo;
                    y1_r_sh <= y1_r_rndo;
                    y1_i_sh <= y1_i_rndo;
                end if;
        end process sync_round_to_shamt;

        sync_shamt_to_decider: process(clk, rst)
            begin
                if rst = '1' then
                    out_A      <= (others => '0');
                    out_B      <= (others => '0');
                    shr_0_r_de <= (others => '0'); 
                    shr_0_i_de <= (others => '0'); 
                    shr_1_r_de <= (others => '0'); 
                    shr_1_i_de <= (others => '0'); 
                    shl_0_r_de <= (others => '0'); 
                    shl_0_i_de <= (others => '0'); 
                    shl_1_r_de <= (others => '0'); 
                    shl_1_i_de <= (others => '0');
                elsif rising_edge(clk) then
                    out_A      <= y0_r & y0_i;
                    out_B      <= y1_r & y1_i;
                    shr_0_r_de <= shr_0_r;
                    shr_0_i_de <= shr_0_i;
                    shr_1_r_de <= shr_1_r;
                    shr_1_i_de <= shr_1_i;
                    shl_0_r_de <= shl_0_r;
                    shl_0_i_de <= shl_0_i;
                    shl_1_r_de <= shl_1_r;
                    shl_1_i_de <= shl_1_i;
                end if;
        end process sync_shamt_to_decider;

        ---------------------------------------------------------------------------------------
        --  Asynchronous Processes
        ---------------------------------------------------------------------------------------

        shr_decider: process (clk, rst, shr_0_r_de, shr_0_i_de, shr_1_r_de, shr_1_i_de)
            variable temp0 : unsigned(1 downto 0);
            variable temp1 : unsigned(1 downto 0);
            begin
                if unsigned(shr_0_r_de) > unsigned(shr_0_i_de) then
                    temp0 := unsigned(shr_0_r_de);
                else
                    temp0 := unsigned(shr_0_i_de);
                end if;
                    
                if unsigned(shr_1_r_de) > unsigned(shr_1_i_de) then
                    temp1 := unsigned(shr_1_r_de);
                else
                    temp1 := unsigned(shr_1_i_de);
                end if;

                if temp1 > temp0 then
                    shr_out <= std_logic_vector(temp1);
                else
                    shr_out <= std_logic_vector(temp0);
                end if;
        end process;

        shl_decider: process (clk, rst, shl_0_r_de, shl_0_i_de, shl_1_r_de, shl_1_i_de)
            variable temp0 : unsigned((shiftbits - 2) - 1 downto 0);
            variable temp1 : unsigned((shiftbits - 2) - 1 downto 0);
            begin
                if unsigned(shl_0_r_de) < unsigned(shl_0_i_de) then
                    temp0 := unsigned(shl_0_r_de);
                else
                    temp0 := unsigned(shl_0_i_de);
                end if;
                    
                if unsigned(shl_1_r_de) < unsigned(shl_1_i_de) then
                    temp1 := unsigned(shl_1_r_de);
                else
                    temp1 := unsigned(shl_1_i_de);
                end if;

                if temp1 < temp0 then
                    shl_out <= std_logic_vector(temp1);
                else
                    shl_out <= std_logic_vector(temp0);
                end if;
        end process;

end Structural;
