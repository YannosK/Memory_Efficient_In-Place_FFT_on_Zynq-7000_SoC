library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_FFT_IP is
    generic
    (
        points      : positive := 32;   -- number of input points of FFT
        stages      : positive := 10;    -- number of stages of FFT. For p points there are lg2(p) stages
        stagebits   : positive := 4;    -- number of bits needed to represent the stages. For s stages one needs lg2(s) bits
        shiftbits   : positive := 5;    -- number of bits to represent the number of most possible shifts
        maxcount    : positive := 8;    -- number of bits needed for the total shift counter. Max value is as many shifts left as the decimal points. So sh = ((width/4) - 2) shifts left, you need lg2(sh) + 1 bits (signed) 
        width       : positive := 32;   -- word width of RAM in this architecture
        ROM_file    : string := "D:/Yannos/FILES/PROGRAMS/DST/FFT_implementation/fft-avr3200/dataset/twiddles/twiddles_1024p.txt"
    );
    port
    (
        clk         : in std_logic;
        peripheral_aresetn : in std_logic_vector(0 to 0);
        start       : in std_logic;
        running     : out std_logic; 
        ready       : out std_logic;
        total_shifts: out std_logic_vector(maxcount - 1 downto 0);
        ------------------------------------------------------------
        -- RAM interfaces
        ------------------------------------------------------------
   		BRAM_PORTB_0_clk : out STD_LOGIC;
        BRAM_PORTB_0_rst : out STD_LOGIC;
        BRAM_PORTB_0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
        BRAM_PORTB_0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
        BRAM_PORTB_0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
        BRAM_PORTB_0_en : out STD_LOGIC;
        BRAM_PORTB_0_we : out STD_LOGIC_VECTOR ( 3 downto 0 )
    );
end top_level_FFT_IP;

architecture Structural of top_level_FFT_IP is

    -----------------------------------------------------
    -- Components / Modules
    -----------------------------------------------------

    component reg is
        generic (width : positive := 32);
        port
        (
            clk     : in std_logic;
            rst     : in std_logic;
            we      : in std_logic;
            d_in    : in std_logic_vector(width-1 downto 0);
            d_out   : out std_logic_vector(width-1 downto 0)
        );
    end component reg;

    component reg_comp is
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
    end component reg_comp;

    component ROM is 
        generic
        (
            addr    : positive := 3;    -- number of bits of address
            dat     : positive := 16;   -- number of bits of data (word length)
            memlen  : positive := 8;    -- number of words in memory
            filepath: string := "D:/Yannos/FILES/PROGRAMS/DST/FFT_implementation/fft-avr3200/Designs/dataset/twiddles/twiddles_16p.txt"
        );
        port
        (
            address : in std_logic_vector(addr-1 downto 0); -- address to read data from
            d_out   : out std_logic_vector(dat-1 downto 0)  -- data read, specified by address
        );
    end component ROM;

    component PE is
        generic
        (
            width       : positive := 16;   -- number of bits to represent one datum (real and imaginary part)
            twid_width  : positive := 2*18;
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
    end component PE;

    component address_gen is
        generic
        (
            stages      : positive := 4;    -- FFT stages. For p points FFT, there are lg2(p) stages
            stagesbits  : positive := 2    -- bits needed to represent stages. For s stages in FFT lg2(s) bits are needed
        );
        port
        (
            clk         : in std_logic;
            rst         : in std_logic;
            en          : in std_logic;
            stage_counter   : out std_logic_vector(stagesbits - 1 downto 0);
            pairs_counter   : out std_logic_vector((stages - 2) - 1 downto 0);
            addr_0      : out std_logic_vector((stages - 1) - 1 downto 0);
            addr_1      : out std_logic_vector((stages - 1) - 1 downto 0);
            twd_addr_0  : out std_logic_vector((stages - 1) - 1 downto 0);
            twd_addr_1  : out std_logic_vector((stages - 1) - 1 downto 0)
        );
    end component address_gen;

    component shifts_count is
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
    end component shifts_count;

    component FSM is
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
            start           : in std_logic; 
            stage_cnt       : in std_logic_vector(stagebits - 1 downto 0);
            pair_cnt        : in std_logic_vector((stages - 2) - 1 downto 0);
            shamtr          : in std_logic_vector(1 downto 0);
            running         : out std_logic;
            ready           : out std_logic;
            r0_we           : out std_logic;
            r1_we           : out std_logic;
            RAM_we          : out std_logic;
            SEL_PE_input    : out std_logic;
            SEL_RegData     : out std_logic;
            SEL_swipe       : out std_logic;
            SEL_RAMAddr     : out std_logic;
            EN_Pairs        : out std_logic;
            EN_shamt        : out std_logic;
            EN_compare      : out std_logic;
            RST_AGU         : out std_logic;
            RST_shamt       : out std_logic
        );
    end component FSM;

    -----------------------------------------------------
    -- Constants
    -----------------------------------------------------

    constant FFT_stages     : positive := stages;
    constant FFT_stages_bits: positive := stagebits;
    constant RAM_width      : positive := width;
    constant ROM_width      : positive := 46;
    constant RAM_length     : positive := points / 2;
    constant ROM_length     : positive := points / 2;
    constant RAM_addr       : positive := stages - 1;
    constant ROM_addr       : positive := stages - 1;
    
    -----------------------------------------------------
    -- Internal Signals
    -----------------------------------------------------

    signal rst          : std_logic;        -- active high reset

    signal start_reg    : std_logic;        -- registered start signal
    signal start_int    : std_logic;        -- devounced start signal
    
    signal r0_we        : std_logic;                                        -- write enable for register R0
    signal r0_in        : std_logic_vector(RAM_width - 1 downto 0);   -- R0 data input
    signal r0_out       : std_logic_vector(RAM_width - 1 downto 0);   -- R0 data output
    
    signal r1_we        : std_logic;                                        -- write enable for register R1
    signal r1_in        : std_logic_vector(RAM_width - 1 downto 0);   -- R1 data input
    signal r1_out       : std_logic_vector(RAM_width - 1 downto 0);   -- R1 data output

    signal reg_in       : std_logic_vector(RAM_width - 1 downto 0);   -- common signal for registers that connects to the data out of two RAMs
    
    signal shamt_PE     : std_logic_vector(shiftbits - 1 downto 0); -- right and left (in that order) shift amount produced by the PE 
    signal shamt_reg    : std_logic_vector(shiftbits - 1 downto 0); -- right and left (in that order) shift amount produced by the reg_comp
    signal comp_rst     : std_logic;                                -- reset for the shift amount compare  register
    signal shamt        : std_logic_vector(shiftbits - 1 downto 0); -- right and left (in that order) shift amount stored in the shamt register
    signal shamt_rst    : std_logic;                                -- reset for the shift amount register

    signal RAM_we       : std_logic;                                -- RAM write enable
    signal RAM_address  : std_logic_vector(RAM_addr-1 downto 0);    -- RAM read and write address
    signal RAM_dat_in   : std_logic_vector(RAM_width-1 downto 0);   -- RAM data input 
    signal RAM_dat_out  : std_logic_vector(RAM_width-1 downto 0);   -- RAM data output

    signal RAM_high     : std_logic_vector(width - 1 downto (RAM_addr + 2)) := (others => '0');
    signal RAM_low      : std_logic_vector(1 downto 0) := (others => '0');

    signal ROM_address0 : std_logic_vector(ROM_addr-1 downto 0);    -- address for twiddle for R0 butterfly
    signal ROM_address1 : std_logic_vector(ROM_addr-1 downto 0);    -- address for twiddle for R1 butterfly
    signal ROM_address  : std_logic_vector(ROM_addr-1 downto 0);    -- ROM read address
    signal ROM_data     : std_logic_vector(ROM_width-1 downto 0);   -- ROM data output

    signal PE_input_A   : std_logic_vector(RAM_width/2-1 downto 0); -- First input of butterfly processor. This one will lead to addition-like operation of FFT
    signal PE_input_B   : std_logic_vector(RAM_width/2-1 downto 0); -- Second input of butterfly processor. This one will lead to subtraction-like operation of FFT
    signal PE_output_A  : std_logic_vector(RAM_width/2-1 downto 0); -- First output of butterfly processor. This one is the result of addition-like operation of FFT
    signal PE_output_B  : std_logic_vector(RAM_width/2-1 downto 0); -- Second output of butterfly processor. This one is the result of subtraction-like operation of FFT

    signal AGU_rst      : std_logic;                                -- reset for the AGU unit (basically its counter)
    signal AGU_addr0    : std_logic_vector(RAM_addr-1 downto 0);    -- R0's data source / destination address in the RAM,  generated from address generation unit
    signal AGU_addr1    : std_logic_vector(RAM_addr-1 downto 0);    -- R1's data source / destination address in the RAM,  generated from address generation unit

    signal stage_cnt        : std_logic_vector(FFT_stages_bits - 1 downto 0);  -- count of FFT stage
    signal pair_cnt         : std_logic_vector((FFT_stages - 2) - 1 downto 0);-- count of pairs
    signal SEL_PE_input     : std_logic;    -- select for MUX of PE's input signal. When 0, R0 out is input. When 1, R1 out is input. Alongside the twiddle address changes
    signal SEL_RegData      : std_logic;    -- select data to be written in the two registers. If 0 the source is RAM output, else it is PE output
    signal SEL_swipe        : std_logic;    -- swipes the data of registers, according to the FFT algorithm. It happens when '1'
    signal SEL_RAMAddr      : std_logic;    -- selects if something from / to R0 is written to / read from RAM (when '0') or from / to R1 (when '1')
    signal EN_Pairs         : std_logic;    -- enables the stage and pair counter to go to the next pair / stage
    signal EN_compare       : std_logic;    -- enables the shift compare register
    signal EN_shamt         : std_logic;    -- enables write in the shift amount register, and resets the shamt reg compare
    signal EN_final_stage   : std_logic;    -- enable for final stage - after the FFT (used inside the PE)
    signal RST_AGU          : std_logic;    -- signal to reset the AGU
    signal RST_shamt        : std_logic;    -- signal to reset the shift amount register
    signal running_int      : std_logic;    -- internal signal that signifies that FFT is running
    
    begin

        -- Signal Assignments

        rst <= not peripheral_aresetn(0);

        start_int <= (not start_reg) and start;

        comp_rst <= rst or EN_shamt;
        AGU_rst <= rst or RST_AGU;
        shamt_rst <= rst or RST_shamt;
        running <= running_int;
        
        -- RAM signals
        BRAM_PORTB_0_clk <= clk;
        BRAM_PORTB_0_rst <= rst;
        BRAM_PORTB_0_addr <= RAM_high & RAM_address & RAM_low;
        BRAM_PORTB_0_din <= RAM_dat_in;
        RAM_dat_out <= BRAM_PORTB_0_dout;
        BRAM_PORTB_0_en <= '1';
        BRAM_PORTB_0_we <= RAM_we & RAM_we & RAM_we & RAM_we;
        
        -- Structural module mappings

        R0: reg
            generic map (width => RAM_width)
            port map
            (
                clk   => clk,
                rst   => rst,
                we    => r0_we,
                d_in  => r0_in,
                d_out => r0_out
            );

        R1: reg
            generic map (width => RAM_width)
            port map
            (
                clk   => clk,
                rst   => rst,
                we    => r1_we,
                d_in  => r1_in,
                d_out => r1_out
            );

        shift_amount_register: reg
            generic map ( width => shiftbits )
            port map
            (
                clk   => clk,
                rst   => shamt_rst,
                we    => EN_shamt,
                d_in  => shamt_reg,
                d_out => shamt
            );

        shamt_reg_compare: reg_comp
            generic map (shiftbits => shiftbits)
            port map
            (
                clk     => clk,
                rst     => comp_rst,
                en      => EN_compare,
                shr_in  => shamt_PE(shiftbits - 1 downto shiftbits - 2),
                shl_in  => shamt_PE(shiftbits - 3 downto 0),
                shr_out => shamt_reg(shiftbits - 1 downto shiftbits - 2),
                shl_out => shamt_reg(shiftbits - 3 downto 0)
            );

        Total_Shifts_Counter: shifts_count
            generic map
            (
                width => shiftbits,
                max_count => maxcount
            )
            port map
            (
                clk     => clk,
                rst     => rst,
                en      => EN_shamt,
                shr     => shamt_reg(shiftbits - 1 downto shiftbits - 2),
                shl     => shamt_reg(shiftbits - 3 downto 0),
                total   => total_shifts
            );  
        
        Twiddle_ROM: ROM
            generic map
            (
                addr    => ROM_addr,
                dat     => ROM_width,
                memlen  => ROM_length,
                filepath => ROM_file
            )
            port map
            (
                address => ROM_address,
                d_out   => ROM_data
            );

        Butterfly_Processing_Element: PE
            generic map
            (
                width => RAM_width/2,
                twid_width => ROM_width,
                shiftbits => shiftbits
            )
            port map
            (
                clk         => clk,
                rst         => rst,
                in_A        => PE_input_A,
                in_B        => PE_input_B,
                twiddle     => ROM_data,
                shr_in      => shamt(shiftbits - 1 downto shiftbits - 2),
                shl_in      => shamt(shiftbits - 3 downto 0),
                out_A       => PE_output_A,
                out_B       => PE_output_B,
                shr_out     => shamt_PE(shiftbits - 1 downto shiftbits - 2),
                shl_out     => shamt_PE(shiftbits - 3 downto 0)
            );

        Address_Generation_Unit: address_gen
            generic map
            (
                stages      => FFT_stages,
                stagesbits  => FFT_stages_bits
            )
            port map
            (
                clk             => clk,
                rst             => AGU_rst,
                stage_counter   => stage_cnt,
                pairs_counter   => pair_cnt,
                en              => EN_Pairs,
                addr_0          => AGU_addr0,
                addr_1          => AGU_addr1,
                twd_addr_0      => ROM_address0,
                twd_addr_1      => ROM_address1
            );

        Control_FSM: FSM
            generic map
            (
                points      => points,
                stagesbits  => FFT_stages_bits,
                stages      => FFT_stages
            )
            port map
            (
                clk             => clk,
                rst             => rst,
                start           => start_int,
                stage_cnt       => stage_cnt,
                pair_cnt        => pair_cnt,
                shamtr          => shamt_reg(shiftbits - 1 downto shiftbits - 2),
                running         => running_int,
                ready           => ready,
                r0_we           => r0_we,
                r1_we           => r1_we,
                RAM_we          => RAM_we,
                SEL_PE_input    => SEL_PE_input,
                SEL_RegData     => SEL_RegData,
                SEL_swipe       => SEL_swipe,
                SEL_RAMAddr     => SEL_RAMAddr,
                EN_Pairs        => EN_Pairs,
                EN_shamt        => EN_shamt,
                EN_compare      => EN_compare,
                RST_AGU         => RST_AGU,
                RST_shamt       => RST_shamt
            );

        -- Processes

        debounce_start: process (clk, rst)
            begin
                if rst = '1' then
                    start_reg <= '0';
                elsif rising_edge(clk) then
                    start_reg <= start;
                end if;
        end process debounce_start;

        PE_input_MUX: process (clk, rst, r0_out, r1_out, SEL_PE_input)
            begin
                if SEL_PE_input = '1' then
                    PE_input_A <= r1_out(RAM_width - 1 downto RAM_width/2);
                    PE_input_B <= r1_out((RAM_width/2) - 1 downto 0);
                else
                    PE_input_A <= r0_out(RAM_width - 1 downto RAM_width/2);
                    PE_input_B <= r0_out((RAM_width/2) - 1 downto 0);
                end if;
        end process PE_input_MUX;

        ROM_input_MUX: process (clk, rst, ROM_address0, ROM_address1, SEL_PE_input)
            begin
                if SEL_PE_input = '1' then
                    ROM_address <= ROM_address1;
                else
                    ROM_address <= ROM_address0;
                end if;
        end process ROM_input_MUX;

        PE_output_DEMUX: process (clk, rst, PE_output_A, PE_output_B, SEL_RegData, RAM_dat_out)
            begin
                if SEL_RegData = '1' then
                    reg_in <= PE_output_A & PE_output_B;
                else
                    reg_in <= RAM_dat_out(width - 1 downto width/2) & RAM_dat_out(width/2 - 1 downto 0);
                end if;
        end process PE_output_DEMUX;

        reg_data_swipe: process (clk, rst, r0_out, r1_out, SEL_swipe, reg_in)
            begin
                if SEL_swipe = '1' then
                    r0_in <= r0_out(RAM_width - 1 downto RAM_width/2) & r1_out(RAM_width - 1 downto RAM_width/2);
                    r1_in <= r0_out((RAM_width/2) - 1 downto 0) & r1_out((RAM_width/2) - 1 downto 0);
                else
                    r0_in <= reg_in;
                    r1_in <= reg_in;
                end if;
        end process reg_data_swipe;

        RAM_address_MUX: process (clk, rst, AGU_addr0, AGU_addr1, SEL_RAMAddr, r1_out, r0_out)
            begin
                if SEL_RAMAddr = '1' then
                    RAM_address <= AGU_addr1;
                    RAM_dat_in <= r1_out;
                else
                    RAM_address <= AGU_addr0;
                    RAM_dat_in <= r0_out;
                end if;
        end process RAM_address_MUX;
        
end Structural;

