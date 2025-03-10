--Name: Ty Ahrens 
--Date: 3/9/2025
--Purpose: Binary 2 bit number to seven segment counter program

library IEEE;
use IEEE.std_logic_1164.all;

entity bin2seg7 is
    port(inData     :   IN std_logic_vector(3 downto 0);
         blanking, dispHex, dispPoint : IN std_logic; 
         segA, segB, segC, segD, segE, segF, segG, segPoint : OUT std_logic);
end bin2seg7;

architecture behavioral of bin2seg7 is
    signal sevenSeg : std_logic_vector(6 downto 0);

begin 

		process (inData, blanking, dispHex, dispPoint)
		
		begin
        if blanking = '1' then
            sevenSeg <= "1111111";
            segPoint <= '1';
        else
            --sevenSeg 0 to 9 and a to f
            if dispHex = '1' then   
                case inData is 
                    when "0000" =>
                       sevenSeg <= "0000001" ; -- 0
                    when "0001" =>
                       sevenSeg <= "1001111" ; -- 1
                    when "0010" =>
                       sevenSeg <= "0010010" ;  -- 2
                    when "0011" =>
                        sevenSeg <= "0000110" ; -- 3
                    when "0100" =>
                        sevenSeg <= "1001100" ; -- 4
                    when "0101" =>
                        sevenSeg <= "0100100" ; -- 5
                    when "0110" =>
                        sevenSeg <= "0100000" ; -- 6
                    when "0111" =>
                        sevenSeg <= "0001111" ; -- 7
                    when "1000" =>
                        sevenSeg <= "0000000" ; -- 8
                    when "1001" =>
                        sevenSeg <= "0001100" ; -- 9
                    when "1010" =>
                        sevenSeg <= "0001000";  -- A
                    when "1011" =>
                        sevenSeg <= "1100000";  -- B
                    when "1100" => 
                        sevenSeg <= "0110001";  -- C
                    when "1101" =>
                        sevenSeg <= "1000010";  -- D
                    when "1110" => 
                        sevenSeg <= "0110000";  -- E
                    when "1111" =>
                        sevenSeg <= "0111000";  -- F
                    when others =>
                        sevenSeg <= "1111111";  -- Blank
                END CASE;
            else 
                --only sevenSeg 0 to 9
                case inData is
                    when "0000" =>
                        sevenSeg <= "0000001" ; -- 0
                    when "0001" =>
                        sevenSeg <= "1001111" ; -- 1
                    when "0010" =>
                       sevenSeg <= "0010010" ;  -- 2
                    when "0011" =>
                        sevenSeg <= "0000110" ; -- 3
                    when "0100" =>
                        sevenSeg <= "1001100" ; -- 4
                    when "0101" =>
                        sevenSeg <= "0100100" ; -- 5
                    when "0110" =>
                        sevenSeg <= "1100000" ; -- 6
                    when "0111" =>
                        sevenSeg <= "0001111" ; -- 7
                    when "1000" =>
                        sevenSeg <= "0000000" ; -- 8
                    when "1001" =>
                        sevenSeg <= "0001100" ; -- 9
                    when others =>
                        sevenSeg <= "1111111";  -- Blank
                END CASE;
            end if;
				
				if dispPoint = '1' then
					segPoint <= '1';
				else 	
					segPoint <= '0';
				end if;

				
        end if;
    end process;
	 -- address each segment to a bit in the sevenSeg vector
	  segA <= sevenSeg(0);
	  segB <= sevenSeg(1);
	  segC <= sevenSeg(2);
	  segD <= sevenSeg(3);
	  segE <= sevenSeg(4);
	  segF <= sevenSeg(5);
	  segG <= sevenSeg(6);
end behavioral;