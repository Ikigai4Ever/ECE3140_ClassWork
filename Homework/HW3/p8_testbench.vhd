--Name: Ty Ahrens 
--Date: 3/2/2025
--Program: minimal sop circuit
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity testbench is 
end testbench;

architecture BENCH of testbench is 

    component hw3p8 is 
        port(x, y, z  : IN std_logic;
              O        : OUT std_logic);
    end component;

    signal I : std_logic_vector(2 downto 0);
    signal O : std_logic;

    begin 

    DUT0: hw3p8 port map (I(2), I(1), I(0), O);

    stimulus : process
        begin 
            I <= "000";
            wait for 10 ns;
            assert O = '0' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "001";
            wait for 10 ns;
            assert O = '1' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "010";
            wait for 10 ns;
            assert O = '0' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "011";
            wait for 10 ns;
            assert O = '0' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "100";
            wait for 10 ns;
            assert O = '0' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "101";
            wait for 10 ns;
            assert O = '1' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "110";
            wait for 10 ns;
            assert O = '1' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "111";
            wait for 10 ns;
            assert O = '1' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));

            I <= "000";
            wait;

    end process stimulus;


end architecture BENCH;