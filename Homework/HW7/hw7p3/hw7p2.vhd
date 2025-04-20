library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity hw7p2 is
    port(
        max10_clk            : in  std_logic;  -- 50 MHz clock from the DE10-Lite board
        disp_ena             : in  std_logic;  -- display enable ('1' = display time, '0' = blanking time)
        row                  : in  integer;    -- row pixel coordinate
        column               : in  integer;    -- column pixel coordinate
        red                  : out std_logic_vector(3 downto 0);  -- red magnitude output to DAC
        green                : out std_logic_vector(3 downto 0);  -- green magnitude output to DAC
        blue                 : out std_logic_vector(3 downto 0);  -- blue magnitude output to DAC
        key                  : in  std_logic;  -- push button to reset the bar positions
        shift_red_left       : in  std_logic;  -- shift signal for red color (left)
        shift_red_right      : in  std_logic;  -- shift signal for red color (right)
        shift_green_left     : in  std_logic;  -- shift signal for green color (left)
        shift_green_right    : in  std_logic   -- shift signal for green color (right)
    );
end hw7p2;

architecture behavior of hw7p2 is
    signal red_shift_left, red_shift_right : std_logic := '0';
    signal green_shift_left, green_shift_right : std_logic := '0';
    signal red_color, green_color, blue_color : std_logic_vector(3 downto 0);

begin

    -- Shift logic for red and green colors
    process(max10_clk)
    begin
        if rising_edge(max10_clk) then
            -- Reset the shifts based on button press
            if (key = '1') then
                red_shift_left <= '0';
                red_shift_right <= '0';
                green_shift_left <= '0';
                green_shift_right <= '0';
            else
                red_shift_left <= shift_red_left;
                red_shift_right <= shift_red_right;
                green_shift_left <= shift_green_left;
                green_shift_right <= shift_green_right;
            end if;
        end if;
    end process;

    -- Generate red, green, blue values based on position and shifts
    process(row, column, disp_ena)
    begin
        if disp_ena = '1' then
            -- Default colors (simple bar pattern)
            if column < 160 then
                red_color <= "1111";  -- Full red
                green_color <= "0000";  -- No green
                blue_color <= "0000";  -- No blue
            elsif column < 320 then
                red_color <= "0000";  -- No red
                green_color <= "1111";  -- Full green
                blue_color <= "0000";  -- No blue
            elsif column < 480 then
                red_color <= "0000";  -- No red
                green_color <= "0000";  -- No green
                blue_color <= "1111";  -- Full blue
            else
                red_color <= "0000";  -- No red
                green_color <= "0000";  -- No green
                blue_color <= "0000";  -- No blue
            end if;

            -- Apply shifts based on accelerometer data
            if red_shift_left = '1' then
                -- Shift red component to the left (darken red)
                red_color <= "0111";  -- Slight red
            elsif red_shift_right = '1' then
                -- Shift red component to the right (increase red)
                red_color <= "1111";  -- Full red
            end if;

            if green_shift_left = '1' then
                -- Shift green component to the left (darken green)
                green_color <= "0111";  -- Slight green
            elsif green_shift_right = '1' then
                -- Shift green component to the right (increase green)
                green_color <= "1111";  -- Full green
            end if;
        else
            -- Blank the screen if not in display mode
            red_color <= "0000";
            green_color <= "0000";
            blue_color <= "0000";
        end if;
    end process;

    -- Output the final color components
    red <= red_color;
    green <= green_color;
    blue <= blue_color;

end behavior;
