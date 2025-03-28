
------------------------------------------------
-- Name: 4-bit testbench incrementer          --
-- Purpose: Process for testbench with 4-bits --
------------------------------------------------

architecture BENCH of testbench is 
	signal I : std_logic_vector(3 downto 0);
    signal O : std_logic;
    
	begin 
    
    stimulus : process
    	begin
            I <= "0000";
            wait for 10 ns;
            I <= "0001";
            wait for 10 ns;
            I <= "0010";
            wait for 10 ns;
            I <= "0011";
            wait for 10 ns;

            I <= "0100";
            wait for 10 ns;
            I <= "0101";
            wait for 10 ns;
            I <= "0110";
            wait for 10 ns;
            I <= "0111";
            wait for 10 ns;

            I <= "1000";
            wait for 10 ns;
            I <= "1001";
            wait for 10 ns;
            I <= "1010";
            wait for 10 ns;
            I <= "1011";
            wait for 10 ns;

            I <= "1100";
            wait for 10 ns;
            I <= "1101";
            wait for 10 ns;
            I <= "1110";
            wait for 10 ns;
            I <= "1111";
            wait for 10 ns;

            I <= "0000";
            report "Program Finished";
            wait;

    end process stimulus;

end architecture BENCH;

---------------------------------------------------------------------



---------------------------------------------------------------------
-- Name: 3-bit testbench incrementer
-- Purpose: Process for testbench with 3-bits and assert output

architecture BENCH of testbench is 
    signal I : std_logic_vector(2 downto 0);
    signal O : std_logic;

    begin 

    stimulus : process
        begin 
            I <= "000";
            wait for 10 ns;
            assert O = '1' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "001";
            wait for 10 ns;
            assert O = '1' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "010";
            wait for 10 ns;
            assert O = '1' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "011";
            wait for 10 ns;
            assert O = '0' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "100";
            wait for 10 ns;
            assert O = '1' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "101";
            wait for 10 ns;
            assert O = '0' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "110";
            wait for 10 ns;
            assert O = '1' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));
            I <= "111";
            wait for 10 ns;
            assert O = '0' report "Wrong input for " & std_logic'image(I(2)) & std_logic'image(I(1)) & std_logic'image(I(0));

            I <= "000";
            wait;

    end process stimulus;


end architecture BENCH;