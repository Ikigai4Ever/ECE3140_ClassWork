library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity hw_image_generator is
    port (
        disp_ena : in  STD_LOGIC;
        row      : in  INTEGER;
        column   : in  INTEGER;
	    RE_Val	  : in  integer;
        red      : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
        green    : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
        blue     : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0')
    );
end hw_image_generator;

architecture behavior of hw_image_generator is

	 constant paddle_top    : integer := 450;
    constant paddle_bottom : integer := 460;
    constant paddle_left    : integer := 290;
    constant paddle_right : integer := 350;
	 constant paddle_width : integer := 60;

    constant BORDER_TOP   : integer := 10;
    constant BORDER_LEFT  : integer := 9;
    constant BORDER_RIGHT : integer := 629;

    constant row1_top    : integer := 15;
    constant row1_bottom : integer := 30;
    constant row2_top    : integer := 34;
    constant row2_bottom : integer := 49;

    constant column1_left   : integer := 13;
    constant column1_right  : integer := 53;
    constant column2_left   : integer := 57;
    constant column2_right  : integer := 97;
    constant column3_left   : integer := 101;
    constant column3_right  : integer := 141;
    constant column4_left   : integer := 145;
    constant column4_right  : integer := 185;
    constant column5_left   : integer := 189;
    constant column5_right  : integer := 229;
    constant column6_left   : integer := 233;
    constant column6_right  : integer := 273;
    constant column7_left   : integer := 277;
    constant column7_right  : integer := 317;
    constant column8_left   : integer := 321;
    constant column8_right  : integer := 361;
    constant column9_left   : integer := 365;
    constant column9_right  : integer := 405;
    constant column10_left  : integer := 409;
    constant column10_right : integer := 449;
    constant column11_left  : integer := 453;
    constant column11_right : integer := 493;
    constant column12_left  : integer := 497;
    constant column12_right : integer := 537;
    constant column13_left  : integer := 541;
    constant column13_right : integer := 581;
    constant column14_left  : integer := 585;
    constant column14_right : integer := 625;
	 

begin
	 	 
    process(disp_ena, row, column, RE_Val)
		variable paddle_posL : integer;
		variable paddle_posR : integer;
    begin
        -- Default black background
        red   <= (others => '0');
        green <= (others => '0');
        blue  <= (others => '0');
		  
		  	paddle_posL := (paddle_Left + RE_Val);
			paddle_posR := (paddle_posL + paddle_width);
			
			
			if row >= paddle_top and row <= paddle_bottom and column >= paddle_posL and column <= paddle_posR then
           red <= X"FF"; green <= X"FF"; blue <= X"FF";  -- Bright white
			 end if;

 
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
