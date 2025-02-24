library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_IP is
    generic
    (
		-- Width of S_AXI data bus
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH	: integer	:= 4;
        -- My generics
        points      : positive := 8192;   -- number of input points of FFT
        stages      : positive := 13;    -- number of stages of FFT. For p points there are lg2(p) stages
        stagebits   : positive := 4;    -- number of bits needed to represent the stages. For s stages one needs lg2(s) bits
        shiftbits   : positive := 5;    -- number of bits to represent the number of most possible shifts
        maxcount    : positive := 8;    -- number of bits needed for the total shift counter. Max value is as many shifts left as the decimal points. So sh = ((width/4) - 2) shifts left, you need lg2(sh) + 1 bits (signed) 
        width       : positive := 32;   -- word width of RAM in this architecture
        ROM_file    : string := "D:/Yannos/FILES/PROGRAMS/DST/FFT_implementation/fft-avr3200/dataset/twiddles/twiddles_8192p.txt"
    );
    Port
    (
        FCLK_CLK0 : in STD_LOGIC;
        peripheral_aresetn : in STD_LOGIC_VECTOR ( 0 to 0 );
   		BRAM_PORTB_0_clk : out STD_LOGIC;
        BRAM_PORTB_0_rst : out STD_LOGIC;
        BRAM_PORTB_0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
        BRAM_PORTB_0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
        BRAM_PORTB_0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
        BRAM_PORTB_0_en : out STD_LOGIC;
        BRAM_PORTB_0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
        -- AXI SLACE
    	-- Global Clock Signal
    	S_AXI_ACLK	: in std_logic;
    	-- Global Reset Signal. This Signal is Active LOW
    	S_AXI_ARESETN	: in std_logic;
    	-- Write address (issued by master, acceped by Slave)
    	S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    	-- Write channel Protection type. This signal indicates the
      		-- privilege and security level of the transaction, and whether
      		-- the transaction is a data access or an instruction access.
    	S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
    	-- Write address valid. This signal indicates that the master signaling
      		-- valid write address and control information.
    	S_AXI_AWVALID	: in std_logic;
    	-- Write address ready. This signal indicates that the slave is ready
      		-- to accept an address and associated control signals.
    	S_AXI_AWREADY	: out std_logic;
    	-- Write data (issued by master, acceped by Slave) 
    	S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    	-- Write strobes. This signal indicates which byte lanes hold
      		-- valid data. There is one write strobe bit for each eight
      		-- bits of the write data bus.    
    	S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    	-- Write valid. This signal indicates that valid write
      		-- data and strobes are available.
    	S_AXI_WVALID	: in std_logic;
    	-- Write ready. This signal indicates that the slave
      		-- can accept the write data.
    	S_AXI_WREADY	: out std_logic;
    	-- Write response. This signal indicates the status
      		-- of the write transaction.
    	S_AXI_BRESP	: out std_logic_vector(1 downto 0);
    	-- Write response valid. This signal indicates that the channel
      		-- is signaling a valid write response.
    	S_AXI_BVALID	: out std_logic;
    	-- Response ready. This signal indicates that the master
      		-- can accept a write response.
    	S_AXI_BREADY	: in std_logic;
    	-- Read address (issued by master, acceped by Slave)
    	S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    	-- Protection type. This signal indicates the privilege
      		-- and security level of the transaction, and whether the
      		-- transaction is a data access or an instruction access.
    	S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
    	-- Read address valid. This signal indicates that the channel
      		-- is signaling valid read address and control information.
    	S_AXI_ARVALID	: in std_logic;
    	-- Read address ready. This signal indicates that the slave is
      		-- ready to accept an address and associated control signals.
    	S_AXI_ARREADY	: out std_logic;
    	-- Read data (issued by slave)
    	S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    	-- Read response. This signal indicates the status of the
      		-- read transfer.
    	S_AXI_RRESP	: out std_logic_vector(1 downto 0);
    	-- Read valid. This signal indicates that the channel is
      		-- signaling the required read data.
    	S_AXI_RVALID	: out std_logic;
    	-- Read ready. This signal indicates that the master can
      		-- accept the read data and response information.
    	S_AXI_RREADY	: in std_logic
    );
end top_level_IP;

architecture My_FFT_IP of top_level_IP is

    component axi_regs is
    	generic (
    		-- Users to add parameters here
            maxcount    : positive := 8;    -- number of bits needed for the total shift counter. Max value is as many shifts left as the decimal points. So sh = ((width/4) - 2) shifts left, you need lg2(sh) + 1 bits (signed) 
    		-- User parameters ends
    		-- Do not modify the parameters beyond this line

    		-- Width of S_AXI data bus
    		C_S_AXI_DATA_WIDTH	: integer	:= 32;
    		-- Width of S_AXI address bus
    		C_S_AXI_ADDR_WIDTH	: integer	:= 4
    	);
    	port (
    		-- Users to add ports here
            start       : out std_logic;
            running     : in std_logic; 
            ready       : in std_logic;
            total_shifts: in std_logic_vector(maxcount - 1 downto 0);

    		-- User ports ends
    		-- Do not modify the ports beyond this line

    		-- Global Clock Signal
    		S_AXI_ACLK	: in std_logic;
    		-- Global Reset Signal. This Signal is Active LOW
    		S_AXI_ARESETN	: in std_logic;
    		-- Write address (issued by master, acceped by Slave)
    		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    		-- Write channel Protection type. This signal indicates the
        		-- privilege and security level of the transaction, and whether
        		-- the transaction is a data access or an instruction access.
    		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
    		-- Write address valid. This signal indicates that the master signaling
        		-- valid write address and control information.
    		S_AXI_AWVALID	: in std_logic;
    		-- Write address ready. This signal indicates that the slave is ready
        		-- to accept an address and associated control signals.
    		S_AXI_AWREADY	: out std_logic;
    		-- Write data (issued by master, acceped by Slave) 
    		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    		-- Write strobes. This signal indicates which byte lanes hold
        		-- valid data. There is one write strobe bit for each eight
        		-- bits of the write data bus.    
    		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    		-- Write valid. This signal indicates that valid write
        		-- data and strobes are available.
    		S_AXI_WVALID	: in std_logic;
    		-- Write ready. This signal indicates that the slave
        		-- can accept the write data.
    		S_AXI_WREADY	: out std_logic;
    		-- Write response. This signal indicates the status
        		-- of the write transaction.
    		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
    		-- Write response valid. This signal indicates that the channel
        		-- is signaling a valid write response.
    		S_AXI_BVALID	: out std_logic;
    		-- Response ready. This signal indicates that the master
        		-- can accept a write response.
    		S_AXI_BREADY	: in std_logic;
    		-- Read address (issued by master, acceped by Slave)
    		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    		-- Protection type. This signal indicates the privilege
        		-- and security level of the transaction, and whether the
        		-- transaction is a data access or an instruction access.
    		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
    		-- Read address valid. This signal indicates that the channel
        		-- is signaling valid read address and control information.
    		S_AXI_ARVALID	: in std_logic;
    		-- Read address ready. This signal indicates that the slave is
        		-- ready to accept an address and associated control signals.
    		S_AXI_ARREADY	: out std_logic;
    		-- Read data (issued by slave)
    		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    		-- Read response. This signal indicates the status of the
        		-- read transfer.
    		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
    		-- Read valid. This signal indicates that the channel is
        		-- signaling the required read data.
    		S_AXI_RVALID	: out std_logic;
    		-- Read ready. This signal indicates that the master can
        		-- accept the read data and response information.
    		S_AXI_RREADY	: in std_logic
    	);
    end component;

    component top_level_FFT_IP is
        generic
        (
            points      : positive := 32;   -- number of input points of FFT
            stages      : positive := 5;    -- number of stages of FFT. For p points there are lg2(p) stages
            stagebits   : positive := 4;    -- number of bits needed to represent the stages. For s stages one needs lg2(s) bits
            shiftbits   : positive := 5;    -- number of bits to represent the number of most possible shifts
            maxcount    : positive := 8;    -- number of bits needed for the total shift counter. Max value is as many shifts left as the decimal points. So sh = ((width/4) - 2) shifts left, you need lg2(sh) + 1 bits (signed) 
            width       : positive := 32;   -- word width of RAM in this architecture
            ROM_file    : string := "../dataset/twiddles/twiddles_32p.txt"
        );
        port
        (
            clk         : in std_logic;
        	peripheral_aresetn : in std_logic_vector(0 to 0);
            start       : in std_logic;
            running     : out std_logic; 
            ready       : out std_logic;
            total_shifts: out std_logic_vector(maxcount - 1 downto 0);
   			BRAM_PORTB_0_clk : out STD_LOGIC;
        	BRAM_PORTB_0_rst : out STD_LOGIC;
            BRAM_PORTB_0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            BRAM_PORTB_0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
            BRAM_PORTB_0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
            BRAM_PORTB_0_en : out STD_LOGIC;
            BRAM_PORTB_0_we : out STD_LOGIC_VECTOR ( 3 downto 0 )
        );
    end component top_level_FFT_IP;


    signal start : std_logic;
    signal running : std_logic;
    signal ready : std_logic;
    signal total_shifts: std_logic_vector(maxcount - 1 downto 0);
    
--    signal BRAM_PORTB_0_addr : STD_LOGIC_VECTOR ( 31 downto 0 );
--    signal BRAM_PORTB_0_clk : STD_LOGIC;
--    signal BRAM_PORTB_0_din: STD_LOGIC_VECTOR ( 31 downto 0 );
--    signal BRAM_PORTB_0_dout : STD_LOGIC_VECTOR ( 31 downto 0 );
--    signal BRAM_PORTB_0_en : STD_LOGIC;
--    signal BRAM_PORTB_0_rst : STD_LOGIC;
--    signal BRAM_PORTB_0_we : STD_LOGIC_VECTOR ( 3 downto 0 );

    begin

        FFT_IP: top_level_FFT_IP
            generic map
            (
                points    => points   ,
                stages    => stages   ,
                stagebits => stagebits,
                shiftbits => shiftbits,
                maxcount  => maxcount ,
                width     => width    ,
                ROM_file  => ROM_file 
            )
            port map
            (
                clk                 => FCLK_CLK0,           -- Added the clock from ZynqPS
                peripheral_aresetn  => peripheral_aresetn,  -- Added the reset from ZynqPS
                start               => start,
                running             => running,
                ready               => ready,
                total_shifts        => total_shifts,
				BRAM_PORTB_0_clk	=> BRAM_PORTB_0_clk,
				BRAM_PORTB_0_rst	=> BRAM_PORTB_0_rst,
                BRAM_PORTB_0_addr   => BRAM_PORTB_0_addr,
                BRAM_PORTB_0_din    => BRAM_PORTB_0_din,
                BRAM_PORTB_0_dout   => BRAM_PORTB_0_dout,
                BRAM_PORTB_0_en     => BRAM_PORTB_0_en,
                BRAM_PORTB_0_we     => BRAM_PORTB_0_we
            );

        AXI_Slave_4regs: axi_regs
            generic map
            (
                maxcount => maxcount,
    		    C_S_AXI_DATA_WIDTH	=> C_S_AXI_DATA_WIDTH,
    		    C_S_AXI_ADDR_WIDTH	=> C_S_AXI_ADDR_WIDTH
            )
            port map
            (
                start           => start       , 
                running         => running     , 
                ready           => ready       , 
                total_shifts    => total_shifts, 
                S_AXI_ACLK	    =>  S_AXI_ACLK, 
                S_AXI_ARESETN   => S_AXI_ARESETN,
                S_AXI_AWADDR	=>    S_AXI_AWADDR,	
                S_AXI_AWPROT	=>    S_AXI_AWPROT,	
                S_AXI_AWVALID   => S_AXI_AWVALID,
                S_AXI_AWREADY   => S_AXI_AWREADY,
                S_AXI_WDATA	    => S_AXI_WDATA	, 
                S_AXI_WSTRB	    => S_AXI_WSTRB	, 
                S_AXI_WVALID    => S_AXI_WVALID, 
                S_AXI_WREADY    => S_AXI_WREADY, 
                S_AXI_BRESP	    => S_AXI_BRESP	, 
                S_AXI_BVALID    => S_AXI_BVALID, 
                S_AXI_BREADY    => S_AXI_BREADY, 
                S_AXI_ARADDR    => S_AXI_ARADDR, 
                S_AXI_ARPROT    => S_AXI_ARPROT, 
                S_AXI_ARVALID   => S_AXI_ARVALID,
                S_AXI_ARREADY   => S_AXI_ARREADY,
                S_AXI_RDATA	    => S_AXI_RDATA	, 
                S_AXI_RRESP	    => S_AXI_RRESP	, 
                S_AXI_RVALID	=>    S_AXI_RVALID,	
                S_AXI_RREADY	=>    S_AXI_RREADY
            );

end My_FFT_IP;
