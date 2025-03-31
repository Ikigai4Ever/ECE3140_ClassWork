library   ieee;
use       ieee.std_logic_1164.all;
use       IEEE.numeric_std.all;


entity accelerometer_top is 

	port(
	
		max10_clk      :    IN STD_LOGIC;
		
		GSENSOR_CS_N : OUT	STD_LOGIC;
		GSENSOR_SCLK : OUT	STD_LOGIC;
		GSENSOR_SDI  : INOUT	STD_LOGIC;
		GSENSOR_SDO  : INOUT	STD_LOGIC;
		
		dFix         : OUT STD_LOGIC_VECTOR(5 downto 0) := "111111";
		ledFix       : OUT STD_LOGIC_VECTOR(9 downto 0) := "0000000000";
		
		hex5         : OUT STD_LOGIC_VECTOR(6 downto 0);
		hex4         : OUT STD_LOGIC_VECTOR(6 downto 0);
		
		hex3         : OUT STD_LOGIC_VECTOR(6 downto 0);
		hex2         : OUT STD_LOGIC_VECTOR(6 downto 0);
		
		hex1         : OUT STD_LOGIC_VECTOR(6 downto 0);
		hex0         : OUT STD_LOGIC_VECTOR(6 downto 0);
		
		data_x      : BUFFER STD_LOGIC_VECTOR(15 downto 0);
		data_y      : BUFFER STD_LOGIC_VECTOR(15 downto 0);
		data_z      : BUFFER STD_LOGIC_VECTOR(15 downto 0)
		
	);
	
end accelerometer_top;

architecture accelerometer_top_structural of accelerometer_top is

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
		SPI_CLK     : OUT STD_LOGIC
		
    );
	
    end component;
	
	component bcd_7segment is port(
	
		BCDin : in STD_LOGIC_VECTOR (3 downto 0);
		Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0)
	
	);
	
	end component;
		
		signal co_to_iSPI_CLK, c1_to_iSPI_CLK_OUT, oRST_to_RESET : STD_LOGIC;
		
		--signal tempAddX : STD_LOGIC_VECTOR(15 downto 0);
		
		--signal tff : STD_LOGIC_VECTOR(15 downto 0) := "0000000011111111";
		
		--signal zFix : STD_LOGIC := '0';
		
begin

	

	U0 : ADXL345_controller port map('1', max10_clk, open, data_x, data_y, data_z, GSENSOR_SDI, GSENSOR_SDO, GSENSOR_CS_N, GSENSOR_SCLK);
	
	U1 : bcd_7segment port map (data_x(7 downto 4), hex4);
	U2 : bcd_7segment port map (data_x(11 downto 8), hex5);	
	
	U3 : bcd_7segment port map (data_y(7 downto 4), hex2);
	U4 : bcd_7segment port map (data_y(11 downto 8), hex3);
	
	U5 : bcd_7segment port map (data_z(7 downto 4), hex1);
	U6 : bcd_7segment port map (data_z(11 downto 8), hex0);
	
	--U1 : bcd_7segment port map (sw1, hex4);
	--U2 : bcd_7segment port map (sw2, hex5);

	--tempAddX <= std_logic_vector(unsigned(data_x) + "1111111111111111");

end accelerometer_top_structural;


