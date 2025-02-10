library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM is
    generic
    (
        points      : positive := 16;
        stagesbits  : positive := 2;
        stages      : positive := 4
    );
    port
    (
        clk             : in std_logic;
        rst             : in std_logic;
        start           : in std_logic;                                 -- starts the FFT
        stage_cnt       : in std_logic_vector(stagesbits - 1 downto 0); -- count of FFT stage
        pair_cnt        : in std_logic_vector((stages - 2) - 1 downto 0);-- count of pairs
        shamtr          : in std_logic_vector(1 downto 0);              -- right shift amount fromt register compare, produced during the stage
        running         : out std_logic;    -- signal that FFT is currently running
        ready           : out std_logic;    -- signal that FFT is finished / or hasn't even run
        r0_we           : out std_logic;
        r1_we           : out std_logic;
        RAM_we          : out std_logic;
        SEL_PE_input    : out std_logic;    -- select for MUX of PE's input signal. When 0, R0 out is input. When 1, R1 out is input
        SEL_RegData     : out std_logic;    -- select data to be written in the two registers. If 0 the source is RAM output, else it is PE output
        SEL_swipe       : out std_logic;    -- swipes the data of registers, according to the FFT algorithm. It happens when '1'
        SEL_RAMAddr     : out std_logic;    -- selects if something from / to R0 is written to / read from RAM (when '0') or from / to R1 (when '1')
        EN_Pairs        : out std_logic;    -- enables the stage and pair counter to go to the next pair / stage
        EN_shamt        : out std_logic;    -- enables write in the shift amount register
        EN_compare      : out std_logic;    -- enables the shift compare register
        RST_AGU         : out std_logic;    -- signal to reset the AGU
        RST_shamt       : out std_logic     -- signal to reset the shift amount register
    );
end entity FSM;

architecture Control of FSM is

    type FSM_states is
        (
            S_idle,
            S_reg_load,     -- Generate new addresses and load data from memories to the registers
            S_butterfly,    -- perform butterfly
            S_permutation,  -- performs permutation on register values
            S_mem_write     -- writes the contnents of the registers back to the memory
        );
    
    signal current_state: FSM_states;
    signal next_state   : FSM_states;
    signal current_tick : integer := 0;
    signal next_tick : integer := 0;

    begin

        state_reg: process (clk, rst)
            begin
                if rst = '1' then
                    current_state <= S_idle;
                    current_tick <= 0;
                elsif rising_edge(clk) then
                    current_state <= next_state;
                    current_tick <= next_tick;
                end if;
        end process state_reg;
        
        control_logic: process (clk, rst)
            begin
                if rst = '1' then
                    next_state      <= S_idle;
                    next_tick       <= 0;
                    running         <= '1';
                    ready           <= '0';
                    r0_we           <= '0';
                    r1_we           <= '0';
                    RAM_we          <= '0';
                    SEL_PE_input    <= '0';
                    SEL_RegData     <= '0';
                    SEL_swipe       <= '0';
                    SEL_RAMAddr     <= '0';
                    EN_Pairs        <= '0';
                    EN_shamt        <= '0';
                    EN_compare      <= '0';
                    RST_AGU         <= '0';
                    RST_shamt       <= '0';
                elsif falling_edge(clk) then
                    next_state      <= S_idle;
                    next_tick       <= 0;
                    running         <= '1';
                    ready           <= '0';
                    r0_we           <= '0';
                    r1_we           <= '0';
                    RAM_we          <= '0';
                    SEL_PE_input    <= '0';
                    SEL_RegData     <= '0';
                    SEL_swipe       <= '0';
                    SEL_RAMAddr     <= '0';
                    EN_Pairs        <= '0';
                    EN_shamt        <= '0';
                    EN_compare      <= '0';
                    RST_AGU         <= '0';
                    RST_shamt       <= '0';
                    case current_state is
                        when S_idle =>
                            next_tick <= 0;
                            running <= '0';
                            ready <= '1';
                            if start = '1' then
                                r0_we <= '1';
                                next_state <= S_reg_load;
                            else
                                next_state <= S_idle;
                            end if;
                        when S_reg_load =>
                            next_state <= S_reg_load;
                            SEL_RegData <= '0';
                            if to_integer(unsigned(stage_cnt)) = 0 and to_integer(unsigned(pair_cnt)) = 0 then
                                -- case (current_tick) is
                                --     when 1 =>
                                --         r1_we <= '1';
                                --         SEL_RAMAddr <= '1';
                                --         next_tick <= current_tick + 1;
                                --     when 2 =>
                                --         next_tick <= 0;
                                --         next_state <= S_butterfly;
                                --     when others =>
                                --         SEL_RAMAddr <= '1';
                                --         next_tick <= current_tick + 1;
                                -- end case;
                                if current_tick = 1 then
                                    r1_we <= '1';
                                    SEL_RAMAddr <= '1';
                                    next_tick <= current_tick + 1;
                                elsif current_tick = 2 then
                                    next_tick <= 0;
                                    next_state <= S_butterfly;
                                else
                                    SEL_RAMAddr <= '1';
                                    next_tick <= current_tick + 1;
                                end if;
                            else
                                -- case (current_tick) is
                                --     when 1 =>
                                --         r0_we <= '1';
                                --         next_tick <= current_tick + 1;
                                --     when 2 =>
                                --         SEL_RAMAddr <= '1';
                                --         next_tick <= current_tick + 1;
                                --     when 3 =>
                                --         SEL_RAMAddr <= '1';
                                --         r1_we <= '1';
                                --         next_tick <= current_tick + 1;
                                --     when 4 =>
                                --         next_tick <= 0;
                                --         next_state <= S_butterfly;
                                --     when others =>
                                --         next_tick <= current_tick + 1;
                                -- end case;
                                if current_tick = 1 then
                                    r0_we <= '1';
                                    next_tick <= current_tick + 1;
                                elsif current_tick = 2 then
                                    SEL_RAMAddr <= '1';
                                    next_tick <= current_tick + 1;
                                elsif current_tick = 3 then
                                    SEL_RAMAddr <= '1';
                                    r1_we <= '1';
                                    next_tick <= current_tick + 1;
                                elsif current_tick = 4 then
                                    next_tick <= 0;
                                    next_state <= S_butterfly;
                                else
                                    next_tick <= current_tick + 1;
                                end if;
                            end if; 
                        when S_butterfly =>
                            next_state <= S_butterfly;
                            SEL_RegData <= '1';
                            -- case (current_tick) is
                            --     when 0 =>
                            --         SEL_PE_input <= '1';
                            --         next_tick <= current_tick + 1;
                            --     when 1 =>
                            --         SEL_PE_input <= '1';
                            --         next_tick <= current_tick + 1;
                            --     when 8 =>
                            --         r0_we <= '1';
                            --         EN_compare <= '1';
                            --         next_tick <= current_tick + 1;
                            --     when 9 =>
                            --         r1_we <= '1';
                            --         EN_compare <= '1';
                            --         next_tick <= current_tick + 1;
                            --     when 10 =>
                            --         next_tick <= 0;
                            --         if to_integer(unsigned(stage_cnt)) = stages - 1 then
                            --             RAM_we <= '1';
                            --             next_state <= S_mem_write;
                            --         else
                            --             SEL_swipe <= '1';
                            --             next_state <= S_permutation;
                            --         end if;
                            --     when others =>
                            --         next_tick <= current_tick + 1;
                            -- end case;
                            if current_tick = 0 then
                                SEL_PE_input <= '1';
                                next_tick <= current_tick + 1;
                            elsif current_tick = 1 then
                                SEL_PE_input <= '1';
                                next_tick <= current_tick + 1;
                            elsif current_tick = 8 then
                                r0_we <= '1';
                                EN_compare <= '1';
                                next_tick <= current_tick + 1;
                            elsif current_tick = 9 then
                                r1_we <= '1';
                                EN_compare <= '1';
                                next_tick <= current_tick + 1;
                            elsif current_tick = 10 then
                                next_tick <= 0;
                                if to_integer(unsigned(stage_cnt)) = stages - 1 then
                                    RAM_we <= '1';
                                    next_state <= S_mem_write;
                                else
                                    SEL_swipe <= '1';
                                    next_state <= S_permutation;
                                end if;
                            else
                                next_tick <= current_tick + 1;
                            end if;
                        when S_permutation =>
                            next_state <= S_permutation;
                            SEL_swipe <= '1';
                            if current_tick = 1 then
                                next_tick <= 0;
                                RAM_we <= '1';
                                next_state <= S_mem_write;
                            else
                                r0_we <= '1';
                                r1_we <= '1';
                                next_tick <= current_tick + 1;
                            end if;
                        when S_mem_write =>
                            next_state <= S_mem_write;
                            if current_tick = 1 then
                                next_tick <= 0;
                                RAM_we <= '0';
                                if to_integer(unsigned(pair_cnt)) = (points/4) - 1 then
                                    -- EN_shamt <= '1';
                                    if to_integer(unsigned(stage_cnt)) = stages - 1 then
                                        EN_shamt <= '0';
                                        RST_AGU <= '1';
                                        RST_shamt <= '1';
                                        next_state <= S_idle;
                                    else
                                        EN_shamt <= '1';
                                        EN_Pairs <= '1';
                                        next_state <= S_reg_load;
                                    end if;
                                else
                                    EN_Pairs <= '1';
                                    next_state <= S_reg_load;
                                end if;
                            else
                                SEL_RAMAddr <= '1';
                                RAM_we <= '1';
                                next_tick <= current_tick + 1;
                            end if;
                        when others =>
                            next_state <= S_idle;
                    end case;
                end if;
        end process control_logic;

end Control;