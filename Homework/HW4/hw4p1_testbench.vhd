--Name: Ty Ahrens 
--Date: 3/11/2025
--Purpose: testbench for hw4p1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity hw4p1_testbench is
end hw4p1_testbench;

architecture behavior of hw4p1_testbench is

    signal SW : std_logic_vector(3 downto 0) := "0000";
    signal KEY0, KEY1         : std_logic := '0';
    signal LEDR0, LEDR9       : std_logic;

    component hw4p1_testbench
        port(SW3, SW2, SW1, SW0 : IN std_logic;
             KEY0, KEY1          : IN std_logic;
             LEDR0, LEDR9        : OUT std_logic);
    end component;

begin

    UUT: hw4p1_testbench port map(SW3 => SW(3), SW2 => SW(2), SW1 => SW(1), SW0 => SW(0),
                                  KEY0 => KEY0, KEY1 => KEY1, LEDR0 => LEDR0, LEDR9 => LEDR9);

    stimulus : process
    begin
        -- Test case 1: Default inputs (SW3-SW0 = 0000, KEY0 = '0', KEY1 = '0')
        SW <= "0000"; KEY0 <= '0'; KEY1 <= '0';
        wait for 10 ns;
        assert (LEDR0 = '0' and LEDR9 = '0') report "Test Case 1 Failed!";
        
        -- Test case 2: KEY0 pressed (blank LEDs)
        KEY0 <= '1';
        wait for 10 ns;
        assert (LEDR0 = '0' and LEDR9 = '0') report "Test Case 2 Failed!";

        -- Test case 3: KEY1 pressed, inputs SW3-SW0 = 0000
        KEY0 <= '0'; KEY1 <= '1';
        wait for 10 ns;
        assert (LEDR0 = '0' and LEDR9 = '0') report "Test Case 3 Failed!";

        -- Test case 4: KEY1 pressed, inputs SW3-SW0 = 1111 (complemented)
        SW <= "1111";
        wait for 10 ns;
        assert (LEDR0 = '1' and LEDR9 = '1') report "Test Case 4 Failed!";

        -- Test case 5: Test different combinations of SW3-SW0
        SW <= "1010";
        wait for 10 ns;
        assert (LEDR0 = '1' and LEDR9 = '1') report "Test Case 5 Failed!";

        -- Test case 6: All SW inputs high (SW3-SW0 = 1111)
        SW <= "1111";
        wait for 10 ns;
        assert (LEDR0 = '1' and LEDR9 = '1') report "Test Case 6 Failed!";

        -- Test case 7: Test the logic when KEY0 is not pressed (KEY0 = '0')
        KEY0 <= '0'; KEY1 <= '0';
        wait for 10 ns;
        assert (LEDR0 = '0' and LEDR9 = '0') report "Test Case 7 Failed!";


        wait;
    end process;
end behavior;
