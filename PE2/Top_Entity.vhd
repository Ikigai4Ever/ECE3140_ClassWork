--Name: Ty Ahrens 
--Date: 4/13/2025
--Purpose: Top-level entity for the VGA image generator and Fibonacci sequence display
--         Integrates VGA image generation with Fibonacci computation and 7-segment display
--
-- Author: Based on work by Tyler McCormick and extended
-- Date: 2025-04-08

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_entity is
    Port (
        -- Clocks and control
        CLK         : in  STD_LOGIC;
        KEY0        : in  STD_LOGIC;
		KEY1 	    : in  STD_LOGIC;
		  
        ChA         : in  STD_LOGIC; -- CLK on RE
        ChB         : in  STD_LOGIC; -- DT on RE

        -- 7-Segment Display
        HEX0        : out STD_LOGIC_VECTOR(6 downto 0);
        HEX1        : out STD_LOGIC_VECTOR(6 downto 0);
        HEX2        : out STD_LOGIC_VECTOR(6 downto 0);
        HEX3        : out STD_LOGIC_VECTOR(6 downto 0);
        HEX4        : out STD_LOGIC_VECTOR(6 downto 0);
        HEX5        : out STD_LOGIC_VECTOR(6 downto 0);

        -- VGA Outputs
        h_sync_m    : out STD_LOGIC;
        v_sync_m    : out STD_LOGIC;
        red_m       : out STD_LOGIC_VECTOR(7 downto 0);
        green_m     : out STD_LOGIC_VECTOR(7 downto 0);
        blue_m      : out STD_LOGIC_VECTOR(7 downto 0)
    );
end top_entity;

architecture Behavioral of top_entity is

    constant paddle_movl  : integer := 40;
    constant paddle_movr  : integer := 600;

    -- Fibonacci Signals
    signal fib0, fib1 : unsigned(31 downto 0) := (others => '0');
    signal digit0, digit1, digit2, digit3, digit4, digit5 : integer;
    signal clk_div    : integer := 0;
    signal tick       : std_logic := '0';
    signal tick_pulse : std_logic := '0';

    constant CLK_FREQ      : integer := 50000000; -- 50 MHz
    constant FORWARD_TICKS : integer := CLK_FREQ;
    constant REVERSE_TICKS : integer := CLK_FREQ * 4 / 10;

    -- VGA Signals
    signal pll_out_clk : std_logic;
    signal dispEn      : std_logic;
    signal rowSignal   : integer;
    signal colSignal   : integer;

    -- Paddle Position from Rotary Encoder
    signal encoder_value: integer := 320;
	signal prevA	    : STD_LOGIC := '0';
	signal prevB        : STD_LOGIC := '0';
    signal ChA_clean    : STD_LOGIC := '0';
    signal ChB_clean    : STD_LOGIC := '0';
    constant mov_speed : integer := 20; 
    constant paddle_start_x : integer := 320;
    constant border_right : integer := 630; -- Value from the image generator
    constant border_left  : integer := 10;  -- Value from the image generator
    constant paddle_length : integer := 50; -- Paddle length
    
    constant DEBOUNCE_DELAY : integer := 5; -- Reduced debounce delay for responsiveness
    signal debounce_counter : integer := 0;
    signal rate_limit_counter : integer := 0;
    constant RATE_LIMIT : integer := 1; -- Reduced rate limit for smoother operation
	 

    -- 7-seg decoder
    component seg7_decoder is
        port(
            fib_number  : IN integer; -- Input from Fibonacci counter
            HEX         : OUT std_logic_vector(6 downto 0)    -- seven segment output   
            );
    end component;

    -- VGA Components
    component vga_pll_25_175
        port (
            inclk0 : in  STD_LOGIC := '0';
            c0     : out STD_LOGIC
        );
    end component;

    -- VGA Controller component
    component vga_controller
        port (
            pixel_clk : in  STD_LOGIC;
            reset_n   : in  STD_LOGIC;
            h_sync    : out STD_LOGIC;
            v_sync    : out STD_LOGIC;
            disp_ena  : out STD_LOGIC;
            column    : out INTEGER;
            row       : out INTEGER;
            n_blank   : out STD_LOGIC;
            n_sync    : out STD_LOGIC
        );
    end component;

    -- Image generator from homework 7
    component hw_image_generator
        port (
            disp_ena        : in  STD_LOGIC;
            row             : in  INTEGER;
            column          : in  INTEGER;
            encoder_value   : in  INTEGER;
            fib1            : in  INTEGER;
            fib2            : in  INTEGER;
            red             : out STD_LOGIC_VECTOR(7 downto 0);
            green           : out STD_LOGIC_VECTOR(7 downto 0);
            blue            : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin

    -- Fibonacci number digit divider
    fib_digits : process(CLK)
        variable temp : integer;
    begin 
        if rising_edge(CLK) then
            temp := to_integer(fib0);
            
            -- Calculate the digits of the Fibonacci number
            digit0 <= temp mod 10; temp := temp / 10;
            digit1 <= temp mod 10; temp := temp / 10;
            digit2 <= temp mod 10; temp := temp / 10;
            digit3 <= temp mod 10; temp := temp / 10;
            digit4 <= temp mod 10; temp := temp / 10;
            digit5 <= temp mod 10; 
        end if;
    end process;
    

    -- Fibonacci Clock Divider
    fib_direction : process(CLK)
    begin
        if rising_edge(CLK) then
            clk_div <= clk_div + 1;
            if (KEY0 = '1' and clk_div >= FORWARD_TICKS) or
               (KEY0 = '0' and clk_div >= REVERSE_TICKS) then
                tick <= '1';
                clk_div <= 0;
            else
                tick <= '0';
            end if;
        end if;
    end process;

    tick_fib : process(CLK)
    begin
        if rising_edge(CLK) then
            tick_pulse <= tick;
        end if;
    end process;

    calculate_fib : process(CLK)
        variable next_fib : unsigned(31 downto 0);
    begin
        if rising_edge(CLK) then
            if tick_pulse = '1' then
                if fib0 = 0 and fib1 = 0 then
                    fib0 <= to_unsigned(0, 32);
                    fib1 <= to_unsigned(1, 32);
                elsif KEY0 = '1' then
                    next_fib := fib0 + fib1;
                    if next_fib <= to_unsigned(999999, 32) then
                        fib0 <= fib1;
                        fib1 <= next_fib;
                    else
                        fib0 <= to_unsigned(0, 32);
                        fib1 <= to_unsigned(1, 32);
                    end if;
                else
                    if fib1 > fib0 then
                        next_fib := fib1 - fib0;
                        fib1 <= fib0;
                        fib0 <= next_fib;
                    else
                        fib0 <= to_unsigned(0, 32);
                        fib1 <= to_unsigned(1, 32);
                    end if;
                end if;
            end if;
        end if;
    end process;
    

--Rotary encoder process with debouncing, rate limiting, and clamping
--Rotary encoder process with optimized debouncing and rate limiting
process(CLK)
begin
    if rising_edge(CLK) then
        if KEY1 = '0' then
            encoder_value <= paddle_start_x;
            prevA <= '0';
        else
            -- Detect rising edge on ChA
            if (prevA = '0') and (ChA_clean = '1') then
                -- Determine direction using ChB
                if ChB_clean = '0' then  -- Clockwise
                    if (encoder_value < paddle_movr) and ((encoder_value + paddle_length) < border_right) then
                        encoder_value <= encoder_value + mov_speed;  -- Adjust movement speed
                    end if;
                else  -- Counter-clockwise
                    if (encoder_value > paddle_movl) and ((encoder_value - paddle_length) > border_left)  then
                        encoder_value <= encoder_value - mov_speed;
                    end if;
                end if;
            end if; 
            prevA <= ChA_clean;
        end if;
    end if;
end process;

    
    -- VGA Signal Routing
    U1: vga_pll_25_175 port map(CLK, pll_out_clk);
    U2: vga_controller port map(pll_out_clk, '1', h_sync_m, v_sync_m, dispEn, colSignal, rowSignal, open, open);
    U3: hw_image_generator port map(dispEn, rowSignal, colSignal, encoder_value, digit0, digit1, red_m, green_m, blue_m);
    
    -- Decoders for fibonacci numbers to seven segments
    decoder0: seg7_decoder
        port map(
            fib_number => digit0,
            HEX => HEX0
        );
    
    decoder1: seg7_decoder
        port map(
            fib_number => digit1,
            HEX => HEX1
        );
    
    decoder2: seg7_decoder
        port map(
            fib_number => digit2,
            HEX => HEX2
        );

    decoder3: seg7_decoder
        port map(
            fib_number => digit3,
            HEX => HEX3
        );

    decoder4: seg7_decoder
        port map(
            fib_number => digit4,
            HEX => HEX4
        );

    decoder5: seg7_decoder
        port map(
            fib_number => digit5,
            HEX => HEX5
        );


    -- Debouncers for the rortary encoder signals
    debounce_ChA: entity work.Debounce
        port map (
            clk   => CLK,
            noisy => ChA,
            clean => ChA_clean
        );

    debounce_ChB: entity work.Debounce
        port map (
            clk   => CLK,
            noisy => ChB,
            clean => ChB_clean
        );
end Behavioral;  
