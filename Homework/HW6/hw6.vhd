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
    port(
        -- clock needed for accelerometer to work
        max10_clk : IN std_logic;

        -- accelerometer pins to send to ADXL
        GSENSOR_CS_N : OUT	STD_LOGIC;
		GSENSOR_SCLK : OUT	STD_LOGIC;
		GSENSOR_SDI  : INOUT	STD_LOGIC;
		GSENSOR_SDO  : INOUT	STD_LOGIC;

        -- seven segment bits to be sent to 7segDecoder.vhd
        hex0, hex1, hex2 : OUT std_logic_vector(6 downto 0);

        -- directions the accelerometer can be tilted  
        data_x      : BUFFER STD_LOGIC_VECTOR(15 downto 0);
		data_y      : BUFFER STD_LOGIC_VECTOR(15 downto 0);
		data_z      : BUFFER STD_LOGIC_VECTOR(15 downto 0)
    );
end hw6;

architecture behavior of hw6 is 

    component ADXL345_controller is port(
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



begin 

    --port map for accelerometer 
    U0 : ADXL345_controller port map('1', max10_clk, open, data_x, data_y, data_z, GSENSOR_SDI, GSENSOR_SDO, GSENSOR_CS_N, GSENSOR_SCLK);

    -- port map to display x-value onto seven segs 
    U1 : bcd_7segment port map (data_x(4 downto 0), hex0);
	U2 : bcd_7segment port map (data_x(9 downto 5), hex1);
    U3 : bcd_7segment port map (data_x(14 downto 10), hex 2);

end behavior;