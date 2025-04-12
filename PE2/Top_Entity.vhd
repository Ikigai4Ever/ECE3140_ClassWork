-- Combined Top-Level VHDL for VGA and Fibonacci Display
--
-- Integrates VGA image generation with Fibonacci computation and 7-segment display
--
-- Author: Based on work by Tyler McCormick and extended
-- Date: 2025-04-08

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity test is
    Port (
        -- Clocks and control
        CLK        : in  STD_LOGIC;
        KEY0       : in  STD_LOGIC; -- active-low reset/control
		  KEY1 		 : in  STD_LOGIC;
		  
        ChA        : in  STD_LOGIC; -- CLK on RE
        ChB        : in  STD_LOGIC; -- DT on RE

        -- 7-Segment Display
        HEX0       : out STD_LOGIC_VECTOR(6 downto 0);
        HEX1       : out STD_LOGIC_VECTOR(6 downto 0);
        HEX2       : out STD_LOGIC_VECTOR(6 downto 0);
        HEX3       : out STD_LOGIC_VECTOR(6 downto 0);
        HEX4       : out STD_LOGIC_VECTOR(6 downto 0);
        HEX5       : out STD_LOGIC_VECTOR(6 downto 0);

        -- VGA Outputs
        h_sync_m   : out STD_LOGIC;
        v_sync_m   : out STD_LOGIC;
        red_m      : out STD_LOGIC_VECTOR(7 downto 0);
        green_m    : out STD_LOGIC_VECTOR(7 downto 0);
        blue_m     : out STD_LOGIC_VECTOR(7 downto 0)
    );
end test;

architecture Behavioral of test is

    constant paddle_movl  : integer := -100;
    constant paddle_movr  : integer := 100;

    -- Fibonacci Signals
    signal fib0, fib1 : unsigned(31 downto 0) := (others => '0');
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
    signal RE_Val      : integer := 0;
	 signal prevA		  : STD_LOGIC := '0';
	 signal prevB       : STD_LOGIC := '0';
	 
    constant DEBOUNCE_DELAY : integer := 5; -- Reduced debounce delay for responsiveness
    signal debounce_counter : integer := 0;
    signal rate_limit_counter : integer := 0;
    constant RATE_LIMIT : integer := 1; -- Reduced rate limit for smoother operation
	 

    -- 7-segment decoder
    function to_7seg(d : integer) return std_logic_vector is
        variable seg : std_logic_vector(6 downto 0);
    begin
        case d is
            when 0 => seg := "1000000";
            when 1 => seg := "1111001";
            when 2 => seg := "0100100";
            when 3 => seg := "0110000";
            when 4 => seg := "0011001";
            when 5 => seg := "0010010";
            when 6 => seg := "0000010";
            when 7 => seg := "1111000";
            when 8 => seg := "0000000";
            when 9 => seg := "0010000";
            when others => seg := "1111111";
        end case;
        return seg;
    end function;

    -- Display Procedure
    procedure display_number(signal num : unsigned(31 downto 0);
                             signal HEX : out std_logic_vector(6 downto 0);
                             signal HEX1 : out std_logic_vector(6 downto 0);
                             signal HEX2 : out std_logic_vector(6 downto 0);
                             signal HEX3 : out std_logic_vector(6 downto 0);
                             signal HEX4 : out std_logic_vector(6 downto 0);
                             signal HEX5 : out std_logic_vector(6 downto 0)) is
        variable n : integer := to_integer(num);
        variable d0, d1, d2, d3, d4, d5 : integer;
    begin
        d0 := n mod 10; n := n / 10;
        d1 := n mod 10; n := n / 10;
        d2 := n mod 10; n := n / 10;
        d3 := n mod 10; n := n / 10;
        d4 := n mod 10; n := n / 10;
        d5 := n mod 10;

        HEX  <= to_7seg(d0);
        HEX1 <= to_7seg(d1);
        HEX2 <= to_7seg(d2);
        HEX3 <= to_7seg(d3);
        HEX4 <= to_7seg(d4);
        HEX5 <= to_7seg(d5);
    end procedure;

    -- VGA Components
    component vga_pll_25_175
        port (
            inclk0 : in  STD_LOGIC := '0';
            c0     : out STD_LOGIC
        );
    end component;

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

    component hw_image_generator
        port (
            disp_ena : in  STD_LOGIC;
            row      : in  INTEGER;
            column   : in  INTEGER;
            RE_Val   : in  integer;
            red      : out STD_LOGIC_VECTOR(7 downto 0);
            green    : out STD_LOGIC_VECTOR(7 downto 0);
            blue     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin

    -- Fibonacci Clock Divider
    process(CLK)
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

    process(CLK)
    begin
        if rising_edge(CLK) then
            tick_pulse <= tick;
        end if;
    end process;

    process(CLK)
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
	 
	 		--	if (ChA = '1' and ChB = '0') and RE_Val < paddle_movr then 
		--		RE_Val <= RE_Val + (1/4);
		--	elsif (ChB = '1' and ChA = '0') and RE_Val > paddle_movl then
		--		RE_Val <= RE_Val - (1/4);
		--	else 
		--		RE_Val <= RE_Val;
		--	end if;

--process(ChA, KEY1)
--		begin
--		if KEY1 = '0' then
--			RE_Val <= 0;
--		else
--			if rising_edge(ChA) then
--			if rising_edge(ChA) then
--				if (rising_edge(ChA) and ChB = '0') and RE_Val < paddle_movr then 
--					RE_Val <= RE_Val + 2;
				--else
					--RE_Val <= RE_Val;
--				elsif (rising_edge(ChA) and ChB = '1') and RE_Val > paddle_movl then 
--					RE_Val <= RE_Val - 2;
				--else
					--RE_Val <= RE_Val;
--				end if;
--			end if;
--			end if;
--		end if;
--	end process;

--process(pll_out_clk, ChA)
 --   begin
--			if rising_edge(ChA) then 
 --           if KEY1 = '0' then
 --              RE_Val <= 0;
--            else
                -- detect change in encoder A
--						 if ChA /= prevA then
--							prevA <= ChA;
--							prevB <= ChB;
--							if (ChA = prevB) and (RE_Val < paddle_movr) then 
--								RE_Val <= RE_Val + 1;
--							elsif (ChB = prevA) and (RE_Val > paddle_movl) then
--								RE_Val <= RE_Val - 1;
--							else 
--								RE_Val <= RE_Val;
--							end if;
--						 else 
--							prevA <= prevA;
--							prevB <= prevB;
--						
--						 end if;
--				end if;
--			end if;
--    end process;

--process(ChA)
	--begin
--	 if rising_edge(ChA) then
--		if KEY1 = '0' then
--         RE_Val <= 0;
 --     else
--			if (ChB = '1') and RE_Val < paddle_movr then
--				RE_Val <= RE_Val + 1;
--			elsif (ChB = '0') and RE_Val > paddle_movl then
--				RE_Val <= RE_Val - 1;
			--else 
				--RE_Val <= RE_Val;
--			end if;
--		end if;
--	end if;
--end process;

--Rotary encoder process with debouncing, rate limiting, and clamping
--Rotary encoder process with optimized debouncing and rate limiting
process(CLK)
begin
    if rising_edge(CLK) then
        if KEY1 = '0' then
            RE_Val <= 0;
        else
            -- Debouncing logic
            if debounce_counter < DEBOUNCE_DELAY then
                debounce_counter <= debounce_counter + 1;
            else
                debounce_counter <= 0;

                -- Rate limiting logic
                if rate_limit_counter < RATE_LIMIT then
                    rate_limit_counter <= rate_limit_counter + 1;
                else
                    rate_limit_counter <= 0;

                    -- Clockwise rotation detection
                    if (ChA = '1' and ChB = '0' and prevA = '0' and prevB = '0') or
                       (ChA = '1' and ChB = '1' and prevA = '1' and prevB = '0') or
                       (ChA = '0' and ChB = '1' and prevA = '1' and prevB = '1') or
                       (ChA = '0' and ChB = '0' and prevA = '0' and prevB = '1') then
                        if (RE_Val < paddle_movr) then
                            RE_Val <= RE_Val + 1;
                        end if;
                    -- Counter-clockwise rotation detection
                    elsif (ChA = '0' and ChB = '0' and prevA = '1' and prevB = '0') or
                          (ChA = '0' and ChB = '1' and prevA = '0' and prevB = '0') or
                          (ChA = '1' and ChB = '1' and prevA = '0' and prevB = '1') or
                          (ChA = '1' and ChB = '0' and prevA = '1' and prevB = '1') then
                        if (RE_Val > paddle_movl) then
                            RE_Val <= RE_Val - 1;
                        end if;
                    end if;
                end if;
            end if;

            -- Always update previous values
            prevA <= ChA;
            prevB <= ChB;
        end if;
    end if;
end process;

    -- Fibonacci Display
    process(fib0)
    begin
        display_number(fib0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    end process;

    -- VGA Signal Routing
    U1: vga_pll_25_175 port map(CLK, pll_out_clk);
    U2: vga_controller port map(pll_out_clk, '1', h_sync_m, v_sync_m, dispEn, colSignal, rowSignal, open, open);
    U3: hw_image_generator port map(dispEn, rowSignal, colSignal, RE_Val, red_m, green_m, blue_m);

end Behavioral;  
