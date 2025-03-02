--Name: Ty Ahrens 
--Date: 3/1/2025
--Program: Gray code to binary equivalent converter program for homework 3
library IEEE;
use IEEE.STD_LOGIC_1164.all;

--defining inputs and outputs
entity grayToBinary is port(
  w, x, y, z	: in std_logic;
  A, B, C, D	: out std_logic);
end XOR2;

architecture Behavioral of grayToBinary is
begin 
    A <= w;
    B <= A xor x;
    C <= B xor y;
    D <= C xor z;
 end Behavioral;
