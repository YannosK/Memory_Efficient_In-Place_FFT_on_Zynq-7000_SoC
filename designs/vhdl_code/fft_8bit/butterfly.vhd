library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity butterfly is
    generic
    (
        width : positive := 10;
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
end entity butterfly;

architecture Behavioral of butterfly is

    component mult_gen_0 IS -- CANNOT BE MADE GENERIC
        PORT
        (
            CLK : IN STD_LOGIC;
            A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
            P : OUT STD_LOGIC_VECTOR(32 DOWNTO 0)
        );
    END component mult_gen_0;
  
    component shift_reg is 
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
    end component shift_reg;

    -- constants
    constant intr_width : positive := width + (tw_width/2);
    constant trailing_zeros : std_logic_vector((intr_width - (width - 2) - 4) - 1 downto 0) := (others => '0');

    signal w_r      : std_logic_vector((tw_width/2) - 1 downto 0);
    signal w_i      : std_logic_vector((tw_width/2) - 1 downto 0);

    -- stage 0 signals
    signal x0r      : std_logic_vector(intr_width - 1 downto 0);
    signal x0i      : std_logic_vector(intr_width - 1 downto 0);
    signal A_in     : std_logic_vector(intr_width - 1 downto 0);
    signal B_in     : std_logic_vector(intr_width - 1 downto 0);
    signal C_in     : std_logic_vector(intr_width - 1 downto 0);
    signal D_in     : std_logic_vector(intr_width - 1 downto 0);

    -- stage 1 signals
    signal A_out    : std_logic_vector(intr_width - 1 downto 0);
    signal B_out    : std_logic_vector(intr_width - 1 downto 0);
    signal C_out    : std_logic_vector(intr_width - 1 downto 0);
    signal D_out    : std_logic_vector(intr_width - 1 downto 0);
    signal w_r_in   : std_logic_vector(intr_width - 1 downto 0);
    signal w_i_in   : std_logic_vector(intr_width - 1 downto 0);

    -- stage 2 signals
    signal x0_r_out : std_logic_vector(intr_width - 1 downto 0);
    signal x0_i_out : std_logic_vector(intr_width - 1 downto 0);
    signal w_r_out  : std_logic_vector(intr_width - 1 downto 0);
    signal w_i_out  : std_logic_vector(intr_width - 1 downto 0);
    
    begin

        --------------------------------------------------------
        -- Siganls / Connections
        --------------------------------------------------------

        x0r <= x0_r(width - 1) & x0_r(width - 1) & x0_r & trailing_zeros;
        x0i <= x0_i(width - 1) & x0_i(width - 1) & x0_i & trailing_zeros;

        w_r <= twiddle(tw_width - 1 downto tw_width/2);
        w_i <= twiddle((tw_width/2) - 1 downto 0);

        --------------------------------------------------------
        -- Modules / Components
        --------------------------------------------------------

        mult_A: mult_gen_0
            port map
            (
                clk => clk,
                A   => x1_r,
                B   => w_r,
                P   => A_in
            );

        mult_B: mult_gen_0
            port map
            (
                clk => clk,
                A   => x1_i,
                B   => w_i,
                P   => B_in
            );

        mult_C: mult_gen_0
            port map
            (
                clk => clk,
                A   => x1_r,
                B   => w_i,
                P   => C_in
            );

        mult_D: mult_gen_0
            port map
            (
                clk => clk,
                A   => x1_i,
                B   => w_r,
                P   => D_in
            );

        shift_reg_x0r: shift_reg
            generic map
            (
                width   => intr_width,
                length  => 5
            )
            port map
            (
                clk     => clk,
                d_in    => x0r,
                d_out   => x0_r_out
            );
        
        shift_reg_x0i: shift_reg
            generic map
            (
                width   => intr_width,
                length  => 5
            )
            port map
            (
                clk     => clk,
                d_in    => x0i,
                d_out   => x0_i_out
            );
        
        --------------------------------------------------------
        -- Syncronous Porcesses / Registers
        --------------------------------------------------------

        sync_stage0: process (clk, rst)
            begin
                if rst = '1' then
                    A_out <= (others => '0');
                    B_out <= (others => '0');
                    C_out <= (others => '0');
                    D_out <= (others => '0');
                elsif rising_edge(clk) then
                    A_out <= A_in;
                    B_out <= B_in;
                    C_out <= C_in;
                    D_out <= D_in;
                end if;
        end process sync_stage0;

        sync_stage1: process (clk, rst)
            begin
                if rst = '1' then
                    w_r_out <= (others => '0');
                    w_i_out <= (others => '0');
                elsif rising_edge(clk) then
                    w_r_out <= w_r_in;
                    w_i_out <= w_i_in;
                end if;
        end process sync_stage1;

        --------------------------------------------------------
        -- Asynchronous Processes / Logic Circuits
        --------------------------------------------------------

        async_stage1: process (clk, rst, A_out, B_out, C_out, D_out)
            begin
                w_r_in <= std_logic_vector(signed(A_out) - signed(B_out));
                w_i_in <= std_logic_vector(signed(D_out) + signed(C_out));
        end process async_stage1;

        async_stage2: process (clk, rst, x0_r_out, x0_i_out, w_r_out, w_i_out)
            begin
                y0_r <= std_logic_vector(signed(x0_r_out) + signed(w_r_out));
                y0_i <= std_logic_vector(signed(x0_i_out) + signed(w_i_out));
                y1_r <= std_logic_vector(signed(x0_r_out) - signed(w_r_out));
                y1_i <= std_logic_vector(signed(x0_i_out) - signed(w_i_out));
        end process async_stage2;

end Behavioral;
