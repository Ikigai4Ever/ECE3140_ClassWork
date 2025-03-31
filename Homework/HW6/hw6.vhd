\   
    Name: Ty Ahrens 
    Date: 3/30/2025
    Purpose: Interpret the left and right tilts of the accelerometer on board the
             DE10-LITE board and increment or decrement respectfully a counter. Then
             display the value on a 
\
library IEEE;
use IEEE.std_logic_1164.all;


--main program that controls what hex_displays are used and the data_x vector
entity hw6 is
    generic (n : natural := 12);    -- number of counter bits 
    generic (accel_bits : natural := 10);
    port(
        -- clock needed for accelerometer to work
        max10_clk : IN std_logic;

        -- accelerometer pins to send to ADXL
        GSENSOR_CS_N : OUT	STD_LOGIC;
		GSENSOR_SCLK : OUT	STD_LOGIC;
		GSENSOR_SDI  : INOUT	STD_LOGIC;
		GSENSOR_SDO  : INOUT	STD_LOGIC;

        -- directions the accelerometer can be tilted  
        data_x      : BUFFER STD_LOGIC_VECTOR(accel_bits downto 0);
        data_y      : BUFFER STD_LOGIC_VECTOR(accel_bits downto 0);
        data_z      : BUFFER STD_LOGIC_VECTOR(accel_bits downto 0);

        -- seven segment bits to be sent to 7segDecoder.vhd
        hex0, hex1, hex2 : OUT std_logic_vector(6 downto 0);

        -- counter definitions
        reset   : IN std_logic;
        dout    : OUT std_logic_vector(n-1 downto 0)
    );
end hw6;

architecture behavior of hw6 is 

    component ADXL345_hw6 is port(
		reset_n     : IN STD_LOGIC;
		clk         : IN STD_LOGIC;
		data_valid  : OUT STD_LOGIC;
		data_x      : OUT STD_LOGIC_VECTOR(15 downto 0);
		data_y      : OUT STD_LOGIC_VECTOR(15 downto 0);
		data_z      : OUT STD_LOGIC_VECTOR(15 downto 0);
		SPI_SDI     : OUT STD_LOGIC;
		SPI_SDO     : IN STD_LOGIC;
		SPI_CSN     : OUT STD_LOGIC;
		SPI_CLK     : OUT STD_LOGIC);
    end component;
	
	component bcd_7segment is port(
		BCDin : in STD_LOGIC_VECTOR (3 downto 0);
		Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    -- counter internal signals
    signal clk_i    : std_logic_vector(n-1 downto 0);   -- clock input for first d flip-flop
    signal q_i      : std_logic_vector(n-1 downto 0);   -- output signals from d flip-flops
    signal counter  : std_logic_vector(n-1 downto 0);   -- number of bits for counter

begin 

    --port map for accelerometer 
    U0 : ADXL345_hw6 port map('1', max10_clk, open, data_x, data_y, data_z, GSENSOR_SDI, GSENSOR_SDO, GSENSOR_CS_N, GSENSOR_SCLK);

    -- port map to display x-value onto seven segs 
    U1 : segDisp_hw6 port map (counter(n-9 downto n-12), hex0);
	U2 : segDisp_hw6 port map (counter(n-5 downto n-8), hex1);
    U3 : segDisp_hw6 port map (counter(n-1 downto n-4), hex 2);

    -- set the clocking due to the change in value of the previous value
    clk_i(0) <= max10_clk;
    clk_i(n-1 downto 1) <= q_i(n-1 downto 0);

    -- generate a 12-bit counter 
    gen_cnter : for i in 0 to n-1 generate
        -- description of the behavior of the counters
        counter_build : process(clk_i, reset)
        begin
        
        \    if reset = '1' then
                q_i(i) <= '1';
            elsif rising_edge(clk_i(i)) then
                q_i(i) <= not q_i(i);
            end if;
        \

            if reset = '1' then 
                counter <= (others => '0');
            
            elsif rising_edge(clk_i(i)) then
                if data_x < "1000000000" then   -- check to see if the accelerometer is tiliting right
                    counter <= counter + (conv_int(data_x) - 512) /10;
                elsif data_x > "1000000000" then    --check to see if the accelerometer is tilting left
                    counter <= counter - (512 - conv_int(data_x)) /10;
                end if;
            end if;

        end process counter_build;
    end generate;

    \
    --determine which direction the accelerometer is being tilted to
    adjust_val : process (max10_clk, reset)
    begin
        if reset = '1' then 
            counter <= (others => '0');
        elsif rising_edge(max10_clk) then
            if data_x < "1000000000" then
                counter <= counter + (conv_int(data_x) - 512) /10;
            elsif data_x > "1000000000" then 
                counter <= counter - (512 - conv_int(data_x)) /10;
            end if;
        end if;
    end process adjust_val;
    \
    
    dout <= not q_i; -- output the value of the counter to pins onboard
end behavior;