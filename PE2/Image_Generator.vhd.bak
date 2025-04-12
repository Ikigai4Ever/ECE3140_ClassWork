library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity hw_image_generator is
    port (
        disp_ena : in  STD_LOGIC;
        row      : in  INTEGER;
        column   : in  INTEGER;
	    RE_Val	 : in  integer;
        red      : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
        green    : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
        blue     : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0')
    );
end hw_image_generator;

architecture behavior of hw_image_generator is

    constant block_width   : integer := 40;
    constant block_height  : integer := 15;
    constant block_width_spacing : integer := 5;
    constant block_height_spacing : integer := 4; 


	constant paddle_top     : integer := 450;
    constant paddle_bottom  : integer := 460;
    constant paddle_left    : integer := 290;
    constant paddle_right   : integer := 350;
	constant paddle_width   : integer := 60;

    constant BORDER_TOP   : integer := 10;
    constant BORDER_LEFT  : integer := 9;
    constant BORDER_RIGHT : integer := 629;

    constant row1_top    : integer := block_height;
    constant row1_bottom : integer := row1_top + block_height;
    constant row2_top    : integer := row1_bottom + block_height_spacing;
    constant row2_bottom : integer := row2_top + block_height;

    constant column1_left   : integer := 13;
    constant column1_right  : integer := column1_left + block_width;
    constant column2_left   : integer := column1_right + block_width_spacing;
    constant column2_right  : integer := column2_left + block_width;
    constant column3_left   : integer := column2_right + block_width_spacing;
    constant column3_right  : integer := column3_left + block_width;
    constant column4_left   : integer := column3_right + block_width_spacing;
    constant column4_right  : integer := column4_left + block_width;
    constant column5_left   : integer := column4_right + block_width_spacing;
    constant column5_right  : integer := column5_left + block_width;
    constant column6_left   : integer := column5_right + block_width_spacing;
    constant column6_right  : integer := column6_left + block_width;
    constant column7_left   : integer := column6_right + block_width_spacing;
    constant column7_right  : integer := column7_left + block_width;
    constant column8_left   : integer := column7_right + block_width_spacing;
    constant column8_right  : integer := column8_left + block_width;
    constant column9_left   : integer := column8_right + block_width_spacing;
    constant column9_right  : integer := column9_left + block_width;
    constant column10_left  : integer := column9_right + block_width_spacing;
    constant column10_right : integer := column10_left + block_width;
    constant column11_left  : integer := column10_right + block_width_spacing;
    constant column11_right : integer := column11_left + block_width;
    constant column12_left  : integer := column11_right + block_width_spacing;
    constant column12_right : integer := column12_left + block_width;
    constant column13_left  : integer := column12_right + block_width_spacing;
    constant column13_right : integer := column13_left + block_width;
    constant column14_left  : integer := column13_right + block_width_spacing;
    constant column14_right : integer := column14_left + block_width;
	 

begin

    process(disp_ena, row, column, RE_Val)
        variable paddle_posL : integer;
        variable paddle_posR : integer;
    begin
        paddle_posL := (paddle_Left + RE_Val);
		paddle_posR := (paddle_posL + paddle_width);
			
			
		if row >= paddle_top and row <= paddle_bottom and column >= paddle_posL and column <= paddle_posR then
           red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
		end if;

    end process;
	 	 
    process(disp_ena, row, column, RE_Val)
		variable paddle_posL : integer;
		variable paddle_posR : integer;
    begin
        -- Default black background
        red   <= (others => '0');
        green <= (others => '0');
        blue  <= (others => '0');

 
        -- First row blocks
        if row >= row1_top and row <= row1_bottom and column >= column1_left and column <= column1_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column2_left and column <= column2_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column3_left and column <= column3_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column4_left and column <= column4_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column5_left and column <= column5_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column6_left and column <= column6_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column7_left and column <= column7_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column8_left and column <= column8_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column9_left and column <= column9_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column10_left and column <= column10_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column11_left and column <= column11_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column12_left and column <= column12_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column13_left and column <= column13_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row1_top and row <= row1_bottom and column >= column14_left and column <= column14_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white

        -- Second row blocks
        elsif row >= row2_top and row <= row2_bottom and column >= column1_left and column <= column1_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column2_left and column <= column2_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column3_left and column <= column3_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column4_left and column <= column4_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column5_left and column <= column5_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column6_left and column <= column6_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column7_left and column <= column7_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column8_left and column <= column8_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column9_left and column <= column9_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column10_left and column <= column10_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column11_left and column <= column11_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column12_left and column <= column12_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column13_left and column <= column13_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        elsif row >= row2_top and row <= row2_bottom and column >= column14_left and column <= column14_right then
            red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
        end if;

        
		      -- Border coloring
        if column <= BORDER_LEFT or column >= BORDER_RIGHT then
            red   <= X"EF";
            green <= X"EF";
            blue  <= X"EF";
			end if;
        if row <= BORDER_TOP then
            red   <= X"EF";
            green <= X"EF";
            blue  <= X"EF";
		end if;

		
    end process;
end behavior;
