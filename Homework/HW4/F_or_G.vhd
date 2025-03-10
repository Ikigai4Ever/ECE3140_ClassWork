--Name: Ty Ahrens 
--Date: 3/9/2025
--Program: Problem 4.2 from Mano & Ciletti text
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity F_or_G is
    port(A, B, C, D : IN std_logic;
         F, G       : OUT std_logic);
end F_or_G;


architecture rtl of F_or_G is
    component A3
        port(In1, In2, In3  : IN std_logic;
             O           : OUT std_logic);
    end component A3;

    component A2
        port(In1, In2   : IN std_logic;
             O       : OUT std_logic);
    end component A2;

    component not1 
        port(In1    : IN std_logic;
             O   : OUT std_logic);
    end component not1;

    component R2
        port(In1, In2    : IN std_logic;
             O        : OUT std_logic);
    end component R2;
	 
    signal o_F, o_G, nodeA_NOT, nodeD_NOT, node1, node2F, node2G : std_logic;


    begin   
        -- Signal assignment 
        F <= o_F;
        G <= o_G;

        U0: not1 port map (In1 => A, O => nodeA_NOT);
        U1: not1 port map (In1 => D, O => nodeD_NOT);
        
        -- Function F
        U2: A3 port map (In1 => A, In2 => B, In3 => C, O => node1);
        U3: A2 port map (In1 => nodeA_NOT, In2 => D, O => node2F);
        U4: R2 port map (In1 => node1, In2 => node2F, O => o_F);
        
        --Function G
        U5: A2 port map (In1 => nodeA_NOT, In2 => nodeD_NOT, O => node2G);
        U6: R2 port map (In1 => node1, In2 => node2G, O => o_G);

end rtl;

------------------------------
-- Description of and3 gate --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity A3 is  
    port (In1, In2, In3 : IN std_logic;
          O          : OUT std_logic);
end A3;

architecture rtl of A3 is
    begin 
        O <= In1 and In2 and In3;
end architecture rtl;

------------------------------
-- Description of and2 gate --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity A2 is  
    port (In1, In2 : IN std_logic;
          O     : OUT std_logic);
end A2;

architecture rtl of A2 is
    begin 
        O <= In1 and In2;
end architecture rtl;

------------------------------
-- Description of or2 gate  --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity R2 is  
    port (In1, In2 : IN std_logic;
          O     : OUT std_logic);
end R2;

architecture rtl of R2 is
    begin 
        O <= In1 or In2;
end architecture rtl;

------------------------------
-- Description of not gate  --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity not1 is  
    port (In1   : IN std_logic;
          O  : OUT std_logic);
end not1;

architecture rtl of not1 is
    begin 
        O <= not In1;
end architecture rtl;

