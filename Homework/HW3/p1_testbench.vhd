-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is    
end entity testbench;

architecture BENCH of testbench is 
    signal I : std_logic_vector(2 downto 0);
    signal O : std_logic;

    begin 

    stimulus : process
        begin 
            I <= "000";
            wait for 10 ns;
            I <= "001";
            wait for 10 ns;
            I <= "010";
            wait for 10 ns;
            I <= "011";
            wait for 10 ns;
            I <= "100";
            wait for 10 ns;
            I <= "101";
            wait for 10 ns;
            I <= "110";
            wait for 10 ns;
            I <= "111";
            wait for 10 ns;

            I <= "000";
            wait;

    end process stimulus;

    DUT: entity work.problem1 port map (I(2), I(1), I(0), O);

end architecture BENCH;

