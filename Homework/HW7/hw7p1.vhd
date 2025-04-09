--      Name: Ty Ahrens 
--      Date: 4/6/2025
--      Purpose: 


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY hw7p1 IS
  PORT(
    max10_clk:  IN   STD_LOGIC;  --50 MHz clock from the DE10-Lite board
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END hw7p1;


ARCHITECTURE behavior OF hw7p1 IS
    constant chunk_width : integer := 7;
    constant chunk_height : integer := 7;    
BEGIN


  -- Display Logic
    PROCESS(disp_ena, row, column)
        variable chunk_col : integer;
        variable chunk_row : integer;
        variable color : integer;
        variable r4, g4, b4 : integer;
    BEGIN
        IF(disp_ena = '1') THEN        --display time
            chunk_col := column / chunk_width;
            chunk_row := row / chunk_height;
            color := chunk_col + (chunk_row * 64); 

            IF color < 4096 THEN
                r4 := (color / 256) mod 16; -- 4 bits for red
                g4 := (color / 16) mod 16;  -- 4 bits for green
                b4 := color mod 16;         -- 4 bits for blue

                red <= std_logic_vector(to_unsigned(r4, 4));
                green <= std_logic_vector(to_unsigned(g4, 4));
                blue <= std_logic_vector(to_unsigned(b4, 4));
            ELSE
                red <= (OTHERS => '0');
                green <= (OTHERS => '0');
                blue <= (OTHERS => '0');
            END IF;    
        ELSE                           --blanking time
            red <= (OTHERS => '0');
            green <= (OTHERS => '0');
            blue <= (OTHERS => '0');
        END IF;

END PROCESS;

END behavior;




