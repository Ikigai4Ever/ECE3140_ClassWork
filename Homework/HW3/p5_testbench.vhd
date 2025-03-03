-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture BENCH of testbench is 
    component grayToBinary is 
        port(w, x, y, z	: in std_logic;
             A, B, C, D	: out std_logic);
    end component;

	signal I : std_logic_vector(3 downto 0);
    signal O : std_logic_vector(3 downto 0);
    
	begin 

    DUT0: twosCompliment port map (I(3), I(2), I(1), I(0), O(3), O(2), O(1), O(0)); 

    stimulus : process
    	begin
        	I <= "0000";
            wait for 10 ns;
            assert (O = "0000") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0001";
            wait for 10 ns;
            assert (O = "1111") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0010";
            wait for 10 ns;
            assert (O = "1110") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0011";
            wait for 10 ns;
            assert (O = "1101") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
        
            I <= "0100";
            wait for 10 ns;
            assert (O = "1100") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0101";
            wait for 10 ns;
            assert (O = "1011") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0110";
            wait for 10 ns;
            assert (O = "1010") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0111";
            wait for 10 ns;
            assert (O = "1001") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            
            I <= "1000";
            wait for 10 ns;
            assert (O = "1000") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));

            I <= "0000";
            
            report "Program Finished";
            wait;
            
    end process stimulus;                                                     
end architecture BENCH;
