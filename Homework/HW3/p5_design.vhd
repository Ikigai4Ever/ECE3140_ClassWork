--Name: Ty Ahrens 
--Date: 3/2/2025
--Program: BCD Seven Seg Encoder
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity twosComplimenter is
  port (w, x, y, z  : IN std_logic;
        A, B, C, D  : OUT std_logic);
end twosComplimenter;

architecture rtl of twosComplimenter is 
    signal out_A, out_B, out_C, out_D : std_logic;
    signal node1, node2, node3, node4 : std_logic;

    component xor2
        port(In1, In2   : IN std_logic;
             Out1       : OUT std_logic);
    end component xor2;

    begin 
        -- Signal Assignment
        A <= out_A;
        B <= out_B;
        C <= out_C;
        D <= out_D; 

        -- Inverter of Each Input
        U0: xor2 port map (In1 => w, In2 => '1', Out1 => node1);
        U1: xor2 port map (In1 => x, In2 => '1', Out1 => node2);
        U2: xor2 port map (In1 => y, In2 => '1', Out1 => node3);
        U3: xor2 port map (In1 => z, In2 => '1', Out1 => node4); 

        -- Adder
        U4: xor2 port map (In1 => node1, In2 => node2, Out1 => out_D);
        U5: xor2 port map (In1 => node2, In2 => node3, Out1 => out_C);
        U6: xor2 port map (In1 => node3, In2 => node4, Out1 => out_B);
        U7: xor2 port map (In1 => node4, In2 => '1', Out1 => out_A);
        
end rtl;

------------------------------
-- Description of xor2 gate --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity xor2 is  
    port (In1, In2 : IN std_logic;
          Out1     : OUT std_logic);
end xor2;

architecture rtl of xor2 is
    begin 
        Out1 <= In1 xor In2;
end architecture rtl;