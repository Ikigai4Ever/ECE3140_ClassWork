--Name: Ty Ahrens 
--Date: 3/2/2025
--Program: BCD Seven Seg Encoder
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sevenSegEncoder is
    port(w, x, y, z : IN std_logic;
         a, b, c, d, e, f, g   : OUT std_logic);
end sevenSegEncoder;


architecture rtl of sevenSegEncoder is
    signal a1, a2, a3, a4 : std_logic;
    signal b1, b2, b3 : std_logic;
    signal c1, c2, c3 : std_logic;
    signal d1, d2, d3 : std_logic;
    signal e1, e2 : std_logic;
    signal f1, f2, f3, f4 : std_logic;
    signal g1, g2, g3, g4 : std_logic;
    signal not_w, not_x, not_y, not_z : std_logic;

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

    component or4
        port(In1, In2, In3, In4    : IN std_logic;
             Out1        : OUT std_logic);
    end component or4;

    component or3
        port(In1, In2, In3    : IN std_logic;
             Out1        : OUT std_logic);
    end component or3;

    component or2
        port(In1, In2    : IN std_logic;
             Out1        : OUT std_logic);
    end component or2;

    begin
        -- Create not of each input
        U0: not1 port map (In1 => w, Out1 => not_w);
        U1: not1 port map (In1 => x, Out1 => not_x);
        U2: not1 port map (In1 => y, Out1 => not_y);
        U3: not1 port map (In1 => z, Out1 => not_z);

        -- Output for a
        U4: and2 port map (In1 => not_w, In2 => y, Out1 => a1); -- w'y
        U5: and3 port map (In1 => w, In2 => not_x, In3 => not_y, Out1 => a2); -- wx'y'
        U6: and3 port map (In1 => not_w, In2 => x, In3 => z, Out1 => a3); -- w'xz
        U7: and3 port map (In1 => not_w, In2 => not_x, In3 => not_z, Out1 => a4); -- w'x'z'
        U8: or4 port map (In1 => a1, In2 => a2, In3 => a3, In4 => a4, Out1 => a);

        -- Output for b
        U9: and2 port map (In1 => not_w, In2 => not_x, Out1 => b1); -- w'x'
        U10: and3 port map (In1 => not_w, In2 => y, In3 => z, Out1 => b2); -- w'yz
        U11: and3 port map (In1 => not_w, In2 => not_y, In3 => not_z, Out1 => b3); -- w'y'z' 
        U12: or4 port map (In1 => b1, In2 => b2, In3 => b3, In4 => a2, Out1 => b);

        -- Output for c
        U13: and2 port map (In1 => not_w, In2 => z, Out1 => c1); -- w'z
        U14: and2 port map (In1 => not_x, In2 => not_y, Out1 => c2); -- x'y'
        U15: and3 port map (In1 => not_w, In2 => x, In3 => y, Out1 => c3); -- w'xy
        U16: or3 port map (In1 => c1, In2 => c2, In3 => c3, Out1 => c);

        -- Output for d
        U17: and2 port map (In1 => not_w, In2 => not_z, Out1 => d1); -- w'z'
        U18: and3 port map (In1 => not_w, In2 => not_x, In3 => y, Out1 => d2); -- w'x'y
        U19: and3 port map (In1 => not_w, In2 => x, In3 => not_y, Out1 => d3); -- w'xy'
        U20: or4 port map (In1 => d1, In2 => d2, In3 => d3, In4 => a2, Out1 => d);

        -- Output for e
        U21: and3 port map (In1 => not_w, In2 => y, In3 => not_z, Out1 => e1); -- w'yz'
        U22: and3 port map (In1 => not_x, In2 => not_y, In3 => not_z, Out1 => e2); -- x'y'z'
        U23: or2 port map (In1 => e1, In2 => e2, Out1 => e);

        -- Output for f
        U24: and3 port map (In1 => not_w, In2 => x, In3 => not_z, Out1 => f1); -- w'xz'
        U25: or4 port map (In1 => b3, In2 => d3, In3 => f1, In4 => a2, Out1 => f); 

        -- Output for g
        U26: or4 port map (In1 => d2, In2 => e1, In3 => d3, In4 => a2, Out1 => g);

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
-- Description of or4 gate  --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity or4 is  
    port (In1, In2, In3, In4 : IN std_logic;
          Out1          : OUT std_logic);
end or4;

architecture rtl of or4 is
    begin 
        Out1 <= In1 or In2 or In3 or In4;
end architecture rtl;

------------------------------
-- Description of or3 gate  --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity or3 is  
    port (In1, In2, In3 : IN std_logic;
          Out1          : OUT std_logic);
end or3;

architecture rtl of or2 is
    begin 
        Out1 <= In1 or In2 or In3;
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