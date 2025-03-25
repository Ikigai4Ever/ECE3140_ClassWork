--Name: Ty Ahrens 
--Date: 3/23/2025
--Purpose: 

library IEEE;
use IEEE.std_logic_1164.all;

entity hw5p4 is 
    port(KEY    : IN std_logic_vector(1 downto 0);
         sevenSeg : IN std_logic_vector(6 downto 0);
         SW0     : IN std_logic;
         feedback_pin   : OUT std_logic);
end hw5p4;

architecture behavior of hw5p4 is 
    signal LFSR1 : std_logic_vector(3 downto 0) := "1001";
    signal LFSR2 : std_logic_vector(3 downto 0) := "1001";
    signal LFSR3 : std_logic_vector(3 downto 0) := "1001";
    signal LFSR4 : std_logic_vector(3 downto 0) := "1001";

    --signal assignments for PLL inClock and Clock
    signal inCLK, CLK : std_logic;

    --component for PLL CLK
	component hw5p4_CLK is
		port(inclk0 : IN std_logic;
             c0 : OUT std_logic);
	end component;
	 
	 
begin
    hw5p4_CLK PORT MAP (inclk0 => inCLK, c0 => CLK);
	
	 
	--use the Galois LFSRs in order to generate random numbers
    RAND_GENERATE : process(CLK, KEY, SW0)
    begin 
        if SW0 = '1' then
            --check to see if key0 is pressed to act as the clock
            if KEY(0) = '1' then
                --generate random for bit0 of PRNG
                LFSR1(0) <= LFSR1(1);
                LFSR1(1) <= LFSR1(2);
                LFSR1(2) <= LFSR1(3);
                LFSR1(3) <= LFSR1(3) xor LFSR1(2); 
            --if key1 is pressed, then set all for the bits in the LFSR
            elsif KEY(1) = '1' then 
                LFSR1 <= "1001";
                LFSR2 <= "1001";
                LFSR3 <= "1001";
                LFSR4 <= "1001";
            else 
                LFSR1 <= LFSR1;
            end if;
        
        --run this when the SW0 is toggled off 
        else
            --if key1 is pressed, then set all for the bits in the LFSR
            if KEY(1) = '1' then 
                LFSR1 <= "1001";
                LFSR2 <= "1001";
                LFSR3 <= "1001";
                LFSR4 <= "1001";
            
            --increment the LFSR every clock cycle
            elsif rising_edge(CLK) then
                --generate random for bit0 of PRNG
                LFSR1(0) <= LFSR1(1);
                LFSR1(1) <= LFSR1(2);
                LFSR1(2) <= LFSR1(3);
                LFSR1(3) <= LFSR1(3) xor LFSR1(2);

                --generate random for bit1 of PRNG
                LFSR2(0) <= LFSR2(1);
                LFSR2(1) <= LFSR2(2);
                LFSR2(2) <= LFSR2(3);
                LFSR2(3) <= LFSR2(3) xor LFSR2(1);

                --generate random for bit2 of PRNG
                LFSR3(0) <= LFSR3(1);
                LFSR3(1) <= LFSR3(2);
                LFSR3(2) <= LFSR3(3);
                LFSR3(3) <= LFSR3(2) xor LFSR3(0);

                --generate random for bit3 of PRNG
                LFSR4(0) <= LFSR4(1);
                LFSR4(1) <= LFSR4(2);
                LFSR4(2) <= LFSR4(3);
                LFSR4(3) <= LFSR4(1) xor LFSR4(0);
            end if;
        end if;
        
        --case statement to determine and write each hexidecimal number  
        --based on the value of LFSR1
        case LFSR1 is 
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
    end process;

    --send the last bit of LFSR1 to an LED
    feedback_pin <= LFSR1(0);

end behavior;
