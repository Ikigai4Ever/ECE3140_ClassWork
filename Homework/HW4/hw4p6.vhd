--Name: Ty Ahrens 
--Date: 3/9/2025
--Purpose: Binary 2 bit number to seven segment counter program

library IEEE;
use IEEE.std_logic_1164.all;

entity hw4p6 is
    port(SW : IN std_logic_vector(6 downto 0);
         display : OUT std_logic_vector(6 downto 0);
         decimalPoint : OUT std_logic);
end hw4p6;

architecture rtl of hw4p6 is 

        component bin2seg7
            port(inData     :   IN std_logic_vector(3 downto 0);
                 blanking, dispHex, dispPoint : IN std_logic; 
                 segA, segB, segC, segD, segE, segF, segG, segPoint: OUT std_logic);
        end component;

    begin
        U0: entity work.bin2seg7(behavioral) port map (inData(3) => SW(3), inData(2) => SW(2), inData(1) => SW(1), inData(0) => SW(0),
                                                       dispPoint => SW(4), dispHex => SW(5), blanking => SW(6),
                                                       segA => display(6), segB => display(5), segC => display(4),
                                                       segD => display(3), segE => display(2), segF => display(1),
                                                       segG => display(0), segPoint => decimalPoint);

end rtl;