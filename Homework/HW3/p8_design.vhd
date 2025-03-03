--Name: Ty Ahrens 
--Date: 3/2/2025
--Program: minimal sop circuit
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity hw3p8 is
  port (x, y, z  : IN std_logic;
        O        : OUT std_logic);
end hw3p8;

architecture struct1 of hw3p8 is
    signal node1, node2, not_y : std_logic;
    
    component not1 
        port(In1    : IN std_logic;
             Out1   : OUT std_logic);
    end component not1;

    component and2
        port(In1, In2   : IN std_logic;
             Out1       : OUT std_logic);
    end component and2;

    component or2
        port(In1, In2    : IN std_logic;
             Out1        : OUT std_logic);
    end component or2;

    begin   
        -- Invert two inputs
        U0: not1 port map (In1 => y, Out1 => not_y);
        
        -- Simplified expression
        U1: and2 port map (In1 => not_y, In2 => z, Out1 => node1);
        U2: and2 port map (In1 => x, In2 => y, Out1 => node2);
        U3: or2 port map (In1 => node1, In2 => node2, Out1 => O);    

end struct1;

architecture struct2 of hw3p8 is
    signal node1, node2, not_y : std_logic;    

    component inv_d1
        port(In1 : IN std_logic;
             Out1 : OUT std_logic);
    end component;

    component and2_d3
        port (In1, In2 : IN std_logic;
              Out1      : OUT std_logic);
    end component;

    component or2_d3
        port(In1, In2    : IN std_logic;
             Out1        : OUT std_logic);
    end component or2_d3;

    begin
        -- Invert two inputs
        U4: inv_d1 port map (In1 => y, Out1 => not_y);
            
        -- Simplified expression
        U5: and2_d3 port map (In1 => not_y, In2 => z, Out1 => node1);
        U6: and2_d3 port map (In1 => x, In2 => y, Out1 => node2);
        U7: or2_d3 port map (In1 => node1, In2 => node2, Out1 => O);

end struct2;

--------------------------------
-- Description of inv_d1 gate --
--------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity inv_d1 is
    port(In1 : IN std_logic;
        Out1 : OUT std_logic);
end inv_d1;

architecture rtl of inv_d1 is 
    begin 
        Out1 <= not In1 after 1 ns;
end architecture rtl; 

---------------------------------
-- Description of and2_d3 gate --
---------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity and2_d3 is
    port (In1, In2: IN std_logic;
            Out1  : OUT std_logic);
end and2_d3;

architecture rtl of and2_d3 is
    begin 
        Out1 <= In1 and In2 after 3 ns;
end architecture rtl;


--------------------------------
-- Description of or2_d3 gate --
--------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity or2_d3 is
    port(In1, In2    : IN std_logic;
            Out1        : OUT std_logic);
end or2_d3;

architecture rtl of or2_d3 is
    begin 
        Out1 <= In1 or In2 after 3 ns;
end architecture rtl;

--------------------------------------------------------------

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
-- Description of or2 gate --
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