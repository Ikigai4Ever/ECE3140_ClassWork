-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture BENCH of testbench is 
    component grayToBinary is 
        port(w, x, y, z	: in std_logic;
             a, b, c, d, e, f, g : out std_logic);
    end component;

	signal I : std_logic_vector(3 downto 0);
    signal O : std_logic_vector(6 downto 0);
    
	begin 

    DUT0: grayToBinary port map (I(3), I(2), I(1), I(0), O(6), O(5), O(4), O(3), O(2), O(1), O(0)); 

    stimulus : process
    	begin
        	I <= "0000";
            wait for 10 ns;
            assert (O = "1111110") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0001";
            wait for 10 ns;
            assert (O = "0110000") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0011";
            wait for 10 ns;
            assert (O = "1101101") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0010";
            wait for 10 ns;
            assert (O = "1111001") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
        
            I <= "0110";
            wait for 10 ns;
            assert (O = "0101011") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0111";
            wait for 10 ns;
            assert (O = "1011011") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0101";
            wait for 10 ns;
            assert (O = "1011111") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0100";
            wait for 10 ns;
            assert (O = "1110000") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            
            I <= "1100";
            wait for 10 ns;
            assert (O = "1111111") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1101";
            wait for 10 ns;
            assert (O = "1111011") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1111";
            wait for 10 ns;
            assert (O = "0000000") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1110";
            wait for 10 ns;
            assert (O = "0000000") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            
            I <= "1010";
            wait for 10 ns;
            assert (O = "0000000") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1011";
            wait for 10 ns;
            assert (O = "0000000") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1001";
            wait for 10 ns;
            assert (O = "0000000") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1000";
            wait for 10 ns;
            assert (O = "0000000") report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            

            I <= "0000";
            
            report "Program Finished";
            wait;
            
    end process stimulus;                                                     
end architecture BENCH;

