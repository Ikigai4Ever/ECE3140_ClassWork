--Name: Ty Ahrens 
--Date: 3/9/2025
--Purpose: Binary 2 bit number to seven segment counter program

library IEEE;
use IEEE.std_logic_1164.all;

entity hw4p6 is
    port(KEY : IN std_logic_vector(1 downto 0);
         SW : IN std_logic_vector(7 downto 0);
         HEX : OUT std_logic_vector(41 downto 0);
         decimalPoint : OUT std_logic_vector(5 downto 0));
end hw4p6;

architecture rtl of hw4p6 is
signal biInput : std_logic_vector(3 downto 0);
signal blank, dispHex, sevSegPoint : std_logic;
signal display : std_logic_vector(6 downto 0);
signal sevenSegmentPoint: std_logic_vector(5 downto 0);


    component bin2seg7 
        port(inData     :   IN std_logic_vector(3 downto 0);
             blanking, dispHex, dispPoint : IN std_logic; 
             segA, segB, segC, segD, segE, segF, segG, segPoint: OUT std_logic);
    end component;

    begin
	 
		process(KEY)
		begin
			if KEY(0) = '1' then        
				 blank <= '0'; 
			else 
				 blank <= '1';
			end if;
			
			if KEY(1) = '1' then   
				 dispHex <= '1';
			else 
				 dispHex <= '0';
			end if;
		end process;
		
		process (SW, display, sevSegPoint)
		begin
			
			biInput <= SW(3 downto 0);
			sevSegPoint <= SW(4);
			
			
			if SW(7 downto 5) = "000" then
				if sevSegPoint = '1' then
					decimalPoint <= "111110";
				else 
					decimalPoint <= "111111";
				end if;
				HEX(6 downto 0) <= display;
				HEX(13 downto 7) <= "1111111";
				HEX(20 downto 14) <= "1111111";
				HEX(27 downto 21) <= "1111111";
				HEX(34 downto 28) <= "1111111";
				HEX(41 downto 35) <= "1111111";
			elsif SW(7 downto 5) = "001" then
				if sevSegPoint = '1' then
					decimalPoint <= "111101";
				else 
					decimalPoint <= "111111";
				end if;
				HEX(6 downto 0) <= "1111111";
				HEX(13 downto 7) <= display;
				HEX(20 downto 14) <= "1111111";
				HEX(27 downto 21) <= "1111111";
				HEX(34 downto 28) <= "1111111";
				HEX(41 downto 35) <= "1111111";
			elsif SW(7 downto 5) = "010" then
				if sevSegPoint = '1' then
					decimalPoint <= "111011";
				else 
					decimalPoint <= "111111";
				end if;
				HEX(6 downto 0) <= "1111111";
				HEX(13 downto 7) <= "1111111";
				HEX(20 downto 14) <= display;
				HEX(27 downto 21) <= "1111111";
				HEX(34 downto 28) <= "1111111";
				HEX(41 downto 35) <= "1111111"; 
			elsif SW(7 downto 5) = "011" then
				if sevSegPoint = '1' then
					decimalPoint <= "110111";
				else 
					decimalPoint <= "111111";
				end if;
				HEX(6 downto 0) <= "1111111";
				HEX(13 downto 7) <= "1111111";
				HEX(20 downto 14) <= "1111111";
				HEX(27 downto 21) <= display;
				HEX(34 downto 28) <= "1111111";
				HEX(41 downto 35) <= "1111111";
			elsif SW(7 downto 5) = "100" then
				if sevSegPoint = '1' then
					decimalPoint <= "101111";
				else 
					decimalPoint <= "111111";
				end if;
				HEX(6 downto 0) <= "1111111";
				HEX(13 downto 7) <= "1111111";
				HEX(20 downto 14) <= "1111111";
				HEX(27 downto 21) <= "1111111";
				HEX(34 downto 28) <= display;
				HEX(41 downto 35) <= "1111111";							
			elsif SW(7 downto 5) = "101" then
				if sevSegPoint = '1' then
					decimalPoint <= "011111";
				else 
					decimalPoint <= "111111";
				end if;
				HEX(6 downto 0) <= "1111111";
				HEX(13 downto 7) <= "1111111";
				HEX(20 downto 14) <= "1111111";
				HEX(27 downto 21) <= "1111111";
				HEX(34 downto 28) <= "1111111";
				HEX(41 downto 35) <= display;
			elsif SW(7 downto 5) = "110" then
				if sevSegPoint = '1' then
					decimalPoint <= "010101";
				else 
					decimalPoint <= "111111";
				end if; 
				HEX(6 downto 0) <= "1111111";
				HEX(13 downto 7) <= display;
				HEX(20 downto 14) <= "1111111";
				HEX(27 downto 21) <= display;
				HEX(34 downto 28) <= "1111111";
				HEX(41 downto 35) <= display;
			else 
				if sevSegPoint = '1' then
					decimalPoint <= "000000";
				else 
					decimalPoint <= "111111";
				end if;
				HEX(6 downto 0) <= display;
				HEX(13 downto 7) <= display;
				HEX(20 downto 14) <= display;
				HEX(27 downto 21) <= display;
				HEX(34 downto 28) <= display;
				HEX(41 downto 35) <= display;
			end if;
		end process;

        U0: entity work.bin2seg7(behavioral) port map (inData => biInput,
                                                       dispHex => Key(1), blanking => not Key(0),
                                                       segA => display(6), segB => display(5), segC => display(4),
                                                       segD => display(3), segE => display(2), segF => display(1),
                                                       segG => display(0));

            
end rtl;