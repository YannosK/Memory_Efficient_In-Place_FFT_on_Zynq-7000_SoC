library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.ENV.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity top_level_module_tb is
    generic
    (
        points      : positive := 1024;   -- number of input points of FFT
        stages      : positive := 10;    -- number of stages of FFT. For p points there are lg2(p) stages
        stagebits   : positive := 4;    -- number of bits needed to represent the stages. For s stages one needs lg2(s) bits
        shiftbits   : positive := 5;    -- number of bits to represent the number of most possible shifts
        maxcount    : positive := 8;    -- number of bits needed for the total shift counter. Max value is as many shifts left as the decimal points. So sh = ((width/4) - 2) shifts left, you need lg2(sh) + 1 bits (signed) 
        width       : positive := 32;   -- word width of RAM in this architecture
        RAM_file    : string := "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/8bit/input_bin/random_samples/32_bits/1024_samples/0_in.txt";
        ROM_file    : string := "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/twiddles/memconfig_22-1/twiddles_1024p.txt";
        resultfile  : string := "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/8bit/output_bin/random_samples/32_bits/1024_samples/0_out.txt"
    );
end top_level_module_tb;

architecture Behavioral of top_level_module_tb is

    component top_level_module is
        generic
        (
            points      : positive := 16;   -- number of input points of FFT
            stages      : positive := 4;    -- number of stages of FFT. For p points there are lg2(p) stages
            stagebits   : positive := 3;    -- number of bits needed to represent the stages. For s stages one needs lg2(s) bits
            shiftbits   : positive := 5;    -- number of bits to represent the number of most possible shifts
            maxcount    : positive := 8;    -- number of bits needed for the total shift counter. Max value is as many shifts left as the decimal points. So sh = ((width/4) - 2) shifts left, you need lg2(sh) + 1 bits (signed) 
            width       : positive := 32;   -- word width of RAM in this architecture
            ROM_file    : string := "D:/Yannos/FILES/PROGRAMS/DST/FFT_implementation/fft-avr3200/FPGA_input/random_samples/16_samples/twiddles_16p.txt"
        );
        port
        (
            clk         : in std_logic;
            rst         : in std_logic;
            start       : in std_logic;
            running     : out std_logic; 
            ready       : out std_logic;
            total_shifts: out std_logic_vector(maxcount - 1 downto 0);
            ------------------------------------------------------------
            -- RAM interfaces
            ------------------------------------------------------------
            mem_data_in     : in std_logic_vector(width - 1 downto 0);          -- data to be written in RAM
            mem_address     : in std_logic_vector((stages - 1) - 1 downto 0);   -- address to read-to / write-from memory
            mem_we          : in std_logic;                                     -- write enable
            mem_data_out    : out std_logic_vector(width - 1 downto 0)          -- data read back from RAM
        );
    end component top_level_module;

    signal clk         : std_logic;
    signal rst         : std_logic;
    signal start       : std_logic := '0';
    signal running     : std_logic; 
    signal ready       : std_logic;
    signal total_shifts: std_logic_vector(maxcount - 1 downto 0);

    signal mem_data_in  : std_logic_vector(width - 1 downto 0);            
    signal mem_address  : std_logic_vector((stages - 1) - 1 downto 0);
    signal mem_we       : std_logic := '0';                          
    signal mem_data_out : std_logic_vector(width - 1 downto 0);

    constant reg_load_first_C   : integer := 3;
    constant reg_load_C         : integer := 5;
    constant butterfly_C        : integer := 11;
    constant permutation_C      : integer := 2;
    constant mem_write_C        : integer := 2;
    -- constant final_round_C      : integer := 3;

    constant period : time := 10 ns;

    constant reg_load_first : time := period * reg_load_first_C;
    constant reg_load       : time := period * reg_load_C      ;
    constant butterfly      : time := period * butterfly_C     ;
    constant permutation    : time := period * permutation_C   ;
    constant mem_write      : time := period * mem_write_C     ;
    -- constant final_round    : time := period * final_round_C   ;


    constant files  : boolean := true;     -- set as true if you want your ouput in a file

    file file_outputs   : text;

    begin

        uut: top_level_module
            generic map
            (
                points    => points,
                stages    => stages,
                stagebits => stagebits,
                shiftbits => shiftbits,
                maxcount  => maxcount,
                width     => width,
                ROM_file  => ROM_file
            )
            port map
            (
                clk          => clk,
                rst          => rst,
                start        => start,
                running      => running,
                ready        => ready,
                total_shifts => total_shifts,
                mem_data_in  => mem_data_in, 
                mem_address  => mem_address, 
                mem_we       => mem_we,      
                mem_data_out => mem_data_out
            );

        clocking: process is
            begin
                clk <= '1';
                wait for period/2;
                clk <= '0';
                wait for period/2;
        end process clocking;

        testbench: process is
            variable cycle_count    : integer := 0;
--            variable no_final_stage : boolean := false;
            variable line_output    : line;
            variable tot_shifts     : integer := 0;
            begin

                ----------------------------------
                -- Beginnings
                ----------------------------------

                rst <= '1';
                wait for period;
                rst <= '0';
                wait for period;

                ----------------------------------
                -- Generic run
                ----------------------------------
                
                -- stop(0);

                -- S_idle : 1 C
                wait until falling_edge(clk);
                start <= '1';
                wait until rising_edge(clk);
                wait for period;
                -- First Butterfly : reg_load_first * butterlfy * permutation * mem_write Cycles
                wait for reg_load_first;
                start <= '0';
                wait for butterfly;
                wait for permutation;
                wait for mem_write;
                -- First stage : (reg_load * butterfly * permutation * mem_write) * (points/4 - 1) Cycles
                first_stage: for I in 0 to (points/4 - 1 - 1) loop
                    wait for reg_load;
                    wait for butterfly;
                    wait for permutation;
                    wait for mem_write;
                end loop first_stage;
                -- Intermidiate Stages : (reg_load * butterfly * permutation) * (points/4) * (stages - 1 - 1) Cycles
                inter_stages: for I in 0 to (stages - 1 - 1 - 1) loop
                    for J in 0 to points/4 - 1 loop
                        wait for reg_load;
                        wait for butterfly;
                        wait for permutation;
                        wait for mem_write;
                    end loop;
                end loop inter_stages;
                -- Final stage : (reg_load * butterfly * mem_write) * (points/4) Cycles
                final_stage:for I in 0 to points/4 - 1 loop
                    wait for reg_load;
                    wait for butterfly;
                    wait for mem_write;
                end loop final_stage;
                -- stop(1);

                cycle_count :=  1    
                                + (reg_load_first_C + butterfly_C + permutation_C + mem_write_C) 
                                + ((reg_load_C + butterfly_C + permutation_C + mem_write_C) * (points/4 - 1)) 
                                + ((reg_load_C + butterfly_C + permutation_C) * (points/4) * (stages - 1 - 1)) 
                                + ((reg_load_C + butterfly_C + mem_write_C) * (points/4));

                report "FFT finished with cycle count: " & integer'image(cycle_count);
                report "For 10 ns period clock, it took: " & time'image(cycle_count * period);

                ----------------------------------
                -- Endings
                ----------------------------------
                wait for period * 2;
                -- stop(-1);

                if files = true then
                    file_open(file_outputs, resultfile, write_mode);
                    for I in 0 to points/2 - 1 loop
                        mem_address <= std_logic_vector(to_unsigned(I, mem_address'length));
                        wait for 2 * period;
                        write(line_output, mem_data_out, right, width);
                        writeline(file_outputs, line_output);
                    end loop;
                    tot_shifts := to_integer(signed(total_shifts));
                    write(line_output, tot_shifts);
                    writeline(file_outputs, line_output);
                    stop(0);
                    -- finish;
                     wait;
--                    report "Just Kidding.   Test Done."  severity failure ;
                end if;
                
        end process testbench;

end Behavioral;
