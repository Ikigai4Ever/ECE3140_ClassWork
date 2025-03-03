--Name: Ty Ahrens 
--Date: 3/2/2025
--Program: Gray code to binary equivalent converter program for homework 3
library IEEE;
use IEEE.STD_LOGIC_1164.all;

--defining inputs and outputs
entity grayToBinary is 
port( w, x, y, z	: in std_logic;
  	  A, B, C, D	: out std_logic);
end grayToBinary;

architecture rtl of grayToBinary is
    signal nodeA, nodeB, nodeC, nodeD : std_logic;

    component xor2
        port(In1, In2   : IN std_logic;
             Out1       : OUT std_logic);
    end component xor2;

    begin
        -- Signal Assignment 
        A <= nodeA;
        B <= nodeB;
        C <= nodeC;
        D <= nodeD;

        -- Gray code to Binary 
        U0: xor2 port map (In1 => w, In2 => '1', Out1 => nodeA);
        U1: xor2 port map (In1 => x, In2 => nodeA, Out1 => nodeB);
        U2: xor2 port map (In1 => y, In2 => nodeB, Out1 => nodeC);
        U3: xor2 port map (In1 => z, In2 => nodeC, Out1 => nodeD);
            
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