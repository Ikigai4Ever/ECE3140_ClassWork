--      Name: Ty Ahrens 
--      Date: 4/8/2025
--      Purpose: 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY hw7p3 is
  port(
    clk      :  in   std_logic;  --50 MHz clock from the DE10-Lite board
    accel_x  :  in   std_logic_vector(15 downto 0); --x-axis acceleration data from accelerometer -512 to 511
    accel_y  :  in   std_logic_vector(15 downto 0); --y-axis acceleration data from accelerometer -512 to 511
    KEY      :  in   std_logic; --push button to reset the bar positions
    shift_red_left    : out std_logic;
    shift_red_right   : out std_logic;
    shift_green_left  : out std_logic;
    shift_green_right : out std_logic;
    ); 
end hw7p3;

ARCHITECTURE behavior OF hw7p3 IS
    SIGNAL x_pos : signed(15 downto 0); -- x-axis position of the bar
    SIGNAL y_pos : signed(15 downto 0); -- y-axis position of the bar
BEGIN 
    DISPLAY : PROCESS(clk)
    BEGIN
        IF risng_edge(clk) THEN
            IF KEY = '1' THEN 
                shift_red_left <= '0';
                shift_red_right <= '0'; 
                shift_green_left <= '0';
                shift_green_right <= '0';
            ELSE 
                x_pos <= signed(accel_x) / 16; -- scale down the x-axis acceleration
                y_pos <= signed(accel_y) / 16; -- scale down the y-axis acceleration

                -- x-intercept logic check of accelerometer data
                if (x_pos = 0) THEN 
                    shift_red_left <= '0';
                    shift_red_right <= '0';
                elsif (x_pos < 0) THEN
                    shift_red_left <= '1';
                    shift_red_right <= '0';
                else 
                    shift_red_left <= '0';
                    shift_red_right <= '1';
                end if;
                
                -- y-intercept logic check of accelerometer data
                if (y_int = 0) THEN 
                    shift_green_left <= '0';
                    shift_green_right <= '0';
                elsif (y_int < 0) THEN
                    shift_green_left <= '1';
                    shift_green_right <= '0';
                else 
                    shift_green_left <= '0';
                    shift_green_right <= '1';
                end if;
        END IF;
    END PROCESS;
end behavior;