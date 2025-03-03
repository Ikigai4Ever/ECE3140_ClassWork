--Name: Ty Ahrens 
--Date: 3/2/2025
--Program: Problem 4.2 from Mano & Ciletti text
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity F_or_G is
    port(A, B, C, D : IN std_logic;
         F, G       : OUT std_logic);
end F_or_G;


architecture rtl of F_or_G is
    signal out_F, out_G, nodeA_NOT, nodeD_NOT, node1, node2F, node2G : std_logic;

    component and3
        port(In1, In2, In3  : IN std_logic;
             Out1           : OUT std_logic);
    end component and3;

    component and2
        port(In1, In2   : IN std_logic;
             Out1       : OUT std_logic);
    end component and2;

    component not1 
        port(In1    : IN std_logic;
             Out1   : OUT std_logic);
    end component not1;

    component or2
        port(In1, In2    : IN std_logic;
             Out1        : OUT std_logic);
    end component or2;

    begin   
        -- Signal assignment 
        F <= out_F;
        G <= out_G;

        U0: not1 port map (In1 => A, Out1 => nodeA_NOT);
        U1: not1 port map (In1 => D, Out1 => nodeD_NOT);
        
        -- Function F
        U2: and3 port map (In1 => A, In2 => B, In3 => C, Out1 => node1);
        U3: and2 port map (In1 => nodeA_NOT, In2 => D, Out1 => node2F);
        U4: or2 port map (In1 => node1, In2 => node2F, Out1 => out_F);
        
        --Function G
        U5: and2 port map (In1 => nodeA_NOT, In2 => nodeD_NOT, Out1 => node2G);
        U6: or2 port map (In1 => node1, In2 => node2G, Out1 => out_G);

end rtl;

------------------------------
-- Description of and3 gate --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity and3 is  
    port (In1, In2, In3 : IN std_logic;
          Out1          : OUT std_logic);
end and3;

architecture rtl of and3 is
    begin 
        Out1 <= In1 and In2 and In3;
end architecture rtl;

------------------------------
-- Description of and2 gate --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity and2 is  
    port (In1, In2 : IN std_logic;
          Out1     : OUT std_logic);
end and2;

architecture rtl of and2 is
    begin 
        Out1 <= In1 and In2;
end architecture rtl;

------------------------------
-- Description of or2 gate  --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity or2 is  
    port (In1, In2 : IN std_logic;
          Out1     : OUT std_logic);
end or2;

architecture rtl of or2 is
    begin 
        Out1 <= In1 or In2;
end architecture rtl;

------------------------------
-- Description of not gate  --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity not1 is  
    port (In1   : IN std_logic;
          Out1  : OUT std_logic);
end not1;

architecture rtl of not1 is
    begin 
        Out1 <= not In1;
end architecture rtl;