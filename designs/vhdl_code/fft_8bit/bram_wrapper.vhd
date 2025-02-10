library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bram_wrapper is
    generic
    (
        width   : positive := 32;
        addr    : positive := 14
    );
    port
    (
        clk     : in std_logic;
        ------------------------------------------------------------
        we_int    : in std_logic;                             -- write enable for internal port
        addr_int  : in std_logic_vector(addr-1 downto 0);     -- write address for internal port
        din_int    : in std_logic_vector(width-1 downto 0);      -- input data to internal port
        dout_int   : out std_logic_vector(width-1 downto 0);      -- output data from internal port
        ------------------------------------------------------------
        we_ext    : in std_logic;                             -- write enable for external port
        addr_ext  : in std_logic_vector(addr-1 downto 0);     -- write address for external port
        din_ext    : in std_logic_vector(width-1 downto 0);      -- input data to external port
        dout_ext   : out std_logic_vector(width-1 downto 0)      -- output data from external port
    );

end bram_wrapper;

architecture wrapper of bram_wrapper is

    -------------------------------------------------
    -- Instantiation template from Xilinx IP Catalog
    -------------------------------------------------
    COMPONENT blk_mem_gen_0
    PORT (
      clka : IN STD_LOGIC;
      wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
      dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      clkb : IN STD_LOGIC;
      web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addrb : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
      dinb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
    );
    END COMPONENT;
    -------------------------------------------------
    
    signal we_int_vector : std_logic_vector(0 downto 0);
    signal we_ext_vector : std_logic_vector(0 downto 0);

    signal addr_a : std_logic_vector(13 downto 0);
    signal addr_b : std_logic_vector(13 downto 0);
    
    begin

        we_int_vector(0) <= we_int;
        we_ext_vector(0) <= we_ext;

        addr_a <= std_logic_vector(resize(unsigned(addr_int), addr_a'length));
        addr_b <= std_logic_vector(resize(unsigned(addr_ext), addr_b'length));

        block_ram_ip: blk_mem_gen_0
            port map (
                clka    => clk,
                wea     => we_int_vector,
                addra   => addr_a,
                dina    => din_int,
                douta   => dout_int,
                clkb    => clk,
                web     => we_ext_vector,
                addrb   => addr_b,
                dinb    => din_ext,
                doutb   => dout_ext
            );

end wrapper;