--      Name: Ty Ahrens 
--      Date: 4/8/2025
--      Purpose: 

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY hw7p2 IS
  PORT(
    max10_clk:  IN   STD_LOGIC;  --50 MHz clock from the DE10-Lite board
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');   --blue magnitude output to DAC
    SW       :  IN  STD_LOGIC_VECTOR(2 downto 0)  := (others => '0')
    ); 
END hw7p2;


ARCHITECTURE behavior OF hw7p2 IS   
BEGIN
    -- Display Logic
    PROCESS(disp_ena, row, column, SW)
    BEGIN
        IF(disp_ena = '1') THEN  
            if SW = "000" then
                    red <= (OTHERS => '0');
                    green <= (OTHERS => '0');
                    blue <= (OTHERS => '0');
            elsif SW = "001" then
                    red <= (OTHERS => '0');
                    green <= (OTHERS => '0');
                    blue <= (OTHERS => '1');
            elsif SW = "010" then
                    red <= (OTHERS => '0');
                    green <= (OTHERS => '1');
                    blue <= (OTHERS => '0');
            elsif SW = "011" then
                    red <= (OTHERS => '0');
                    green <= (OTHERS => '1');
                    blue <= (OTHERS => '1');
            elsif SW = "100" then
                    red <= (OTHERS => '1');
                    green <= (OTHERS => '0');
                    blue <= (OTHERS => '0');
            elsif SW = "101" then
                    red <= (OTHERS => '1');
                    green <= (OTHERS => '0');
                    blue <= (OTHERS => '1');
            elsif SW = "110" then 
                    red <= (OTHERS => '1');
                    green <= (OTHERS => '1');
                    blue <= (OTHERS => '0');
            elsif SW = "111" then
                    red <= (OTHERS => '1');
                    green <= (OTHERS => '1');
                    blue <= (OTHERS => '1');
            END IF;
        ELSE 
            red <= (OTHERS => '0');
            green <= (OTHERS => '0');
            blue <= (OTHERS => '0');
        END IF;
    END PROCESS;
END behavior;




