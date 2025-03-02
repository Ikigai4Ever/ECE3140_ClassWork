--Name: Ty Ahrens 
--Date: 3/1/2025
--Program: Problem 4.2 from Mano & Ciletti text
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity problem1 is 
port (x, y, z   : IN std_logic;
      F         : OUT std_logic);
end problem1;

architecture rtl of problem1 is 
begin   
    F <= (x or y) nand z;
end rtl;

