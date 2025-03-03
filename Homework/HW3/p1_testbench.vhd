library ieee;
use ieee.std_logic_1164.all;

entity testbench is 
end entity testbench;

architecture BENCH of testbench is 
    component F_or_G is 
        port(A, B, C, D : IN std_logic;
             F, G,      : OUT std_logic);
    end component;

    signal I : std_logic_vector(3 downto 0);
    signal F, G : std_logic;
    
	begin 
    
    DUT0: F_or_G port map (I(3), I(2), I(1), I(0), F, G);

    stimulus : process
    	begin
            I <= "0000";
            wait for 10 ns;
            assert ((F = '0') and (G = '1')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0001";
            wait for 10 ns;
            assert ((F='1') and (G = '0')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0010";
            wait for 10 ns;
            assert ((F='0') and (G = '1')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0011";
            wait for 10 ns;
            assert ((F='1') and (G = '0')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));

            I <= "0100";
            wait for 10 ns;
            assert ((F='0') and (G = '1')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0101";
            wait for 10 ns;
            assert ((F='1') and (G = '0')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0110";
            wait for 10 ns;
            assert ((F='0') and (G = '1')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "0111";
            wait for 10 ns;
            assert ((F='1') and (G = '0')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));

            I <= "1000";
            wait for 10 ns;
            assert ((F = '0') and (G = '0')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1001";
            wait for 10 ns;
            assert ((F = '0') and (G = '0')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1010";
            wait for 10 ns;
            assert ((F = '0') and (G = '0')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1011";
            wait for 10 ns;
            assert ((F = '0') and (G = '0')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));

            I <= "1100";
            wait for 10 ns;
            assert ((F = '0') and (G = '0')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1101";
            wait for 10 ns;
            assert ((F = '0') and (G = '0')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1110";
            wait for 10 ns;
            assert ((F = '1') and (G = '1')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "1111";
            wait for 10 ns;
            assert ((F = '1') and (G = '1')) report "Wrong input for " & std_logic'image(I(3)) & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));

            I <= "0000";
            report "Program Finished";
            wait;

    end process stimulus;

end architecture BENCH;