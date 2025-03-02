-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture BENCH of testbench is 
	signal I : std_logic_vector(3 downto 0);
    signal O : std_logic_vector(3 downto 0);
    
	begin 
    
    stimulus : process
    	begin
        	I <= "0000";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "0001";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "0011";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "0010";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            
            I <= "0110";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "0111";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "0101";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "0100";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            
            I <= "1100";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "1101";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "1111";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "1110";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            
            I <= "1010";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "1011";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "1001";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            I <= "1000";
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            wait for 10ns;
            report "The output is " & std_logic'image(O(3)) & std_logic'image(O(2)) & std_logic'image(O(1)) & std_logic'image(O(0));
            I <= "0000";
            
            report "Program Finished";
            wait;
            
    end process stimulus;
         
	DUT0: entity work.grayToBinary port map (I(3), I(2), I(1), I(0), O(3), O(2), O(1), O(0)); 
                                                     
end architecture BENCH;
