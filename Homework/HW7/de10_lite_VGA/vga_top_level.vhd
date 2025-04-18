-- ECE 4110 VGA example
--
-- This code is the top level structural file for code that can
-- generate an image on a VGA display. The default mode is 640x480 at 60 Hz
--
-- Note: This file is not where the pattern/image is produced
--
-- Tyler McCormick 
-- 10/13/2019


library   ieee;
use       ieee.std_logic_1164.all;

entity vga_top is
	
	generic(	color : integer := 3);
	
	port(
	
		-- Inputs for image generation
		
		pixel_clk_m		:	IN	STD_LOGIC;     -- pixel clock for VGA mode being used 
		reset_n_m		:	IN	STD_LOGIC; --active low asycnchronous reset
		
		-- Outputs for image generation 
		
		h_sync_m		:	OUT	STD_LOGIC;	--horiztonal sync pulse
		v_sync_m		:	OUT	STD_LOGIC;	--vertical sync pulse 
		
		red_m      :  OUT  STD_LOGIC_VECTOR(color DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green_m    :  OUT  STD_LOGIC_VECTOR(color DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue_m     :  OUT  STD_LOGIC_VECTOR(color DOWNTO 0) := (OTHERS => '0'); --blue magnitude output to DAC

		switches_m : IN  STD_LOGIC_VECTOR(2 downto 0) := (others => '0'); -- switches for color selection
		key_m : IN  STD_LOGIC -- push button to reset the bar positions
	);
	
end vga_top;

architecture vga_structural of vga_top is

	component vga_pll_25_175 is 
	
		port(
		
			inclk0		:	IN  STD_LOGIC := '0';  -- Input clock that gets divided (50 MHz for max10)
			c0			:	OUT STD_LOGIC          -- Output clock for vga timing (25.175 MHz)
		
		);
		
	end component;
	
	component vga_controller is 
	
		port(
		
			pixel_clk	:	IN	STD_LOGIC;	--pixel clock at frequency of VGA mode being used
			reset_n		:	IN	STD_LOGIC;	--active low asycnchronous reset
			h_sync		:	OUT	STD_LOGIC;	--horiztonal sync pulse
			v_sync		:	OUT	STD_LOGIC;	--vertical sync pulse
			disp_ena		:	OUT	STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
			column		:	OUT	INTEGER;	--horizontal pixel coordinate
			row			:	OUT	INTEGER;	--vertical pixel coordinate
			n_blank		:	OUT	STD_LOGIC;	--direct blacking output to DAC
			n_sync		:	OUT	STD_LOGIC   --sync-on-green output to DAC
		
		);
		
	end component;
	
	component hw7p2 is
	
		port(
			
			max10_clk:  IN   STD_LOGIC;  --50 MHz clock from the DE10-Lite board
			disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
			row      :  IN   INTEGER;    --row pixel coordinate
			column   :  IN   INTEGER;    --column pixel coordinate
			KEY      :  IN   STD_LOGIC; --push button to reset the bar positions
			red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
			green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
			blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');   --blue magnitude output to DAC
			shift_red_left    : out std_logic;
			shift_red_right   : out std_logic;
			shift_green_left  : out std_logic;
			shift_green_right : out std_logic
		);
		
	end component;

	component hw7p3 is 

		port(

			clk      :  in   std_logic;  --50 MHz clock from the DE10-Lite board
			accel_x  :  in   std_logic_vector(15 downto 0); --x-axis acceleration data from accelerometer -512 to 511
			accel_y  :  in   std_logic_vector(15 downto 0); --y-axis acceleration data from accelerometer -512 to 511
			KEY      :  in   std_logic; --push button to reset the bar positions
			shift_red_left    : out std_logic;
			shift_red_right   : out std_logic;
			shift_green_left  : out std_logic;
			shift_green_right : out std_logic

		);
	
	end component;

	component accelerometer is 

		port (
	
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
	
	signal pll_OUT_to_vga_controller_IN, dispEn : STD_LOGIC;
	signal rowSignal, colSignal : INTEGER;
	
	
begin

-- Just need 3 components for VGA system 
	U1	:	vga_pll_25_175 port map(pixel_clk_m, pll_OUT_to_vga_controller_IN);
	U2	:	vga_controller port map(pll_OUT_to_vga_controller_IN, reset_n_m, h_sync_m, v_sync_m, dispEn, colSignal, rowSignal, open, open);
	--U3	:	hw7p1 port map(pixel_clk_m,dispEn, rowSignal, colSignal, red_m, green_m, blue_m);
	U4	:	hw7p2 port map(pixel_clk_m,dispEn, rowSignal, colSignal, red_m, green_m, blue_m, key_m, shift_red_left, shift_red_right, shift_green_left, shift_green_right);
	U5  : 	accelerometer port map(key_m, pixel_clk_m, open, data_x, data_y, open, open, open, open);
	U6  : 	hw7p3 port map(clk, data_x, data_x, key_m, shift_red_left, shift_red_right, shift_green_left, shift_green_right);

end vga_structural;