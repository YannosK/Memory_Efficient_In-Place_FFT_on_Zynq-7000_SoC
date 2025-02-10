library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity address_gen is
    generic
    (
        stages      : positive := 4;    -- FFT stages. For p points FFT, there are lg2(p) stages
        stagesbits  : positive := 2     -- bits needed to represent stages. For s stages in FFT lg2(s) bits are needed
    );
    port
    (
        clk             : in std_logic;
        rst             : in std_logic;
        en              : in std_logic;
        stage_counter   : out std_logic_vector(stagesbits - 1 downto 0);
        pairs_counter   : out std_logic_vector((stages - 2) - 1 downto 0);
        addr_0          : out std_logic_vector((stages - 1) - 1 downto 0);
        addr_1          : out std_logic_vector((stages - 1) - 1 downto 0);
        twd_addr_0      : out std_logic_vector((stages - 1) - 1 downto 0);
        twd_addr_1      : out std_logic_vector((stages - 1) - 1 downto 0)
    );
end entity address_gen;

architecture Dataflow of address_gen is

    component counter_en is
        generic (digits : positive := 4);
        port
        (
            clk : in std_logic;
            rst : in std_logic;
            en  : in std_logic;
            cnt : out std_logic_vector(digits - 1 downto 0)
        );
    end component counter_en;

    signal count : std_logic_vector((stagesbits + stages - 2) - 1 downto 0);
    signal stage_cnt    : std_logic_vector(stagesbits - 1 downto 0);
    signal pairs_cnt    : std_logic_vector((stages - 2) - 1 downto 0);


    begin

        stage_cnt <= count((stagesbits + stages - 2) - 1 downto stages - 2);
        pairs_cnt <= count((stages - 2) - 1 downto 0);

        stage_counter <= stage_cnt;
        pairs_counter <= pairs_cnt;

        cnt: counter_en
            generic map ( digits => stagesbits + stages - 2 )
            port map
            (
                clk => clk,
                rst => rst,
                en  => en,
                cnt => count
            );
        
        async: process (clk, rst, en, stage_cnt, pairs_cnt)
            variable stg_cnt    : integer := 0;
            variable tempA      : std_logic_vector((stages - 1) - 1 downto 0);
            variable tempB      : std_logic_vector((stages - 1) - 1 downto 0);
            variable temptwd    : std_logic_vector((stages - 2) + (stages - 1) - 1 downto 0);
            begin
                if to_integer(unsigned(stage_cnt)) = stages - 1 then
                    addr_0 <= pairs_cnt & '0';
                    addr_1 <= pairs_cnt & '1';

                    twd_addr_0 <= pairs_cnt & '0';
                    twd_addr_1 <= pairs_cnt & '1';
                else
                    stg_cnt := to_integer(unsigned(stage_cnt));
                    temptwd((stages - 2) + (stages - 1) - 1 downto stages - 1) := pairs_cnt;
                    temptwd((stages - 1) - 1 downto 0) := (others => '0');

                    tempA := std_logic_vector(rotate_right(unsigned(pairs_cnt), stg_cnt)) & '0';
                    tempB := std_logic_vector(rotate_right(unsigned(pairs_cnt), stg_cnt)) & '1';

                    addr_0 <= std_logic_vector(rotate_left(unsigned(tempA), stg_cnt));
                    addr_1 <= std_logic_vector(rotate_left(unsigned(tempB), stg_cnt));

                    temptwd := std_logic_vector(shift_right(unsigned(temptwd), stg_cnt));

                    twd_addr_0 <= temptwd((stages - 1) - 1 downto 0);
                    twd_addr_1 <= temptwd((stages - 1) - 1 downto 0);
                end if;
        end process async;
        

end Dataflow;