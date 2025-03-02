-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture BENCH of testbench is 
	signal I : in std_logic_vector(3 downto 0);
    signal O : out std_logic_vector(3 downto 0);
    
	begin 
    
    stimulus : process
    	begin
        	I <= "0000";
            wait for 10ns;
            I <= "0001";
            wait for 10ns;
            I <= "0011";
            wait for 10ns;
            I <= "0010";
            wait for 10ns;
            I <= "0110";
            wait for 10ns;
            I <= "0111";
            wait for 10ns;
            I <= "0101";
            wait for 10ns;
            I <= "0100";
            wait for 10ns;
            I <= "1100";
            wait for 10ns;
            I <= "1101";
            wait for 10ns;
            I <= "1111";
            wait for 10ns;
            I <= "1110";
            wait for 10ns;
            I <= "1010";
            wait for 10ns;
            I <= "1011";
            wait for 10ns;
            I <= "1001";
            wait for 10ns;
            I <= "1000";
            wait for 10ns;
            
            wait;
            
    end process stimulus;
         
	DUT0: entity work.grayToBinary(Behavioral) port map (w <= I(3), x <= I(2), y <= I(1), z <= I(0), 
														 A <= O(3), B <= O(2), C <= O(1), D <= O(0)); 
                                                     
end architecture BENCH;
