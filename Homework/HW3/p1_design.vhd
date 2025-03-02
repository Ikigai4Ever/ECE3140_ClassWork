--Name: Ty Ahrens 
--Date: 3/1/2025
--Program: Problem 4.2 from Mano & Ciletti text
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity or_nand is 
port (x, y, z   : IN std_logic;
      F         : OUT std_logic);
end or_nand;

architecture rtl of or_nand is 
    signal node1 : std_logic;    
    
    component or2
        port(In1, In2   :   IN std_logic;
             Out1      :   OUT std_logic);
    end component;

    component nand2
        port (In1, In2  :   IN std_logic;
              Out1      :   OUT std_logic);
    end component;
    
    begin

    U1: or2 port map (In1 => x, In2 => y, Out1 => node1);
    U2: nand2 port map (In1 => node1, In2 => z, Out1 => F); 

end rtl;


--Description of or2 gate
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity or2 is
    port (In1, In2  : IN std_logic;
          Out1      : OUT std_logic);
end or2;

architecture rtl of or2 is 
    begin        
        Out1 <= In1 or In2;
end architecture rtl;

--Descritption of nand gate
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nand2 is 
    port (In1, In2  : IN std_logic;
          Out1      : OUT std_logic);
end nand2;

architecture rtl of nand2 is 
    begin
        Out1 <= In1 nand In2;
end architecture rtl;

